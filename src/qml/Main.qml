import QtQuick
import QtQuick.Controls

ApplicationWindow {

    id: main
    required property var profileModel

    width: 600
    height: 800
    visible: true

    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: LoginPage {}
    }
}
