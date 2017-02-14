import QtQuick 2.0
import QtQuick.Window 2.0
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.1
import QtQuick.Controls.Material 2.0
import QtQuick.Controls.Universal 2.0
import QtQuick.Controls.Styles 1.3
import QtGraphicalEffects 1.0
import "toSetup.js" as Setup
import "common.js" as Common

ApplicationWindow {
    id: rootWindow
    signal timeout
    visible: false
    width: Common.windowWidth
    height: Common.windowHeight
    color: Common.windowColor

    header: ToolBar {
        background: Rectangle {
            color: "#111111"
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
                ToolTip.delay: 1000
                ToolTip.timeout: 5000
                ToolTip.visible: hovered
                ToolTip.text: qsTr("Preferences")
            }
        }
    }
}
