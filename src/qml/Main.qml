import QtQuick
import QtQuick.Controls

ApplicationWindow {
    width: 600
    height: 800
    visible: true

    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: LoginPage {}
    }
}
