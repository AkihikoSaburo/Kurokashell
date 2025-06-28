import QtQuick
import Quickshell
import Quickshell.Wayland
import "root:/services"

Variants {
    model: Quickshell.screens

    Window {
        name: barLeft

        anchors {
            top: true
            bottom: true
            left: true
        }
        implicitWidth: 60
        Bar {}
        
    }

}

