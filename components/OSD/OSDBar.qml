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

	required property ShellScreen screen
	

    Connections {
        target: Audio

        function onVolumeChanged() {
            root.shouldShowOsd = true;
            hideTimer.restart();
        }
    }

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

	required property Brightness.Monitor monitor

	monitor: Brightness.getMonitorForScreen(screen)

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
                ColumnLayout {
					id: columnRoot

                    anchors.centerIn: parent
					spacing: 0
					Rectangle {
						id: rootVolume
						implicitWidth: 40
         			    implicitHeight: 250
        			    color: "transparent"
						Layout.alignment: Qt.AlignHCenter
						Column {
							Slider {
								id: volumeSlider
								orientation: Qt.Vertical
								Layout.alignment: Qt.AlignHCenter

								value: Audio.volume
                                
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
									id: volumeHandle
    								implicitHeight: 40
    								implicitWidth: 40
    								radius: 25
    								x: volumeSlider.leftPadding + (volumeSlider.availableWidth - width) / 2
    								y: (volumeSlider.topPadding + volumeSlider.visualPosition * (volumeSlider.availableHeight - height))
    								color: "#FCEBDD"
								
    								Text {
										anchors.centerIn: parent
										text: Math.round(volumeSlider.value * 100)
									}
								}
								onMoved: Audio.setVolume(value)
							}
							MaterialIcon {
        						id: volumeIcon
        						icon: "volume_up"
        						anchors.left: parent.left
								anchors.leftMargin: 4
        						scale: 1.0
							}
						}
					}
					Rectangle {
						id: rootBrightness
						implicitWidth: 40
         			    implicitHeight: 250
        			    color: "transparent"
						Layout.alignment: Qt.AlignHCenter
						Column {
							Slider {
								id: brightnessSlider
								orientation: Qt.Vertical
								Layout.alignment: Qt.AlignHCenter

								value: root.monitor?.brightness ?? 0
								onMoved: root.monitor?.setBrightness(value)
                                
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
									Text {
										anchors.centerIn: parent
										text: Math.round(brightnessSlider.value * 100)
									}
								}
							}
							MaterialIcon {
        						id: brightnessIcon
								anchors.left: parent.left
								anchors.leftMargin: 4
        						icon: "brightness_7"
        						scale: 1.0
							}
						}
					}
				}
            }
        }
    }
}
