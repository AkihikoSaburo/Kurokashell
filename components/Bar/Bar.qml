import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import "root:/services"

ColumnLayout {
    id: root

    property int margin: 6

    anchors.fill: parent
    spacing: 0
    Column {
        id: sidebarUpper

        width: 50
        spacing: 12

        Layout.alignment: Qt.AlignTop | Qt.AlignHCenter
        Layout.topMargin: margin
        Layout.leftMargin: margin

        Rectangle {
            id: archLogo

            width: parent.width
            radius: 25
            color: "#F8DAC6"
            height: 50

            // Image {
            //     anchors.centerIn: parent
            //     source: "root:/icons/archLogo.svg"
            //     sourceSize.width: 24
            //     sourceSize.height: 24
            // }

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    let process = Qt.createQmlObject(`
                import Quickshell.Io
                Process {
                command: ["wofi", "--show", "drun"]
                }
                `, parent, "WofiLauncher");
                    process.running = true;
                }
            }

        }

        Rectangle {
            id: workspaceCounter

            width: parent.width
            height: workspaceColumn.implicitHeight + 32
            radius: 25
            color: "#F8DAC6"

            WorkspaceColumn {
                id: workspaceColumn
                anchors.centerIn: parent
            }

        }

    }

    Column {
        id: sidebarBottom

        width: 50
        spacing: 12

        Layout.alignment: Qt.AlignBottom | Qt.AlignHCenter
        Layout.bottomMargin: 6
        Layout.leftMargin: margin

        Rectangle {
            id: wrapper

            width: parent.width
            height: powerLogo.height + networkBattery.height + 5
            radius: 25
            color: "#F8DAC6"

            Rectangle {
                id: powerLogo

                width: parent.width
                radius: 25
                color: "transparent"
                height: 50
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter

                MaterialIcon {
                    icon: "mode_off_on"
                    anchors.horizontalCenter: parent.horizontalCenter
                    weight: 800
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 5
                }

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                }

            }

            Rectangle {
                id: networkBattery

                width: 40
                height: 160
                radius: 25
                color: "#41282B"
                anchors.top: parent.top
                anchors.topMargin: (wrapper.width - networkBattery.width) / 2
                anchors.horizontalCenter: parent.horizontalCenter

                ColumnLayout {
                    anchors.fill: parent
                    spacing: -5
                    anchors.horizontalCenter: parent.horizontalCenter

                    MaterialIcon {
                        icon: "wifi"
                        Layout.alignment: Qt.AlignHCenter
                        color: "white"
                        scale: 0.9
                    }

                    MaterialIcon {
                        icon: "bluetooth"
                        Layout.alignment: Qt.AlignHCenter
                        color: "white"
                        scale: 0.9
                    }

                    MaterialIcon {
                        icon: "battery_full"
                        Layout.alignment: Qt.AlignHCenter
                        color: "white"
                        scale: 0.9
                    }

                }

            }

        }

    }

}
