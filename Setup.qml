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
        id: leftSidebar
        title: "Sidebar"

        sidebar: Sidebar {
            backgroundColor: Common.sidebarColor

            Column {
                width: parent.width

                Repeater {
                    model: nodeModel

                    delegate: ListItem.Standard {
                        text: Data.assignValue(nodeModel);
                        textColor: "#FFFFFF"

                        onClicked: Data.onNodeClicked();
                    }
                }
            }
        }

        width: dp(240)
        height: setupPage.height - toolbar.height
        anchors.bottom: setupPage.bottom
        anchors.top: toolbar.bottom
    }

    StackView {
        id: setupStack
        width: setupPage.width - leftSidebar.width
        height: setupPage.height - toolbar.height
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        initialItem: Rectangle {
            id: rightPage
            width: setupPage.width - leftSidebar.width
            height: setupPage.height - toolbar.height
            anchors.centerIn: parent
            color: Common.windowColor

            Item {
                anchors.centerIn: parent
                Image {
                    id: pic
                    source: "qrc:/img/select_node.svg"
                    anchors.horizontalCenter: parent.horizontalCenter
                    y: (setupStack.height / 2) - (pic.height / 2) - (picLabel.height / 2) - 30
                    sourceSize.width: rightPage.width / (rootWindow.width / 400)
                    sourceSize.height: rightPage.width / (rootWindow.width / 400)
                }
                Text {
                    id: picLabel
                    width: rightPage.width
                    height: rightPage.height
                    horizontalAlignment: Text.AlignHCenter
                    anchors.horizontalCenter: pic.horizontalCenter
                    anchors.top: pic.bottom
                    anchors.topMargin: 5
                    text: "Select a node to see its properties!"
                    font.family: "Roboto"
                    font.pixelSize: 24
                    wrapMode: Text.WordWrap
                    color: "#FFFFFF"
                }
            }
        }
    }
}
