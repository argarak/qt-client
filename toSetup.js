function toSetup() {
    rootWindow.timeout();
    visible = false;
    var component = Qt.createComponent("Setup.qml");
    var window = component.createObject(rootWindow);
    console.log(window);
    window.show();
}
