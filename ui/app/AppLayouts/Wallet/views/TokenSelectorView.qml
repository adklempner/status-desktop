import QtQuick 2.15

import StatusQ.Core 0.1

StatusListView {
    id: root

    // expected model structure:
    // tokensKey, name, symbol, decimals, currencyBalanceAsString (computed), marketDetails, balances -> [ chainId, address, balance, iconUrl ]

    // output API
    signal tokenSelected(string tokensKey)

    currentIndex: -1

    delegate: TokenSelectorAssetDelegate {
        required property var model
        required property int index

        tokensKey: model.tokensKey
        name: model.name
        symbol: model.symbol
        currencyBalanceAsString: model.currencyBalanceAsString
        balancesModel: model.balances

        onAssetSelected: (tokensKey) => root.tokenSelected(tokensKey)
    }
}
