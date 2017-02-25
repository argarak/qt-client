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

import QtQuick 2.4
import QtQuick.Window 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.1
import QtQuick.Controls.Material 2.0
import QtQuick.Controls.Universal 2.0
import QtQuick.Controls.Styles 1.3
import Fluid.Controls 1.0
import Fluid.Material 1.0
import Fluid.Core 1.0
import Material.ListItems 0.1 as ListItem

import "toSetup.js" as Setup
import "common.js" as Common
import "jsonData.js" as Data

import NodeControls 1.0

Page {
    id: setupPage
    signal timeout
    visible: false
    width: Common.windowWidth
    height: Common.windowHeight

    NodeControls {
        id: controls
    }

    property variant nodeModel: controls.createNodeModel()
    property bool canGoBack: false

    title: "Node Setup"
    Material.background: Common.windowColor

    actions: [
        Action {
            text: qsTr("Add")
            tooltip: qsTr("Add a new node")
            iconName: "content/add"
            onTriggered: pageStack.push(Qt.resolvedUrl("NodeWizard.qml"));
        },
        Action {
            text: qsTr("Preferences")
            iconName: "action/settings"
            tooltip: qsTr("Change preferences")
            onTriggered: console.log("Display preferences window")
        }
    ]

    Pane {
        id: leftSidebar
        anchors {
            left: parent.left
            top: parent.top
            bottom: parent.bottom
        }
        width: 200
        padding: 0
        z: 2

        Material.background: Common.sidebarColor
        Material.elevation: 1

        Universal.background: Universal.accent

        ListView {
            id: listView
            anchors.fill: parent
            currentIndex: 0

            model: nodeModel

            header: Subheader {
                text: qsTr("Nodes")
                textColor: "#888888"
            }
            delegate: ListItem.Standard {
                text: Data.assignValue(nodeModel);
                textColor: "#FFFFFF"

                onClicked: Data.onNodeClicked(setupStack, index);
            }

            ScrollBar.vertical: ScrollBar {}
        }
    }
    StackView {
        id: setupStack
        width: setupPage.width - leftSidebar.width
        height: setupPage.height - appBar.height

        anchors.right: parent.right

        initialItem: Rectangle {
            id: rightPage
            width: setupPage.width - leftSidebar.width
            height: setupPage.height - appBar.height
            anchors.centerIn: parent
            color: Common.windowColor

            Item {
                anchors.centerIn: parent
                Image {
                    id: pic
                    source: "qrc:/img/select_node.svg"
                    anchors.horizontalCenter: parent.horizontalCenter
                    y: ((setupStack.height / 2) - (pic.height / 2) - (picLabel.height / 2) - 30)
                    sourceSize.width: rightPage.width / (rootWindow.width / 300)
                    sourceSize.height: rightPage.width / (rootWindow.width / 300)
                }
                Label {
                    id: picLabel
                    width: rightPage.width
                    height: rightPage.height
                    horizontalAlignment: Text.AlignHCenter
                    anchors.horizontalCenter: pic.horizontalCenter
                    anchors.top: pic.bottom
                    anchors.topMargin: 5
                    text: "Select a node to see its properties!"
                    font.family: "Roboto"
                    font.pixelSize: 18
                    wrapMode: Text.WordWrap
                }
            }
        }
    }
}

