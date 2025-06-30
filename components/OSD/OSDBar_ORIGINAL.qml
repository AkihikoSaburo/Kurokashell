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

    property bool shouldShowOsd: true

    // Timer {
    //     id: hideTimer
    //     interval: 1000
    //     onTriggered: root.shouldShowOsd = false
    // }

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
                    anchors.fill: parent
					spacing: 0
					Rectangle {
						id: rootVolume
						implicitWidth: 40
         			    implicitHeight: 250
        			    color: "transparent"
						Layout.alignment: Qt.AlignHCenter
						Column {
							anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.left
							spacing: 0
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
									width: implicitWidth
									height: volumeSlider.availableHeight
									implicitHeight: parent.implicitHeight
									implicitWidth: parent.implicitWidth
									radius: 1000
									color: "#8041282B"
									anchors.horizontalCenter: parent.horizontalCenter
									Rectangle {
										anchors.left: parent.left
										anchors.right: parent.right
										y: parent.height - height
										height: (1 - volumeSlider.visualPosition) * parent.height
										width: parent.width
										radius: Math.min(width, height) / 2
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
					}
					Rectangle {
						id: rootBrightness
						implicitWidth: 40
         			    implicitHeight: 250
        			    color: "red"
						Layout.alignment: Qt.AlignHCenter
						Column {
							anchors.centerIn: parent
							spacing: 0
							Slider {
								id: brightnessSlider
								orientation: Qt.Vertical
								Layout.alignment: Qt.AlignHCenter
								from: 0
								to: 100
								stepSize: 1
								implicitWidth: rootVolume.implicitWidth
								implicitHeight: rootVolume.implicitHeight - 40
							}
						}
					}

                    // // VOLUME SLIDER
                    // Slider {
                    //     id: volumeSlider
                    //     orientation: Qt.Vertical
                    //     from: 0
                    //     to: 100
                    //     value: (Pipewire.defaultAudioSink?.audio.volume ?? 0) * 100
                    //     Layout.alignment: Qt.AlignHCenter
                    //     implicitWidth: 40
                    //     implicitHeight: 250
                    //     stepSize: 1

                    //     onValueChanged: {
                    //         if (Pipewire.defaultAudioSink?.audio) {
                    //             Pipewire.defaultAudioSink.audio.volume = volume / 100;
                    //         }
                    //     }

                    //     handle: Item {
                    //         width: 40
                    //         height: 40

                    //         Rectangle {
                    //             anchors.fill: parent
                    //             radius: width / 2
                    //             color: "#FCEBDD"

                    //             Item {
                    //                 anchors.centerIn: parent

                    //                 property bool showValue: volumeSlider.pressed

                    //                 Text {
                    //                     visible: showValue
                    //                     text: Math.round(volumeSlider.value) + "%"
                    //                     font.pixelSize: 12
                    //                     color: "#000"
                    //                     font.bold: true
                    //                 }

                    //                 MaterialIcon {
                    //                     visible: !showValue
                    //                     icon: "volume_up"
                    //                     implicitHeight: 24
                    //                     implicitWidth: 24
                    //                     anchors.centerIn: parent
                    //                     color: "#000"
                    //                 }
                    //             }
                    //         }
                    //     }

                    //     background: Rectangle {
                    //         anchors.fill: parent
                    //         radius: width / 2
                    //         color: "#8041282B"

                    //         Rectangle {
                    //             width: parent.width
                    //             height: parent.height * (volumeSlider.value / 100)
                    //             color: "#41282B"
                    //             radius: width / 2
                    //             anchors.bottom: parent.bottom
                    //         }
                    //     }
                    // }

                    // Rectangle {
                    //     width: 40
                    //     height: 40
                    //     color: "transparent"

                    //     Text {
                    //         anchors.centerIn: parent
                    //         text: Math.round(volumeSlider.value) + "%"
                    //         font.bold: true
                    //         font.pixelSize: 10
                    //         color: "#000"
                    //     }
                    // }

                    // BRIGHTNESS nanti ya onichan~
                }
            }
        }
    }
}
