import QtQuick 2.13

import SortFilterProxyModel 0.2

import shared.stores 1.0

import utils 1.0

import StatusQ 0.1
import StatusQ.Core.Utils 0.1

import AppLayouts.Wallet.stores 1.0

QtObject {
    id: root

    property CurrenciesStore currencyStore
    property WalletAssetsStore walletAssetStore
    property TokensStore tokensStore

    property var mainModuleInst: mainModule
    property var walletSectionSendInst: walletSectionSend

    property var fromNetworksModel: walletSectionSendInst.fromNetworksModel
    property var toNetworksModel: walletSectionSendInst.toNetworksModel
    property var flatNetworksModel: networksModule.flatNetworks
    property var senderAccounts: walletSectionSendInst.senderAccounts
    property var selectedSenderAccount: walletSectionSendInst.selectedSenderAccount
    property var accounts: walletSectionSendInst.accounts
    property var collectiblesModel: walletSectionSendInst.collectiblesModel
    property var nestedCollectiblesModel: walletSectionSendInst.nestedCollectiblesModel
    property bool areTestNetworksEnabled: networksModule.areTestNetworksEnabled
    property var tmpActivityController0: walletSection.tmpActivityController0
    property var tmpActivityController1: walletSection.tmpActivityController1
    property var savedAddressesModel: SortFilterProxyModel {
        sourceModel: walletSectionSavedAddresses.model
        filters: [
            ValueFilter {
                roleName: "isTest"
                value: areTestNetworksEnabled
            }
        ]
    }
    property string selectedAssetKey: walletSectionSendInst.selectedAssetKey
    property bool showUnPreferredChains: walletSectionSendInst.showUnPreferredChains
    property int sendType: walletSectionSendInst.sendType
    property string selectedRecipient: walletSectionSendInst.selectedRecipient

    function setSendType(sendType) {
        walletSectionSendInst.setSendType(sendType)
    }

    function setSelectedRecipient(recipientAddress) {
        walletSectionSendInst.setSelectedRecipient(recipientAddress)
    }

    function getEtherscanLink(chainID) {
        return networksModule.getBlockExplorerURL(chainID)
    }

    function copyToClipboard(text) {
        globalUtils.copyToClipboard(text)
    }

    function authenticateAndTransfer(uuid) {
        walletSectionSendInst.authenticateAndTransfer(uuid)
    }

    function suggestedRoutes(amount) {
        const value = AmountsArithmetic.fromNumber(amount)
        walletSectionSendInst.suggestedRoutes(value.toFixed())
    }

    function resolveENS(value) {
        mainModuleInst.resolveENS(value, "")
    }

    function getWei2Eth(wei, decimals) {
        return globalUtils.wei2Eth(wei, decimals)
    }

    function plainText(text) {
        return globalUtils.plainText(text)
    }

    enum EstimatedTime {
        Unknown = 0,
        LessThanOneMin,
        LessThanThreeMins,
        LessThanFiveMins,
        MoreThanFiveMins
    }

    function getLabelForEstimatedTxTime(estimatedFlag) {
        switch(estimatedFlag) {
        case TransactionStore.EstimatedTime.Unknown:
            return qsTr("~ Unknown")
        case TransactionStore.EstimatedTime.LessThanOneMin :
            return qsTr("< 1 minute")
        case TransactionStore.EstimatedTime.LessThanThreeMins :
            return qsTr("< 3 minutes")
        case TransactionStore.EstimatedTime.LessThanFiveMins:
            return qsTr("< 5 minutes")
        default:
            return qsTr("> 5 minutes")
        }
    }

    function getAsset(assetsList, symbol) {
        for(var i=0; i< assetsList.rowCount();i++) {
            let asset = assetsList.get(i)
            if(symbol === asset.symbol) {
                return asset
            }
        }
        return {}
    }

    function getCollectible(uid) {
        const idx = ModelUtils.indexOf(collectiblesModel, "uid", uid)
        if (idx < 0) {
            return {}
        }
        return ModelUtils.get(collectiblesModel, idx)
    }

    function getSelectorCollectible(uid) {
        const idx = ModelUtils.indexOf(nestedCollectiblesModel, "uid", uid)
        if (idx < 0) {
            return {}
        }
        return ModelUtils.get(nestedCollectiblesModel, idx)
    }

    function getHolding(holdingId, holdingType) {
        if (holdingType === Constants.TokenType.ERC20) {
            return getAsset(processedAssetsModel, holdingId)
        } else if (holdingType === Constants.TokenType.ERC721 || holdingType === Constants.TokenType.ERC1155) {
            return getCollectible(holdingId)
        } else {
            return {}
        }
    }

    function getSelectorHolding(holdingId, holdingType) {
        if (holdingType === Constants.TokenType.ERC20) {
            return getAsset(processedAssetsModel, holdingId)
        } else if (holdingType === Constants.TokenType.ERC721 || holdingType === Constants.TokenType.ERC1155) {
            return getSelectorCollectible(holdingId)
        } else {
            return {}
        }
    }

    function assetToSelectorAsset(asset) {
        return asset
    }

    function collectibleToSelectorCollectible(collectible) {
        var groupId = collectible.collectionUid
        var groupName = collectible.collectionName
        var itemType = Constants.CollectiblesNestedItemType.Collectible
        if (collectible.communityId !== "") {
            groupId = collectible.communityId
            groupName = collectible.communityName
            itemType = Constants.CollectiblesNestedItemType.CommunityCollectible
        }
        return {
            uid: collectible.uid,
            chainId: collectible.chainId,
            name: collectible.name,
            iconUrl: collectible.imageUrl,
            groupId: groupId,
            groupName: groupName,
            tokenType: collectible.tokenType,
            itemType: itemType,
            count: 1 // TODO: Properly handle count
        }
    }

    function holdingToSelectorHolding(holding, holdingType) {
        if (holdingType === Constants.TokenType.ERC20) {
            return assetToSelectorAsset(holding)
        } else if (holdingType === Constants.TokenType.ERC721 || holdingType === Constants.TokenType.ERC1155) {
            return collectibleToSelectorCollectible(holding)
        } else {
            return {}
        }
    }

    function switchSenderAccountByAddress(address) {
        walletSectionSendInst.switchSenderAccountByAddress(address)
    }

    function getNetworkShortNames(chainIds) {
       return networksModule.getNetworkShortNames(chainIds)
    }

    function toggleFromDisabledChains(chainId) {
        fromNetworksModel.toggleRouteDisabledChains(chainId)
    }

    function toggleToDisabledChains(chainId) {
        toNetworksModel.toggleRouteDisabledChains(chainId)
    }

    function setRouteDisabledChains(chainId, disabled) {
        toNetworksModel.setRouteDisabledChains(chainId, disabled)
    }

    function setSelectedTokenName(tokenName) {
        walletSectionSendInst.setSelectedTokenName(tokenName)
    }

    function setSelectedTokenIsOwnerToken(isOwnerToken) {
        walletSectionSendInst.setSelectedTokenIsOwnerToken(isOwnerToken)
    }

    function setRouteEnabledFromChains(chainId) {
        fromNetworksModel.setRouteEnabledFromChains(chainId)
    }

    function setSelectedAssetKey(assetsKey) {
        walletSectionSendInst.setSelectedAssetKey(assetsKey)
    }

    function getNetworkName(chainId) {
        return fromNetworksModel.getNetworkName(chainId)
    }

    function updateRoutePreferredChains(chainIds) {
        walletSectionSendInst.updateRoutePreferredChains(chainIds)
    }

    function toggleShowUnPreferredChains() {
        walletSectionSendInst.toggleShowUnPreferredChains()
    }

    function setAllNetworksAsRoutePreferredChains() {
        toNetworksModel.setAllNetworksAsRoutePreferredChains()
    }

    function lockCard(chainId, amount, lock) {
        fromNetworksModel.lockCard(chainId, amount, lock)
    }

    function resetStoredProperties() {
        assetSearchString = ""
        walletSectionSendInst.resetStoredProperties()
        nestedCollectiblesModel.currentCollectionUid = ""
    }

    function splitAndFormatAddressPrefix(text, updateInStore) {
        return {
            formattedText: walletSectionSendInst.splitAndFormatAddressPrefix(text, updateInStore),
            address: walletSectionSendInst.getAddressFromFormattedString(text)
        }
    }

    function getShortChainIds(chainShortNames) {
        return walletSectionSendInst.getShortChainIds(chainShortNames)
    }

    function formatCurrencyAmountFromBigInt(balance, symbol, decimals, options = null) {
        return currencyStore.formatCurrencyAmountFromBigInt(balance, symbol, decimals, options)
    }

    // Property set from TokenLIstView and HoldingSelector to search token by name, symbol or contract address
    property string assetSearchString

    // Internal model filtering balances by the account selected on the SendModalPage
    property SubmodelProxyModel __assetsWithFilteredBalances: SubmodelProxyModel {
        sourceModel: walletAssetStore.groupedAccountAssetsModel
        submodelRoleName: "balances"
        delegateModel: SortFilterProxyModel {
            sourceModel: submodel
            filters: [
                ValueFilter {
                    roleName: "account"
                    value: root.selectedSenderAccount.address
                }
            ]
        }
    }

    readonly property Connections tokensStoreConnections: Connections {
        target: tokensStore
        function onDisplayAssetsBelowBalanceThresholdChanged() {
            processedAssetsModel.displayAssetsBelowBalanceThresholdAmount = tokensStore.getDisplayAssetsBelowBalanceThresholdDisplayAmount()
        }
    }

    // Model prepared to provide filtered and sorted assets as per the advanced Settings in token management
    property var processedAssetsModel: SortFilterProxyModel {
        property real displayAssetsBelowBalanceThresholdAmount: tokensStore.getDisplayAssetsBelowBalanceThresholdDisplayAmount()
        sourceModel: __assetsWithFilteredBalances
        proxyRoles: [
            FastExpressionRole {
                name: "isCommunityAsset"
                expression: !!model.communityId
                expectedRoles: ["communityId"]
            },
            FastExpressionRole {
                name: "currentBalance"
                expression: __getTotalBalance(model.balances, model.decimals)
                expectedRoles: ["balances", "decimals"]
            },
            FastExpressionRole {
                name: "currentCurrencyBalance"
                expression: {
                    if (!!model.marketDetails) {
                        return model.currentBalance * model.marketDetails.currencyPrice.amount
                    }
                    return 0
                }
                expectedRoles: ["marketDetails", "currentBalance"]
            }
        ]
        filters: [
            FastExpressionFilter {
                function search(symbol, name, addressPerChain, searchString) {
                    return (
                        symbol.toUpperCase().startsWith(searchString.toUpperCase()) ||
                                name.toUpperCase().startsWith(searchString.toUpperCase()) || __searchAddressInList(addressPerChain, searchString)
                    )
                }
                expression: search(symbol, name, addressPerChain, root.assetSearchString)
                expectedRoles: ["symbol", "name", "addressPerChain"]
            },
            ValueFilter {
                roleName: "isCommunityAsset"
                value: false
                enabled: !tokensStore.showCommunityAssetsInSend
            },
            FastExpressionFilter {
                expression: {
                    root.walletAssetStore.assetsController.revision

                    if (!root.walletAssetStore.assetsController.filterAcceptsSymbol(model.symbol)) // explicitely hidden
                        return false
                    if (tokensStore.displayAssetsBelowBalance)
                        return model.currentCurrencyBalance > processedAssetsModel.displayAssetsBelowBalanceThresholdAmount
                    return true
                }
                expectedRoles: ["symbol", "currentCurrencyBalance"]
            }
        ]
        sorters: RoleSorter {
            roleName: "isCommunityAsset"
        }
    }

    /* Internal function to search token address */
    function __searchAddressInList(addressPerChain, searchString) {
        let addressFound = false
        let tokenAddresses = ModelUtils.modelToFlatArray(addressPerChain, "address")
        for (let i =0; i< tokenAddresses.length; i++){
            if(tokenAddresses[i].toUpperCase().startsWith(searchString.toUpperCase())) {
                addressFound = true
                break;
            }
        }
        return addressFound
    }

    /* Internal function to calculate total balance */
    function __getTotalBalance(balances, decimals) {
        let totalBalance = 0
        for(let i=0; i<balances.count; i++) {
            let balancePerAddressPerChain = ModelUtils.get(balances, i)
            totalBalance+=AmountsArithmetic.toNumber(balancePerAddressPerChain.balance, decimals)
        }
        return totalBalance
    }
}
