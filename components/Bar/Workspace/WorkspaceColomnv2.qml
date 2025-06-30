// WorkspaceList.qml
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import "root:/services" as Services

Item {
    id: root
    property int shown: 5
    property int activeId: Services.AppState.activeWsId
    property int groupOffset: Math.floor((activeId - 1) / shown) * shown

    ListModel { id: pagedWorkspaces }

    Connections {
        target: Services.AppState
        function onActiveWorkspaceChanged() {
            updateModel()
        }
    }

    function updateModel() {
        pagedWorkspaces.clear()

        const shown = root.shown
        const activeId = Services.AppState.activeWsId
        const group = Math.floor((activeId - 1) / shown)
        const start = group * shown + 1
        const end = start + shown - 1

        let realWorkspaces = Services.AppState.workspaces.values

        for (let i = start; i <= end; i++) {
            const exists = realWorkspaces.some(w => w.id === i)

            pagedWorkspaces.append({ id: i, exists: exists })
        }
    }

    function isOccupied(id) {
        let ws = Services.AppState.workspaces.values.find(w => w.id === id)
        return !!(ws && ws.lastIpcObject && ws.lastIpcObject.windows > 0)
    }

    Component.onCompleted: updateModel()

    implicitWidth: layout.width
    implicitHeight: layout.height

    ColumnLayout {
        id: layout
        spacing: 5

        Repeater {
            model: pagedWorkspaces
            delegate: Rectangle {
                id: drawer
                height: workspaceIcons.height
                width: workspaceIcons.width
                radius: 25
                color: "transparent"
                Layout.alignment: Qt.AlignHCenter
                Rectangle {
                    id: workspaceIcons
                    color: "#41282B"
                    height: 40
                    width: 40
                    radius: 25
                    anchors.centerIn: parent
                    opacity: model.id === activeId ? 1 : 0
                }
                Services.MaterialIcon {
                    property real targetScale: model.id === activeId ? 1.0 : 0.9

                    id: materialIcon
                    anchors.centerIn: parent
                    implicitWidth: 24
                    implicitHeight: 24
                    color: model.id === activeId ? "white" : "black"
                    icon: model.id === activeId
                        ? "radio_button_checked"
                        : isOccupied(model.id)
                            ? "target"
                            : "radio_button_unchecked"
                    
                    scale: 0

                    Component.onCompleted: {
                        if (model.id === activeId) {
                            scaleAnim.to = 1.0
                            scaleAnim.start()
                        } else {
                            scale = targetScale
                        }
                    }

                    NumberAnimation {
                        id: scaleAnim
                        target: materialIcon
                        property: "scale"
                        duration: 300
                        easing.type: Easing.OutCubic
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    hoverEnabled: true

                    onEntered: {
                        hoverAnim.stop()
                        hoverAnim.to = 1.0
                        hoverAnim.start()
                    }

                    onExited: {
                        hoverAnim.stop()
                        hoverAnim.to = model.id === activeId ? 1.0 : 0.9
                        hoverAnim.start()
                    }
                    onClicked: Hyprland.dispatch(`workspace ${model.id}`);

                    onWheel: wheel => {
                        if (wheel.angleDelta.y > 0)
                            Hyprland.dispatch("workspace -1");
                        else if (wheel.angleDelta.y < 0)
                            Hyprland.dispatch("workspace +1");
                    }
                }
                NumberAnimation {
                    id: hoverAnim
                    target: materialIcon
                    property: "scale"
                    duration: 150
                    easing.type: Easing.OutCubic
                }
            }
        }
    }
}