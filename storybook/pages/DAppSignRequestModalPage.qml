// category: Popups

import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import shared.popups.walletconnect 1.0
import utils 1.0
import Storybook 1.0

SplitView {
    id: root

    PopupBackground {
        SplitView.fillWidth: true
        SplitView.fillHeight: true
        Button {
            anchors.centerIn: parent
            text: "Open"
            onClicked: dappSignRequestModal.visible = true
        }

        DAppSignRequestModal {
            id: dappSignRequestModal

            loginType: loginType.currentValue
            visible: true
            modal: false
            closePolicy: Popup.NoAutoClose
            dappUrl: "https://example.com"
            dappIcon: "https://picsum.photos/200/200"
            dappName: "OpenSea"
            accountColor: "blue"
            accountName: "Account Name"
            accountAddress: "0xE2d622C817878dA5143bBE06866ca8E35273Ba8"
            networkName: "Ethereum"
            networkIconPath: "https://picsum.photos/200/200"

            currentCurrency: "EUR"
            fiatFees: fiatFees.text
            cryptoFees: "0.001"
            estimatedTime: "3-5 minutes"
            feesLoading: feesLoading.checked
            hasFees: hasFees.checked
            enoughFundsForTransaction: enoughFeesForTransaction.checked
            enoughFundsForFees: enoughFeesForGas.checked

            // sun emoji
            accountEmoji: "\u2600"
            requestPayload: controls.contentToSign[contentToSignComboBox.currentIndex]
            signingTransaction: signingTransaction.checked

            onAccepted: print ("Accepted")
            onRejected: print ("Rejected")
        }
    }
    Pane {
        id: controls
        SplitView.preferredWidth: 300
        SplitView.fillHeight: true

        readonly property var contentToSign: ['{
                "id": 1714038548266495,
                "params": {
                "chainld": "eip155:11155111",
                "request": {
                    "expiryTimestamp": 1714038848,
                    "method": "eth_signTransaction",
                    "params": [{
                        "data": "0x",
                        "from": "0xE2d622C817878dA5143bBE06866ca8E35273Ba8",
                        "gasLimit": "0x5208",
                        "gasPrice": "0xa677ef31",
                        "nonce": "0x27",
                        "to": "0xE2d622C817878dA5143bBE06866ca8E35273Ba8a",
                        "value": "0x00"
                    }]
                }
                },
                "topic": "a0f85b23a1f3a540d85760a523963165fb92169d57320c",
                "verifyContext": {
                "verified": {
                    "isScam": false,
                    "origin": "https://react-app.walletconnect.com/",
                    "validation": "VALID",
                    "verifyUrl": "https://verify.walletconnect.com/"
                }
                }
            }',
            '"tx":{"data":"0x","from":"0xE2d622C817878dA5143bBE06866ca8E35273Ba8a","gasLimit":"0x5208","gasPrice":"0x048ddbc5","nonce":"0x2a","to":"0xE2d622C817878dA5143bBE06866ca8E35273Ba8a","value":"0x00"}',
            ""
        ]

        ColumnLayout {
            TextField {
                id: fiatFees
                text: "1.54"
            }
            ComboBox {
                id: loginType
                model: [{name: "Password", value: Constants.LoginType.Password}, {name: "Biometrics", value: Constants.LoginType.Biometrics}, {name: "Keycard", value: Constants.LoginType.Keycard}]
                textRole: "name"
                valueRole: "value"
                currentIndex: 0
            }
            ComboBox {
                id: contentToSignComboBox
                model: ["Long content to sign", "Short content to sign", "Empty content to sign"]
                currentIndex: 0
            }
            CheckBox {
                id: enoughFeesForTransaction
                text: "Enough fees for transaction"
                checked: true
            }
            CheckBox {
                id: enoughFeesForGas
                text: "Enough fees for gas"
                checked: true
            }
            CheckBox {
                id: feesLoading
                text: "Fees loading"
                checked: false
            }
            CheckBox {
                id: hasFees
                text: "Has fees"
                checked: true
            }
            CheckBox {
                id: signingTransaction
                text: "Signing transaction"
                checked: false
            }
        }
    }
}