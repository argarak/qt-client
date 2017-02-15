import QtQuick 2.0
import QtQuick.Window 2.0
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.1
import QtQuick.Controls.Material 2.0
import QtQuick.Controls.Universal 2.0
import QtQuick.Controls.Styles 1.3
import Material 0.3
import "toSetup.js" as Setup
import "common.js" as Common

Page {
    id: setupPage
    signal timeout
    visible: false
    width: Common.windowWidth
    height: Common.windowHeight
    backgroundColor: Common.windowColor

    ToolBar {
        id: toolbar
        width: setupPage.width
        background: Rectangle {
            color: Common.toolbarColor
        }

        RowLayout {
            anchors.fill: parent
            ToolButton {
                Image {
                    source: "qrc:/icons/content/add.svg"
                    height: parent.height - 10
                    width: parent.height - 10
                    anchors.centerIn: parent
                }
                Text {
                    text: "Create new node"

                    anchors.left: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    color: "#FFFFFF"
                    font.family: "Roboto"
                    font.pixelSize: 12
                }
            }
            Item { Layout.fillWidth: true }
            ToolButton {
                Image {
                    source: "qrc:/icons/action/settings.svg"
                    height: parent.height - 10
                    width: parent.height - 10
                    anchors.centerIn: parent
                }
            }
        }
    }

//    GridLayout {
//        anchors.fill: parent
//        columns: 2
//        Layout.preferredWidth: 30
//        Rectangle {
//            color: "#ff0000"
//            ListView {
//                model: ListModel {
//                    ListElement {
//                        name: "John Smith"
//                        number: "555 3264"
//                    }
//                    ListElement {
//                        name: "John Brown"
//                        number: "555 8426"
//                    }
//                    ListElement {
//                        name: "Sam Wise"
//                        number: "555 0473"
//                    }
//                }

//                highlight: Rectangle {
//                    color: "#888888";
//                }

//                //focus: true

//                delegate: Text {
//                    text: name + ": " + number
//                    font.family: "Roboto"
//                    font.pixelSize: 24
//                    color: "#FFFFFF"
//                }
//            }
//        }


//        Text {
//            text: "Welcome Message!"
//            font.family: "Roboto"
//            font.pixelSize: 24
//            color: "#FFFFFF"
//        }

//        //spacing: 20
//    }

    PageSidebar {
        title: "Sidebar"

        sidebar: Sidebar {
            backgroundColor: Common.sidebarColor
        }

        width: dp(240)
        height: setupPage.height - toolbar.height
        anchors.bottom: setupPage.bottom
        anchors.top: toolbar.bottom
    }

}
