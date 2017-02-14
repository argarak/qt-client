function toSetup() {
    rootWindow.timeout();
    visible = false;
    var component = Qt.createComponent("setup.qml")
    var window = component.createObject(rootWindow)
    window.show()
}
