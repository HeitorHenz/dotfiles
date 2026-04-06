import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Wayland
import Quickshell.Hyprland

ShellRoot {
    Variants {
        model: [Quickshell.screens[0]] // Main monitor only
        delegate: PanelWindow {
            id: bar
            anchors { top: true; left: true; right: true }
            height: 32
            color: "transparent"

            // Main Background with Gruvbox Styling
            Rectangle {
                anchors { fill: parent; margins: 2 }
                color: "#282828" // Gruvbox Dark
                radius: 10
                border.color: "#3c3836"
                border.width: 1
                opacity: 0.75

                RowLayout {
                    anchors.fill: parent
                    anchors.leftMargin: 12
                    anchors.rightMargin: 12
                    spacing: 0

                    // --- LEFT SECTION: Workspaces ---
                    Row {
                        Layout.alignment: Qt.AlignLeft
                        spacing: 8
                        
                        Repeater {
                            model: 3 // Shows workspaces 1-5
                            Rectangle {
                                width: 24; height: 24
                                radius: 4
                                // Color changes if workspace is active
                                color: (Hyprland.focusedWorkspace && Hyprland.focusedWorkspace.id === index + 1) 
                                       ? "#fabd2f" : "#3c3836"
                                
                                Text {
                                    anchors.centerIn: parent
                                    text: index + 1
                                    font.family: "Fira Code"
                                    font.bold: true
                                    color: (Hyprland.focusedWorkspace && Hyprland.focusedWorkspace.id === index + 1) 
                                           ? "#282828" : "#ebdbb2"
                                }

                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: Hyprland.dispatch("workspace " + (index + 1))
                                }
                            }
                        }
                    }

                    // --- CENTER SECTION: Active Window ---
                    Text {
                        Layout.fillWidth: true
                        Layout.alignment: Qt.AlignCenter
                        horizontalAlignment: Text.AlignHCenter
                        text: Hyprland.activeToplevel?.title ?? "Desktop"
                        color: "#ebdbb2"
                        font.family: "Fira Code"
                        font.weight: Font.Bold
                        font.pixelSize: 12
                        elide: Text.ElideRight
                    }

                    // --- RIGHT SECTION: System ---
                    Row {
                        Layout.alignment: Qt.AlignRight
                        spacing: 15

                        SystemClock { id: sysClock }
                        Text {
                            text: "󱑒 " + Qt.formatDateTime(sysClock.date, "dd MMM hh:mm")
                            color: "#fabd2f"
                            font.family: "Fira Code Nerd Font"
                            font.pixelSize: 13
                            font.bold: true
                        }
                    }
                }
            }
        }
    }
}
