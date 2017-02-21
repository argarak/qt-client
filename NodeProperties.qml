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
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import Fluid.Controls 1.0
import Fluid.Material 1.0
import "common.js" as Common
import "jsonData.js" as Data

Page {
    Material.background: Common.windowColor

    function getValueText(field, subField) {
        if(subField === "") {
            return nodeModel[Data.currentIndex][field]
        }
        return nodeModel[Data.currentIndex][field][subField]
    }

    ListView {
        anchors.fill: parent
        model: ListModel {
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
