import QtQuick
import Quickshell
import Quickshell.Wayland
import "root:/components/Bar"
import "root:/services"

Variants {
    model: Quickshell.screens

    delegate: Component {
        PanelWindow {
            property var modelData

            screen: modelData
            color: "transparent"
            implicitWidth: 60

            anchors {
                top: true
                bottom: true
                left: true
            }

            Bar {}

        }

    }

}
