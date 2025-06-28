import QtQuick
import Quickshell
import "root:/components/Bar"

Variants {
    model: Quickshell.screens

    delegate: Component {
        PanelWindow {
            property var modelData

            screen: modelData
            color: "transparent"
            anchors {
                right: true
            }

            BarOSD {}

        }  
    }
}