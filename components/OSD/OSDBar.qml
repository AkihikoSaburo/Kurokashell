import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Effects
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Widgets
import "root:/services"

Scope {
    id: root

    PwObjectTracker {
        objects: [ Pipewire.defaultAudioSink ]
    }

    Connections {
        target: Pipewire.defaultAudioSink?.audio

        function onVolumeChanged() {
            root.shouldShowOsd = true;
            hideTimer.restart();
        }
    }

	property var targetMonitor: Brightness.monitors.length > 0 ? Brightness.monitors[0] : null

	Connections {
    	target: targetMonitor
    	function onBrightnessChanged() {
			root.shouldShowOsd = true;
			hideTimer.restart();
    	}
	}

    property bool shouldShowOsd: false

    Timer {
        id: hideTimer
        interval: 2000
        onTriggered: root.shouldShowOsd = false
    }

    LazyLoader {
        active: root.shouldShowOsd

        PanelWindow {
            anchors.right: true
            color: "transparent"
            implicitWidth: 50
            implicitHeight: 520

            Rectangle {
                id: barBackground
                anchors.fill: parent
                topLeftRadius: 25
                bottomLeftRadius: 25
                color: "#F8DAC6"
                Column {
                    anchors.centerIn: parent
					spacing: 0
					Rectangle {
						id: rootVolume
						implicitWidth: 40
         			    implicitHeight: 250
        			    color: "transparent"
						Layout.alignment: Qt.AlignHCenter
						Slider {
							id: volumeSlider
							orientation: Qt.Vertical
							Layout.alignment: Qt.AlignHCenter

							from: 0
							to: 100
							stepSize: 1

							value: (Pipewire.defaultAudioSink?.audio.volume ?? 0) * 100
                                
							implicitWidth: rootVolume.implicitWidth
							implicitHeight: rootVolume.implicitHeight - 40

							background: Rectangle {
								radius: 25
								color: "#8041282B"
								Rectangle {
									anchors.left: parent.left
									anchors.right: parent.right
									y: volumeSlider.handle.y
                                    implicitHeight: parent.height - y
                                    radius: 25
									color: "#41282B"
								}
							}

							handle: Rectangle {
    							implicitHeight: 40
    							implicitWidth: 40
    							radius: 25
    							x: volumeSlider.leftPadding + (volumeSlider.availableWidth - width) / 2
    							y: (volumeSlider.topPadding + volumeSlider.visualPosition * (volumeSlider.availableHeight - height))
    							color: "#FCEBDD"
							}

                            onValueChanged: {
        						const vol = value / 100;
        						if (Pipewire.defaultAudioSink) {
            						Pipewire.defaultAudioSink.audio.volume = vol;
        						}
    						}
						}
					}
					Rectangle {
						id: rootBrightness
						implicitWidth: 40
         			    implicitHeight: 250
        			    color: "transparent"
						Layout.alignment: Qt.AlignHCenter
						Slider {
							id: brightnessSlider
							orientation: Qt.Vertical
							Layout.alignment: Qt.AlignHCenter

							from: 0
							to: 100
							stepSize: 1

							value: targetMonitor ? targetMonitor.brightness * 100 : 0
                                
							implicitWidth: rootBrightness.implicitWidth
							implicitHeight: rootBrightness.implicitHeight - 40

							background: Rectangle {
								radius: 25
								color: "#8041282B"
								Rectangle {
									anchors.left: parent.left
									anchors.right: parent.right
									y: brightnessSlider.handle.y
                                    implicitHeight: parent.height - y
                                    radius: 25
									color: "#41282B"
								}
							}

							handle: Rectangle {
    							implicitHeight: 40
    							implicitWidth: 40
    							radius: 25
    							x: brightnessSlider.leftPadding + (brightnessSlider.availableWidth - width) / 2
    							y: (brightnessSlider.topPadding + brightnessSlider.visualPosition * (brightnessSlider.availableHeight - height))
    							color: "#FCEBDD"
							}

                            onValueChanged: {
            					if (Brightness.monitors.length > 0) {
                					Brightness.monitors[0].setBrightness(value / 100);
            					}
        					}
						}
					}
                }
            }
        }
    }
}
