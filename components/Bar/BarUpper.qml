import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import "root:/components/Bar/Workspace"
import "root:/services" as Services

Column {
    id: sidebarUpper

    width: 50
    spacing: 12

    anchors {
        left: parent.left
        top: parent.top
        margins: 6
    }

    Rectangle {
        id: archLogo

        width: parent.width
        radius: 25
        color: "#F8DAC6"
        height: 50

        Image {
            anchors.centerIn: parent
            source: "root:/icons/archLogo.svg"
            sourceSize.width: 24
            sourceSize.height: 24
            
        }
        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor

            onClicked: {
                let process = Qt.createQmlObject(`
                import Quickshell.Io
                Process {
                command: ["wofi", "--show", "drun"]
                }
                `, parent, "WofiLauncher")
                process.running = true
            }
        }
    }


    Rectangle {
        id: workspaceCounter
        width: parent.width
        height: workspaceColomn.implicitHeight + 32
        radius: 25
        color: "#F8DAC6"

        WorkspaceColomnv2 {
            id: workspaceColomn
            anchors.centerIn: parent
        }
    }
}
