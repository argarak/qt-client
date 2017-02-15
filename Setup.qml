/* Copyright 2017 Jakub Kukiełka
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
*/

import QtQuick 2.0
import QtQuick.Window 2.0
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.1
import QtQuick.Controls.Material 2.0
import QtQuick.Controls.Universal 2.0
import QtQuick.Controls.Styles 1.3
import Material 0.2
import Material.ListItems 0.1 as ListItem
import "toSetup.js" as Setup
import "common.js" as Common
import "jsonData.js" as Data

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

    PageSidebar {
        title: "Sidebar"

        sidebar: Sidebar {
            backgroundColor: Common.sidebarColor

            Column {
                width: parent.width

                Repeater {
                    model: ListModel {
                        ListElement {
                            name: "John Smith"
                            number: "555 3264"
                        }
                        ListElement {
                            name: "John Brown"
                            number: "555 8426"
                        }
                        ListElement {
                            name: "Sam Wise"
                            number: "555 0473"
                        }
                    }

                    delegate: ListItem.Standard {
                        text: name
                        textColor: "#FFFFFF"

                        //selected: modelData == selectedComponent
                        //onClicked: selectedComponent = modelData
                    }
                }
            }
        }

        width: dp(240)
        height: setupPage.height - toolbar.height
        anchors.bottom: setupPage.bottom
        anchors.top: toolbar.bottom
    }
}
