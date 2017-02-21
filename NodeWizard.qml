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
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.1
import QtQuick.Controls.Material 2.0
import Fluid.Controls 1.0
import Fluid.Material 1.0

import "common.js" as Common
import "jsonData.js" as Data

import NodeControls 1.0

Page {
    id: wizardPage

    NodeControls {
        id: controls
    }

    title: qsTr("Create a new Node")

    Material.background: Common.windowColor

    actions: [
        Action {
            text: qsTr("Proceed")
            tooltip: qsTr("Go forward")
            iconName: "navigation/arrow_forward"
            onTriggered: pageStack.push(Qt.resolvedUrl("NodeWizardSetup.qml"));
        }
    ]

    Item {
        anchors.fill: parent
        Image {
            id: pic
            source: "qrc:/img/add_node.svg"
            sourceSize.height: wizardPage.height / 2
            sourceSize.width: wizardPage.width / 2
            anchors.centerIn: parent
        }
        Label {
            anchors.top: pic.bottom
            anchors.topMargin: 20
            anchors.horizontalCenter: pic.horizontalCenter
            text: "Click the right arrow to setup a new node!"
            font.pixelSize: 18
            wrapMode: Text.WordWrap
        }
    }
}
