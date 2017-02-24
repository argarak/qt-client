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

    property string globalLabel: ""
    property string globalType: ""

    NodeControls {
        id: controls
    }

    title: qsTr("Create a new Node")

    Material.background: Common.windowColor

    actions: [
        Action {
            text: qsTr("Proceed")
            tooltip: qsTr("Finish")
            iconName: "action/done"
            onTriggered: {
                controls.addEmpty(globalLabel, globalType);
                pageStack.push(doneItem);
            }
        }
    ]

    Item {
        anchors.fill: parent
        ListView {
            id: nodePropertyList
            anchors.fill: parent
            model: ListModel {
                ListElement { title: "Label"; type: "field" }
                ListElement { title: "Board"; type: "combo" }
            }
            header: Subheader {
                text: "Details"
            }
            delegate: ListItem {
                text: model.title

                Loader {
                    id: loader
                    anchors.right: parent.right
                    anchors.rightMargin: 20
                    sourceComponent: {
                        switch(model.type) {
                            case "combo":
                                return comboDelegate
                            case "field":
                                return fieldDelegate
                        }
                    }
                }

                Component {
                    id: comboDelegate

                    ComboBox {
                        id: nodeType
                        width: 200
                        model: ListModel {
                            id: model
                            ListElement { type: "AVR" }
                        }
                        onCurrentIndexChanged: {
                            console.log(model.get(currentIndex).type);
                            globalType = model.get(currentIndex).type;
                        }
                    }

                }

                Component {
                    id: fieldDelegate

                    TextField {
                        id: nodeLabel
                        width: 200
                        onEditingFinished: {
                            console.log(nodeLabel.getText(0, nodeLabel.length));
                            globalLabel = nodeLabel.getText(0, nodeLabel.length);
                        }
                    }
                }
            }

            ScrollIndicator.vertical: ScrollIndicator {}
        }
    }

    Component {
        id: doneItem
        Page {
            title: qsTr("Completed!")
            property bool canGoBack: false

            actions: [
                Action {
                    iconName: "hardware/keyboard_return"
                    tooltip: "Go back to Node list"
                    text: "Back"
                    onTriggered: pageStack.push(Qt.resolvedUrl("Setup.qml"));
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
                    text: "Node setup completed successfully!"
                    font.pixelSize: 18
                    wrapMode: Text.WordWrap
                }
            }
        }
    }
}
