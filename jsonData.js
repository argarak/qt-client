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

.pragma library

var count = 0;
var currentIndex = 0;

function assignValue(nodeModel) {
    count++;
    console.log(JSON.stringify(nodeModel[0]));
    return nodeModel[count - 1].label;
}

function onNodeClicked(stack, index) {
    //console.log("node " + index + " clicked!");
    currentIndex = index;
    stack.push(Qt.resolvedUrl("NodeProperties.qml"));
}
