import QtQuick
import Quickshell
import Quickshell.Services.Pipewire

Item {
    id: osd
    width: 200
    property real barHeight: 20
    property real rightHiddenX: parent.width
    property real rightShownX: parent.width - width - 20

    x: rightHiddenX
    anchors.verticalCenter: parent.verticalCenter
    height: (barHeight + 10) * 2 + 20

    Timer {
        id: hideTimer
        interval: 1500
        running: false
        onTriggered: osd.hideOSD()
    }

    function showOSD() {
        hideTimer.stop()
        anim.to = osd.rightShownX
        anim.start()
        hideTimer.restart()
    }

    function hideOSD() {
        anim.to = osd.rightHiddenX
        anim.start()
    }

    NumberAnimation on x {
        id: anim
        duration: 250
        easing.type: Easing.OutCubic
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onExited: osd.hideOSD()
    }

    Column {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 10

        // Volume bar
        Rectangle {
            height: barHeight
            width: parent.width
            radius: Qt.vector4d(25, 0, 25, 0)
            color: "#80000000"

            Rectangle {
                height: parent.height
                width: parent.width * (Pipewire.defaultAudioSink?.audio.volume ?? 0)
                radius: parent.radius
                color: "#50ffffff"
            }
        }

        // Brightness bar (placeholder)
        Rectangle {
            height: barHeight
            width: parent.width
            radius: Qt.vector4d(25, 0, 25, 0)
            color: "#80000000"

            Rectangle {
                height: parent.height
                width: parent.width * 0.5 // nanti ganti ke brightness service
                radius: parent.radius
                color: "#50ffff50"
            }
        }
    }


    Timer {
        property var activeScreen: Quickshell.screens.length > 0 ? Quickshell.screens[0] : null
        interval: 100
        repeat: true
        running: true
        onTriggered: {
            if (activeScreen && typeof Quickshell.cursor.x === "number") {
                if (Quickshell.cursor.x >= activeScreen.geometry.width - 1) {
                    osd.showOSD()
                }
            }
        }
    }

    Connections {
        target: Pipewire.defaultAudioSink?.audio
        function onVolumeChanged() {
            osd.showOSD()
        }
    }

    // TODO: tambah Connections untuk brightness
}
