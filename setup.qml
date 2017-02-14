import QtQuick 2.0
import QtQuick.Window 2.0
import Material 0.3
import "toSetup.js" as Setup
import "common.js" as Common

Window {
    id: setup
    signal timeout
    visible: false
    width: Common.windowWidth
    height: Common.windowHeight
    color: Common.windowColor

    Text {
        text: "Hello World"
        color: "#FFFFFF"
        font.family: "Roboto"
        font.pixelSize: 24
    }
}
