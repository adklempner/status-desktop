import sugar, sequtils, stint
import uuids, chronicles, options
import io_interface
import app_service/service/wallet_account/service as wallet_account_service
import app_service/service/network/service as network_service
import app_service/service/transaction/service as transaction_service
import app_service/service/currency/service as currency_service
import app_service/service/currency/dto as currency_dto
import app_service/service/keycard/service as keycard_service
import app_service/service/network/network_item

import app/modules/shared_modules/keycard_popup/io_interface as keycard_shared_module
import app/modules/shared/wallet_utils
import app/modules/shared_models/currency_amount

import app/core/signals/types
import app/core/eventemitter

logScope:
  topics = "wallet-send-controller"

const UNIQUE_WALLET_SECTION_SEND_MODULE_IDENTIFIER* = "WalletSection-SendModule"

type
  Controller* = ref object of RootObj
    delegate: io_interface.AccessInterface
    events: EventEmitter
    walletAccountService: wallet_account_service.Service
    networkService: network_service.Service
    currencyService: currency_service.Service
    transactionService: transaction_service.Service
    keycardService: keycard_service.Service
    connectionKeycardResponse: UUID

proc newController*(
  delegate: io_interface.AccessInterface,
  events: EventEmitter,
  walletAccountService: wallet_account_service.Service,
  networkService: network_service.Service,
  currencyService: currency_service.Service,
  transactionService: transaction_service.Service,
  keycardService: keycard_service.Service
): Controller =
  result = Controller()
  result.delegate = delegate
  result.events = events
  result.walletAccountService = walletAccountService
  result.networkService = networkService
  result.currencyService = currencyService
  result.transactionService = transactionService
  result.keycardService = keycardService

proc delete*(self: Controller) =
  discard

proc init*(self: Controller) =
  self.events.on(SIGNAL_TRANSACTION_SENT) do(e:Args):
    let args = TransactionSentArgs(e)
    self.delegate.transactionWasSent(args.chainId, args.txHash, args.uuid, args.error)

  self.events.on(SIGNAL_OWNER_TOKEN_SENT) do(e:Args):
    let args = OwnerTokenSentArgs(e)
    self.delegate.transactionWasSent(args.chainId, args.txHash, args.uuid, "")

  self.events.on(SIGNAL_SHARED_KEYCARD_MODULE_USER_AUTHENTICATED) do(e: Args):
    let args = SharedKeycarModuleArgs(e)
    if args.uniqueIdentifier != UNIQUE_WALLET_SECTION_SEND_MODULE_IDENTIFIER:
      return
    self.delegate.onUserAuthenticated(args.password, args.pin)

  self.events.on(SIGNAL_SUGGESTED_ROUTES_READY) do(e:Args):
    self.delegate.suggestedRoutesReady(SuggestedRoutesArgs(e).suggestedRoutes)

  self.events.on(SignalType.Wallet.event) do(e:Args):
    var data = WalletSignal(e)
    if data.eventType != SignTransactionsEventType:
      return
    self.delegate.prepareSignaturesForTransactions(data.txHashes)

proc getWalletAccounts*(self: Controller): seq[wallet_account_service.WalletAccountDto] =
  return self.walletAccountService.getWalletAccounts()

proc getChainIds*(self: Controller): seq[int] =
  return self.networkService.getCurrentNetworks().map(n => n.chainId)

proc getEnabledChainIds*(self: Controller): seq[int] =
  return self.networkService.getCurrentNetworks().filter(n => n.isEnabled).map(n => n.chainId)

proc getCurrentCurrency*(self: Controller): string =
  return self.walletAccountService.getCurrency()

proc getCurrencyFormat*(self: Controller, symbol: string): CurrencyFormatDto =
  return self.currencyService.getCurrencyFormat(symbol)

proc getKeycardsWithSameKeyUid*(self: Controller, keyUid: string): seq[KeycardDto] =
  return self.walletAccountService.getKeycardsWithSameKeyUid(keyUid)

proc getAccountByAddress*(self: Controller, address: string): WalletAccountDto =
  return self.walletAccountService.getAccountByAddress(address)

