import QtQuick 2.15
import QtQuick.Layouts 1.15

import StatusQ.Controls 0.1
import StatusQ.Core 0.1
import StatusQ.Core.Theme 0.1
import StatusQ.Core.Utils 0.1

import utils 1.0
import shared.controls 1.0
import shared.views 1.0
import shared.stores 1.0 as SharedStores
import shared.panels 1.0

import "./"
import "../stores"
import "../panels"
import "../views/collectibles"

RightTabBaseView {
    id: root

    property alias currentTabIndex: walletTabBar.currentIndex

    signal launchShareAddressModal()
    signal launchSwapModal(string tokensKey)

    function resetView() {
        resetStack()
        root.currentTabIndex = 0
    }

    function resetStack() {
        stack.currentIndex = 0;
        RootStore.backButtonName = d.getBackButtonText(stack.currentIndex);
    }

    headerButton.onClicked: {
        root.launchShareAddressModal()
    }
    header.visible: stack.currentIndex === 0

    StackLayout {
        id: stack
        anchors.fill: parent

        Connections {
            target: walletSection

            function onFilterChanged() {
                root.resetView()
            }
        }

        onCurrentIndexChanged: {
            RootStore.backButtonName = d.getBackButtonText(currentIndex)
        }

        QtObject {
            id: d
            function getBackButtonText(index) {
                switch(index) {
                case 1:
                    return qsTr("Collectibles")
                case 2:
                    return qsTr("Assets")
                case 3:
                    return qsTr("Activity")
                default:
                    return ""
                }
            }

            readonly property var detailedCollectibleActivityController: RootStore.tmpActivityController0
        }

        // StackLayout.currentIndex === 0
        ColumnLayout {
            spacing: 0

            ImportKeypairInfo {
                Layout.fillWidth: true
                Layout.topMargin: Style.current.bigPadding
                Layout.preferredHeight: childrenRect.height
                visible: root.store.walletSectionInst.hasPairedDevices && root.store.walletSectionInst.keypairOperabilityForObservedAccount === Constants.keypair.operability.nonOperable

                onRunImport: {
                    root.store.walletSectionInst.runKeypairImportPopup()
                }
            }

            RowLayout {
                Layout.fillWidth: true
                StatusTabBar {
                    id: walletTabBar
                    objectName: "rightSideWalletTabBar"
                    Layout.fillWidth: true
                    Layout.topMargin: Style.current.padding

                    StatusTabButton {
                        objectName: "assetsTabButton"
                        leftPadding: 0
                        width: implicitWidth
                        text: qsTr("Assets")
                    }
                    StatusTabButton {
                        objectName: "collectiblesTabButton"
                        width: implicitWidth
                        text: qsTr("Collectibles")
                    }
                    StatusTabButton {
                        objectName: "activityTabButton"
                        rightPadding: 0
                        width: implicitWidth
                        text: qsTr("Activity")
                    }
                    onCurrentIndexChanged: {
                        RootStore.setCurrentViewedHoldingType(walletTabBar.currentIndex === 1 ? Constants.TokenType.ERC721 : Constants.TokenType.ERC20)
                    }
                }
                StatusFlatButton {
                    id: filterButton
                    objectName: "filterButton"
                    icon.name: "filter"
                    checkable: true
                    icon.color: checked ? Theme.palette.primaryColor1 : Theme.palette.baseColor1
                    Behavior on icon.color { ColorAnimation { duration: 200; easing.type: Easing.InOutQuad } }
                    highlighted: checked
                }
            }
            Loader {
                id: mainViewLoader
                Layout.fillWidth: true
                Layout.fillHeight: true
                sourceComponent: {
                    switch (walletTabBar.currentIndex) {
                    case 0: return assetsView
                    case 1: return collectiblesView
                    case 2: return historyView
                    }
                }

                Component {
                    id: assetsView

                    AssetsView {
                        AssetsViewAdaptor {
                            id: assetsViewAdaptor

                            accounts: RootStore.addressFilters
                            chains: RootStore.networkFilters

                            marketValueThreshold:
                                RootStore.tokensStore.displayAssetsBelowBalance
                                ? RootStore.tokensStore.getDisplayAssetsBelowBalanceThresholdDisplayAmount()
                                : 0

                            Connections {
                                target: RootStore.tokensStore

                                function displayAssetsBelowBalanceThresholdChanged() {
                                    assetsViewAdaptor.marketValueThresholdChanged()
                                }
                            }

                            tokensModel: RootStore.walletAssetsStore.groupedAccountAssetsModel
                            controller: RootStore.walletAssetsStore.assetsController

                            formatBalance: (balance, symbol) => {
                                return LocaleUtils.currencyAmountToLocaleString(
                                                   RootStore.currencyStore.getCurrencyAmount(balance, symbol))
                            }

                            chainsError: (chains) => {
                                if (!root.networkConnectionStore)
                                    return ""
                                return root.networkConnectionStore.getBlockchainNetworkDownText(chains)
                            }
                        }

                        loading: RootStore.overview.balanceLoading
                        sorterVisible: filterButton.checked
                        customOrderAvailable: RootStore.walletAssetsStore.assetsController.hasSettings
                        model: assetsViewAdaptor.model

                        marketDataError: !!root.networkConnectionStore
                                         ? root.networkConnectionStore.getMarketNetworkDownText()
                                         : ""
                        balanceError: {
                            if (!root.networkConnectionStore)
                                return ""

                            return (root.networkConnectionStore.noBlockchainConnectionAndNoCache
                                    && !root.networkConnectionStore.noMarketConnectionAndNoCache)
                                    ? root.networkConnectionStore.noBlockchainConnectionAndNoCacheText
                                    : ""
                        }

                        formatFiat: balance => RootStore.currencyStore.formatCurrencyAmount(
                                        balance, RootStore.currencyStore.currentCurrency)

                        sendEnabled: root.networkConnectionStore.sendBuyBridgeEnabled &&
                                     !RootStore.overview.isWatchOnlyAccount && RootStore.overview.canSend
                        swapEnabled: !RootStore.overview.isWatchOnlyAccount
                        swapVisible: Global.featureFlags.swapEnabled

                        onSendRequested: {
                            const symbol = ModelUtils.getByKey(model, "key", key, "symbol")
                            const modal = root.sendModal

                            modal.preSelectedSendType = Constants.SendType.Transfer
                            modal.preSelectedHoldingID = symbol
                            modal.preSelectedHoldingType = Constants.TokenType.ERC20
                            modal.onlyAssets = true
                            modal.open()
                        }

                        onSwapRequested: root.launchSwapModal(key)
                        onReceiveRequested: root.launchShareAddressModal()
                        onCommunityClicked: Global.switchToCommunity(communityKey)
                        onManageTokensRequested: Global.changeAppSectionBySectionType(
                                                     Constants.appSection.profile,
                                                     Constants.settingsSubsection.wallet,
                                                     Constants.walletSettingsSubsection.manageAssets)
                        onAssetClicked: {
                            const token = ModelUtils.getByKey(model, "key", key)

                            SharedStores.RootStore.getHistoricalDataForToken(
                                        token.symbol, RootStore.currencyStore.currentCurrency)

                            assetDetailView.token = token
                            RootStore.setCurrentViewedHolding(token.symbol, token.key, Constants.TokenType.ERC20)
                            stack.currentIndex = 2
                        }
                    }
                }

                Component {
                    id: collectiblesView
                    CollectiblesView {
                        controller: RootStore.collectiblesStore.collectiblesController
                        networkFilters: RootStore.networkFilters
                        addressFilters: RootStore.addressFilters
                        sendEnabled: root.networkConnectionStore.sendBuyBridgeEnabled && !RootStore.overview.isWatchOnlyAccount && RootStore.overview.canSend
                        filterVisible: filterButton.checked
                        onCollectibleClicked: {
                            RootStore.collectiblesStore.getDetailedCollectible(chainId, contractAddress, tokenId)
                            RootStore.setCurrentViewedHolding(uid, uid, tokenType)
                            d.detailedCollectibleActivityController.resetFilter()
                            d.detailedCollectibleActivityController.setFilterAddressesJson(JSON.stringify(RootStore.addressFilters.split(":")))
                            d.detailedCollectibleActivityController.setFilterChainsJson(JSON.stringify([chainId]), false)
                            d.detailedCollectibleActivityController.setFilterCollectibles(JSON.stringify([uid]))
                            d.detailedCollectibleActivityController.updateFilter()

                            stack.currentIndex = 1
                        }
                        onSendRequested: (symbol, tokenType) => {
                                            root.sendModal.preSelectedHoldingID = symbol
                                            root.sendModal.preSelectedHoldingType = tokenType
                                            root.sendModal.preSelectedSendType = tokenType === Constants.TokenType.ERC721 ?
                                                 Constants.SendType.ERC721Transfer:
                                                 Constants.SendType.ERC1155Transfer
                                            root.sendModal.onlyAssets = false
                                            root.sendModal.open()
                                        }
                        onReceiveRequested: (symbol) => root.launchShareAddressModal()
                        onSwitchToCommunityRequested: (communityId) => Global.switchToCommunity(communityId)
                        onManageTokensRequested: Global.changeAppSectionBySectionType(Constants.appSection.profile, Constants.settingsSubsection.wallet,
                                                                                      Constants.walletSettingsSubsection.manageCollectibles)
                        isFetching: RootStore.collectiblesStore.areCollectiblesFetching
                        isUpdating: RootStore.collectiblesStore.areCollectiblesUpdating
                        isError: RootStore.collectiblesStore.areCollectiblesError
                    }
                }
                Component {
                    id: historyView
                    HistoryView {
                        overview: RootStore.overview
                        communitiesStore: root.communitiesStore
                        showAllAccounts: RootStore.showAllAccounts
                        sendModal: root.sendModal
                        filterVisible: filterButton.checked
                        onLaunchTransactionDetail: function (txID) {
                            RootStore.activityController.fetchTxDetails(txID)
                            stack.currentIndex = 3
                        }
                    }
                }
            }
        }
        CollectibleDetailView {
            id: collectibleDetailView

            visible : (stack.currentIndex === 1)

            collectible: RootStore.collectiblesStore.detailedCollectible
            isCollectibleLoading: RootStore.collectiblesStore.isDetailedCollectibleLoading
            activityModel: d.detailedCollectibleActivityController.model
            addressFilters: RootStore.addressFilters
            rootStore: SharedStores.RootStore
            walletRootStore: RootStore
            communitiesStore: root.communitiesStore

            onVisibleChanged: {
                if (!visible) {
                    RootStore.resetCurrentViewedHolding(Constants.TokenType.ERC721)
                }
            }

            onLaunchTransactionDetail: function (txID) {
                d.detailedCollectibleActivityController.fetchTxDetails(txID)
                stack.currentIndex = 3

                // Take user to the activity view when they press the "Back" button
                walletTabBar.currentIndex = 2
            }
        }
        AssetsDetailView {
            id: assetDetailView

            visible: (stack.currentIndex === 2)

            allNetworksModel: RootStore.filteredFlatModel
            address: RootStore.overview.mixedcaseAddress
            currencyStore: RootStore.currencyStore
            networkFilters: RootStore.networkFilters

            networkConnectionStore: root.networkConnectionStore

            onVisibleChanged: {
                if (!visible)
                    RootStore.resetCurrentViewedHolding(Constants.TokenType.ERC20)
            }
        }

        Loader {
            active: stack.currentIndex === 3

            sourceComponent: TransactionDetailView {
                controller: RootStore.activityDetailsController
                onVisibleChanged: {
                    if (visible) {
                        if (!!transaction) {
                            RootStore.addressWasShown(transaction.sender)
                            if (transaction.sender !== transaction.recipient) {
                                RootStore.addressWasShown(transaction.recipient)
                            }
                        }
                    } else {
                        controller.resetActivityEntry()
                    }
                }
                showAllAccounts: RootStore.showAllAccounts
                communitiesStore: root.communitiesStore
                sendModal: root.sendModal
                contactsStore: root.contactsStore
                networkConnectionStore: root.networkConnectionStore
                visible: (stack.currentIndex === 3)
            }
        }
    }
}
