import QtQuick 2.15

import StatusQ.Core.Theme 0.1

import shared.views 1.0

Column {
    id: root

    property int purpose: SyncingCodeInstructions.Purpose.AppSync
    property int type: SyncingCodeInstructions.Type.QRCode

    spacing: 4

    GetSyncCodeInstruction {
        order: "1."
        text1: qsTr("Ensure both devices are on the same network")
    }

    GetSyncCodeInstruction {
        order: "2."
        text1: {
            if (root.purpose === SyncingCodeInstructions.Purpose.KeypairSync) {
                return qsTr("Open Status on the device you want to import from")
            }
            return qsTr("Open Status App on your desktop device")
        }
    }

    GetSyncCodeInstruction {
        order: "3."
        text1: qsTr("Open")
        icon: "settings"
        text2: {
            if (root.purpose === SyncingCodeInstructions.Purpose.KeypairSync) {
                return qsTr("Settings / Wallet")
            }
            return qsTr("Settings")
        }
        text2Color: Theme.palette.directColor1
    }

    GetSyncCodeInstruction {
        order: "4."
        text1: {
            if (root.purpose === SyncingCodeInstructions.Purpose.KeypairSync) {
                return qsTr("Click")
            }
            return qsTr("Navigate to the")
        }
        icon: {
            if (root.purpose === SyncingCodeInstructions.Purpose.KeypairSync) {
                return ""
            }
            return "rotate"
        }
        text2: {
            if (root.purpose === SyncingCodeInstructions.Purpose.KeypairSync) {
                return qsTr("Show encrypted QR of key pairs on this device")
            }
            return qsTr("Syncing tab")
        }
        text2Color: Theme.palette.directColor1
    }

    GetSyncCodeInstruction {
        order: "5."
        text1: {
            if (root.purpose === SyncingCodeInstructions.Purpose.KeypairSync) {
                if (root.type === SyncingCodeInstructions.Type.EncryptedKey) {
                    return qsTr("Copy the")
                }
                return qsTr("Enable camera")
            }
            return qsTr("Click")
        }
        text1Color: {
            if (root.purpose === SyncingCodeInstructions.Purpose.KeypairSync) {
                if (root.type === SyncingCodeInstructions.Type.EncryptedKey) {
                    return Theme.palette.baseColor1
                }
                return Theme.palette.directColor1
            }
            return Theme.palette.baseColor1
        }
        text2: {
            if (root.purpose === SyncingCodeInstructions.Purpose.KeypairSync) {
                if (root.type === SyncingCodeInstructions.Type.EncryptedKey) {
                    return qsTr("encrypted key pairs code")
                }
                return qsTr("on this device")
            }
            return qsTr("Setup Syncing")
        }
        text2Color: {
            if (root.purpose === SyncingCodeInstructions.Purpose.KeypairSync) {
                if (root.type === SyncingCodeInstructions.Type.EncryptedKey) {
                    return Theme.palette.directColor1
                }
                return Theme.palette.baseColor1
            }
            return Theme.palette.directColor1
        }
    }

    GetSyncCodeInstruction {
        order: "6."
        text1: {
            if (root.purpose === SyncingCodeInstructions.Purpose.KeypairSync) {
                if (root.type === SyncingCodeInstructions.Type.EncryptedKey) {
                    return qsTr("Paste the")
                }
                return qsTr("Scan or enter the encrypted QR with this device")
            }
            return ""
        }
        text2: {
            if (root.purpose === SyncingCodeInstructions.Purpose.KeypairSync) {
                if (root.type === SyncingCodeInstructions.Type.EncryptedKey) {
                    return qsTr("encrypted key pairs code")
                }
                return ""
            }
            return qsTr("Enable camera")
        }
        text2Color: Theme.palette.directColor1
        text3: {
            if (root.purpose === SyncingCodeInstructions.Purpose.KeypairSync) {
                if (root.type === SyncingCodeInstructions.Type.EncryptedKey) {
                    return qsTr("to this device")
                }
                return ""
            }
            return qsTr("on this device")
        }
    }

    GetSyncCodeInstruction {
        order: {
            if (root.purpose === SyncingCodeInstructions.Purpose.KeypairSync) {
                if (root.type === SyncingCodeInstructions.Type.EncryptedKey) {
                    return "7."
                }
                return ""
            }
            return "7."
        }
        text1: {
            if (root.purpose === SyncingCodeInstructions.Purpose.KeypairSync) {
                if (root.type === SyncingCodeInstructions.Type.EncryptedKey) {
                    return qsTr("For security, delete the code as soon as you are done")
                }
                return ""
            }
            return qsTr("Scan or enter the code")
        }
    }
}
