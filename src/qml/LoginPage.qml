import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "requests.js" as Requests

Page {

    id: root
    property bool isNewProfile: profileComboBox.currentValue === -1

    ColumnLayout {

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.fill: parent
        anchors.margins: 40
        spacing: 20

        Image {
            Layout.alignment: Qt.AlignHCenter
            source: "qrc:/kemai/images/kimai_logo_transparent.svg"
            sourceSize.width: 100
            sourceSize.height: 100
        }

        ComboBox {
            id: profileComboBox
            Layout.fillWidth: true

            // TODO: Replace with real model
            textRole: "name"
            valueRole: "index"
            model: [
                {name: "New Profile ...", index: -1},
                {name: "Default", index: 11},
                {name: "Profile 1", index: 12}
            ]

            onActivated: {
                loadProfile(currentValue)
            }
        }

        Item {

            Layout.fillWidth: true
            Layout.fillHeight: true

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 5
                spacing: 10

                TextField {
                    id: profileNameField
                    Layout.fillWidth: true
                    placeholderText: qsTr("Enter profile name")
                    leftPadding: 10
                    rightPadding: 10
                }

                TextField {
                    id: hostField
                    Layout.fillWidth: true
                    placeholderText: qsTr("Kimai Host (e.g., https://demo.kimai.org)")
                    leftPadding: 10
                    rightPadding: 10
                }

                RowLayout {
                    Layout.fillWidth: true

                    TextField {
                        id: tokenField
                        Layout.fillWidth: true
                        placeholderText: qsTr("API Token")
                        echoMode: passwordVisibilityButton.checked ? TextInput.Password : TextInput.Normal
                        leftPadding: 10
                        rightPadding: 10
                    }

                    RoundButton {
                        id: passwordVisibilityButton
                        flat: true
                        checkable: true
                        checked: true
                        icon.source: checked ? "qrc:/kemai/images/visibility_off.svg" : "qrc:/kemai/images/visibility_on.svg"
                    }
                }
            }
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: 10

            Button {
                Layout.fillWidth: true
                text: qsTr("Test Connection")
                onClicked: testConnection()
                background: Rectangle {
                    color: parent.down ? "#388E3C" : "#4CAF50"
                    radius: 4
                }
            }

            Text {
                id: versionText
                color: "white"
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignRight
                verticalAlignment: Text.AlignVCenter
                font.italic: true
            }
        }

        Item {
            Layout.fillHeight: true
        }

        RoundButton {
            Layout.fillWidth: true

            text: root.isNewProfile ? qsTr("Save && Login") : qsTr("Login")

            background: Rectangle {
                color: parent.down ? "#1565C0" : "#2196F3"
                radius: parent.radius
            }

            onClicked: {
                login()
            }
        }
    }

    function saveProfile(profileName) {
        if (profileName.trim() === "") {
            console.log("Profile name cannot be empty")
            return
        }
        // TODO: Implement saving profile logic
        console.log("Saving profile:", profileName, hostField.text, tokenField.text)
        // After saving, update the profileComboBox model
        profileComboBox.model.append({text: profileName})
    }

    function loadProfile(index) {
        // TODO: Implement loading profile logic
        console.log("Loading profile:", index)
        if (index === -1) {
            profileNameField.text = ""
            hostField.text = ""
            tokenField.text = ""

        } else {
            profileNameField.text = profileComboBox.currentText
            hostField.text = "https://demo-stable.kimai.org"
            tokenField.text = "1f715dca8821e39a7bb1f8733"
        }
    }

    function login() {
        // TODO: Implement login logic
        console.log("Logging in with:", hostField.text, tokenField.text)
    }

    function testConnection() {
        console.log("Testing connection to:", hostField.text)

        Requests.getVersion(hostField.text, tokenField.text, function (response) {
            if (response.status === 200) {
                versionText.text = "Kimai v" + response.data.version
            } else {
                versionText.text = "Connection failed: " + response.statusText
            }
        })
    }
}