import QtQuick
import Quickshell
import Quickshell.Wayland
import "root:/services"
import "root:/components/Bar"

Variants {
    model: Quickshell.screens;
    delegate: Component {
        PanelWindow {
            property var modelData

            screen: modelData
            color: "transparent"

            anchors {
                top: true
                bottom: true
                left: true
            }
            implicitWidth: 60
            Item {
                width: parent.width
                height: parent.height
                BarUpper {}
                BarBottom {}
            }
        }
    }
}