proc getWalletAccountByIndex*(self: Controller, accountIndex: int): WalletAccountDto =
  return self.walletAccountService.getWalletAccount(accountIndex)

proc getTokenBalance*(self: Controller, address: string, chainId: int, tokensKey: string): CurrencyAmount =
  return currencyAmountToItem(self.walletAccountService.getTokenBalance(address, chainId, tokensKey), self.walletAccountService.getCurrencyFormat(tokensKey))

proc authenticate*(self: Controller, keyUid = "") =
  let data = SharedKeycarModuleAuthenticationArgs(uniqueIdentifier: UNIQUE_WALLET_SECTION_SEND_MODULE_IDENTIFIER,
    keyUid: keyUid)
  self.events.emit(SIGNAL_SHARED_KEYCARD_MODULE_AUTHENTICATE_USER, data)

proc suggestedRoutes*(self: Controller, accountFrom: string, accountTo: string, amount: Uint256, token: string, toToken: string,
  disabledFromChainIDs, disabledToChainIDs, preferredChainIDs: seq[int], sendType: SendType, lockedInAmounts: string) =
  self.transactionService.suggestedRoutes(accountFrom, accountTo, amount, token, toToken, disabledFromChainIDs,
    disabledToChainIDs, preferredChainIDs, sendType, lockedInAmounts)

proc transfer*(self: Controller, from_addr: string, to_addr: string, assetKey: string, toAssetKey: string,
    uuid: string, selectedRoutes: seq[TransactionPathDto], password: string, sendType: SendType,
    usePassword: bool, doHashing: bool, tokenName: string, isOwnerToken: bool,
    slippagePercentage: Option[float]) =
  self.transactionService.transfer(from_addr, to_addr, assetKey, toAssetKey, uuid, selectedRoutes, password, sendType,
    usePassword, doHashing, tokenName, isOwnerToken, slippagePercentage)

proc proceedWithTransactionsSignatures*(self: Controller, fromAddr: string, toAddr: string, uuid: string,
    signatures: TransactionsSignatures, selectedRoutes: seq[TransactionPathDto]) =
  self.transactionService.proceedWithTransactionsSignatures(fromAddr, toAddr, uuid, signatures, selectedRoutes)

proc areTestNetworksEnabled*(self: Controller): bool =
  return self.walletAccountService.areTestNetworksEnabled()

proc getTotalCurrencyBalance*(self: Controller, address: seq[string], chainIds: seq[int]): float64 =
  return self.walletAccountService.getTotalCurrencyBalance(address, chainIds)

proc getCurrentNetworks*(self: Controller): seq[NetworkItem] =
  return self.networkService.getCurrentNetworks()

proc getKeypairByAccountAddress*(self: Controller, address: string): KeypairDto =
  return self.walletAccountService.getKeypairByAccountAddress(address)

proc disconnectKeycardReponseSignal(self: Controller) =
  self.events.disconnect(self.connectionKeycardResponse)

proc connectKeycardReponseSignal(self: Controller) =
  self.connectionKeycardResponse = self.events.onWithUUID(SIGNAL_KEYCARD_RESPONSE) do(e: Args):
    let args = KeycardLibArgs(e)
    self.disconnectKeycardReponseSignal()
    let currentFlow = self.keycardService.getCurrentFlow()
    if currentFlow != KCSFlowType.Sign:
      error "trying to use keycard in the other than the signing a transaction flow"
      self.delegate.transactionWasSent()
      return
    self.delegate.onTransactionSigned(args.flowType, args.flowEvent)

proc cancelCurrentFlow*(self: Controller) =
  self.keycardService.cancelCurrentFlow()

proc runSignFlow*(self: Controller, pin, bip44Path, txHash: string) =
  self.cancelCurrentFlow()
  self.connectKeycardReponseSignal()
  self.keycardService.startSignFlow(bip44Path, txHash, pin)

proc hasGas*(self: Controller, accountAddress: string, chainId: int, nativeGasSymbol: string, requiredGas: float): bool =
  return self.walletAccountService.hasGas(accountAddress, chainId, nativeGasSymbol, requiredGas)
