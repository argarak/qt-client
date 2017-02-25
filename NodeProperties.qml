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
import QtQuick.Dialogs 1.2
import Fluid.Controls 1.0
import Fluid.Material 1.0

import "common.js" as Common
import "jsonData.js" as Data

import NodeControls 1.0

Page {
    id: propertiesPage

    NodeControls {
        id: controls
    }

    Material.background: Common.windowColor

    function getValueText(field, subField) {
        if(subField === "") {
            return nodeModel[Data.currentIndex][field]
        }
        return nodeModel[Data.currentIndex][field][subField]
    }

    AlertDialog {
        id: alert

        x: (parent.width - width) / 2
        y: (parent.height - height) / 2

        text: qsTr("Are you sure you want to remove node " + nodeModel[Data.currentIndex].label + "?")
        standardButtons: Dialog.Yes | Dialog.No

        onAccepted: {
            propertiesPage.forcePop();
            controls.remove(nodeModel[Data.currentIndex].label);
            nodeModel = controls.createNodeModel();
            Data.count = 0;
        }
    }

    Rectangle {
        id: listRectangle
        color: Common.windowColor
        width: parent.width
        height: 300
        ListView {
            id: nodePropertyList
            anchors.fill: parent
            model: ListModel {
                ListElement { title: "Label"; field: "label"; subField: "" }
                ListElement { title: "Last Online"; field: "lastOnline"; subField: "" }
                ListElement { title: "Firmware Version"; field: "firmware"; subField: "version" }
                ListElement { title: "Firmware Type"; field: "firmware"; subField: "type" }
                ListElement { title: "ROM Left"; field: "romLeft"; subField: "" }
            }
            header: Subheader {
                text: "Details"
            }
            delegate: ListItem {
                text: model.title

                valueText: getValueText(model.field, model.subField);
            }

            ScrollIndicator.vertical: ScrollIndicator {}
        }
    }

    Row {
        id: iconRow
        anchors.bottom: parent.bottom
        IconButton {
            id: buildButton
            iconName: "action/build"
            flat: true

            ToolTip.visible: hovered
            ToolTip.text: qsTr("Add/Remove Modules")
        }
        IconButton {
            iconName: "file/file_upload"
            flat: true

            ToolTip.visible: hovered
            ToolTip.text: qsTr("Upload to Node")
        }
        IconButton {
            iconName: "action/delete"
            flat: true

            ToolTip.visible: hovered
            ToolTip.text: qsTr("Remove Node")

            onClicked: alert.open();
        }
    }


    Icon {
        name: "image/brightness_1"
        anchors.verticalCenter: iconRow.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 15
        color: "#888888"
    }
}
