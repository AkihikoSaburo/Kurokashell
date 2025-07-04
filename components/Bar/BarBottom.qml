import QtQuick
import QtQuick.Layouts
import Quickshell
import "root:/services"

Column {
    id: sidebarUpper

    width: 50
    spacing: 12

    anchors {
        left: parent.left
        bottom: parent.bottom
        margins: 5
    }

    Rectangle {
        id: root
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

            MaterialIcon{
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
            anchors.topMargin: ( root.width - networkBattery.width ) / 2
            anchors.horizontalCenter: parent.horizontalCenter
            ColumnLayout {
                anchors.fill: parent
                spacing: - 5
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