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

            MaterialIcon{
                icon: "mode_off_on"
                anchors.fill: parent
                weight: 800
            }

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
            }
        }
        Rectangle {
            id: networkBattery
            width: 45
            height: 160
            radius: 25
            color: "#41282B"
            anchors.top: parent.top
            anchors.topMargin: ( root.width - networkBattery.width ) / 2
            anchors.horizontalCenter: parent.horizontalCenter
            ColumnLayout {
                anchors.fill: parent
                spacing: 1
                anchors.margins: 10

                MaterialIcon {
                    icon: "wifi"
                    Layout.alignment: Qt.AlignHCenter
                    color: "white"
                    implicitWidth: 24
                    implicitHeight: 24
                }
               MaterialIcon {
                    icon: "bluetooth"
                    Layout.alignment: Qt.AlignHCenter
                    color: "white"
                    implicitWidth: 24
                    implicitHeight: 24
                }
                MaterialIcon {
                    icon: "battery_full"
                    Layout.alignment: Qt.AlignHCenter
                    color: "white"
                    implicitWidth: 24
                    implicitHeight: 24
                }
            }
        }
    }
}