import QtQuick 2.15

import StatusQ.Core.Utils 0.1 as SQUtils

/// Helper item to clone a model and alter its data without affecting the original model
/// \beware this is not a proxy model. It clones the initial state
///     and every time the instance changes and doesn't adapt when the data
///     in the source model \c allNetworksModel changes
/// \beware use it with small models and in temporary views (e.g. popups)
/// \note tried to use SortFilterProxyModel with but it complicates implementation too much
ListModel {
    id: root

    required property var sourceModel

    /// Roles to clone
    required property var roles

    /// Roles to override or add of the form { role: "roleName", transform: function(modelData) { return newValue } }
    property var rolesOverride: []

    Component.onCompleted: cloneModel(sourceModel)
    onSourceModelChanged: cloneModel(sourceModel)

    function findIndexForRole(roleName, value) {
        for (let i = 0; i < count; i++) {
            if(get(i)[roleName] === value) {
                return i
            }
        }
        return -1
    }

    function cloneModel(model) {
        clear()
        if (!model) {
            console.warn("Missing valid data model to clone. The CloneModel is useless")
            return
        }

        for (let i = 0; i < model.count; i++) {
            const clonedItem = new Object()
            for (var propName of roles) {
                clonedItem[propName] = SQUtils.ModelUtils.get(model, i, propName)
            }
            for (var newProp of rolesOverride) {
                clonedItem[newProp.role] = newProp.transform(clonedItem)
            }
            append(clonedItem)
        }
    }
}
