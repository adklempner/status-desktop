import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

import StatusQ 0.1
import StatusQ.Components 0.1
import StatusQ.Controls 0.1
import StatusQ.Core 0.1
import StatusQ.Core.Theme 0.1
import StatusQ.Core.Utils 0.1

import Storybook 1.0
import Models 1.0

import SortFilterProxyModel 0.2

import AppLayouts.Wallet.views 1.0

SplitView {
    id: root
    orientation: Qt.Vertical

    Logs { id: logs }

    Pane {
        SplitView.fillWidth: true
        SplitView.fillHeight: true

        background: Rectangle {
            color: Theme.palette.baseColor3
        }

        Rectangle {
            width: 380
            height: 200
            color: Theme.palette.statusListItem.backgroundColor
            border.color: Theme.palette.primaryColor1
            border.width: 1
            anchors.centerIn: parent

            TokenSelectorAssetDelegate {
                implicitWidth: 333
                anchors.centerIn: parent

                tokensKey: "ETH"
                name: "Ethereum"
                symbol: "ETH"
                currencyBalanceAsString: "14,456.42 USD"
                balancesModel: ListModel {
                    readonly property var data: [
                        { chainId: 1, balanceAsString: "1234.50", iconUrl: "network/Network=Ethereum" },
                        { chainId: 42161, balanceAsString: "55.91", iconUrl: "network/Network=Arbitrum" },
                        { chainId: 10, balanceAsString: "45.12", iconUrl: "network/Network=Optimism" },
                        { chainId: 420, balanceAsString: "1.23", iconUrl: "network/Network=Testnet" }
                    ]
                    Component.onCompleted: append(data)
                }

                interactive: ctrlInteractive.checked
                highlighted: ctrlHighlighted.checked

                onAssetSelected: (tokensKey) => {
                                     console.warn("!!! TOKEN SELECTED:", tokensKey)
                                     logs.logEvent("TokenSelectorAssetDelegate::onTokenSelected", ["tokensKey"], arguments)
                                 }
            }
        }
    }

    LogsAndControlsPanel {
        SplitView.minimumHeight: 300
        SplitView.preferredHeight: 300

        logsView.logText: logs.logText

        RowLayout {
            anchors.fill: parent

            ColumnLayout {
                Switch {
                    id: ctrlInteractive
                    text: "Interactive"
                    checked: true
                }
                Switch {
                    id: ctrlHighlighted
                    text: "Highlighted"
                    checked: false
                }

                Item { Layout.fillHeight: true }
            }
        }
    }
}

// category: Delegates
