import QtQuick 2.0
import QtQuick.Window 2.0
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import QtQuick.Controls.Universal 2.0
import Material 0.3
//import "setup.qml"
import "toSetup.js" as Setup
import "common.js" as Common

ApplicationWindow {
    modality: Qt.ApplicationModal
    flags: Qt.SplashScreen
    property int timeoutInterval: 2000
    signal timeout

    visible: true
    width: Common.windowWidth
    height: Common.windowHeight
    title: qsTr("mirpm client v0.1")
    color: Common.windowColor
    id: rootWindow

    Column {
        Image {
            source: "qrc:/img/mirpm.png"
            width: 200
            height: 200
        }
        Text {
            text: "mirpm\nQt Client"
            color: "#FFFFFF"
            horizontalAlignment: Text.AlignHCenter
            font.family: "Roboto"
            font.pixelSize: 24
            width: 200
        }
        spacing: 20
        anchors.centerIn: parent
    }

    ProgressBar {
        indeterminate: true
        width: rootWindow.width
    }

    Text {
        text: "v0.1"
        color: "#1a1a1a"
        font.family: "Roboto"
        font.pixelSize: 20
        horizontalAlignment: Text.AlignRight
        width: rootWindow.width
        anchors.bottom: parent.bottom
    }

    Loader {
        source: "setup.qml";
    }

    Timer {
        interval: timeoutInterval
        running: true; repeat: false
        onTriggered: {
            Setup.toSetup()
        }
    }
    Component.onCompleted: visible = true
}
