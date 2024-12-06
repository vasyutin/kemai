import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Page {

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
                {name: "New Profile"},
                {name: "Default", index: 11},
                {name: "Profile 1", index: 12}
            ]

            onActivated: {
                if (currentValue) {
                    loadProfile(currentValue)
                }
            }
        }

        Item {

            Layout.fillWidth: true
            Layout.fillHeight: true

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 5
                spacing: 5

                TextField {
                    id: profileNameField
                    Layout.fillWidth: true
                    placeholderText: qsTr("Enter profile name")
                    visible: profileComboBox.currentValue === undefined
                    text: "default"
                }

                TextField {
                    id: hostField
                    Layout.fillWidth: true
                    placeholderText: qsTr("Kimai Host (e.g., https://demo.kimai.org)")
                    leftPadding: 10
                    rightPadding: 10
                }
            }
        }

        Item {
            Layout.fillHeight: true
        }

        // Rectangle {
        //     radius: 5
        //     Layout.fillWidth: true
        //
        //     ColumnLayout {
        //
        //         anchors.fill: parent
        //
        //         TextField {
        //             id: profileNameField
        //             Layout.fillWidth: true
        //             placeholderText: qsTr("Enter profile name")
        //             visible: profileComboBox.currentIndex === 0
        //             text: "default"
        //         }
        //
        //         TextField {
        //             id: hostField
        //             Layout.fillWidth: true
        //             placeholderText: qsTr("Kimai Host (e.g., https://demo.kimai.org)")
        //             leftPadding: 10
        //             rightPadding: 10
        //         }
        //
        //         TextField {
        //             id: tokenField
        //             Layout.fillWidth: true
        //             placeholderText: qsTr("API Token")
        //             echoMode: TextInput.Password
        //             leftPadding: 10
        //             rightPadding: 10
        //         }
        //
        //     }
        // }
        //
        // RowLayout {
        //     Layout.fillWidth: true
        //     spacing: 10
        //
        //     Button {
        //         Layout.fillWidth: true
        //         text: qsTr("Test Connection")
        //         onClicked: testConnection()
        //         background: Rectangle {
        //             color: parent.down ? "#388E3C" : "#4CAF50"
        //             radius: 4
        //         }
        //         contentItem: Text {
        //             text: parent.text
        //             color: "white"
        //             horizontalAlignment: Text.AlignHCenter
        //             verticalAlignment: Text.AlignVCenter
        //         }
        //     }
        //
        //     Text {
        //         id: versionText
        //         Layout.fillWidth: true
        //         horizontalAlignment: Text.AlignRight
        //         verticalAlignment: Text.AlignVCenter
        //         font.italic: true
        //     }
        // }
    }

    // ColumnLayout {
    //     anchors.centerIn: parent
    //     anchors.fill: parent
    //     anchors.margins: 40
    //     spacing: 20
    //
    //     CheckBox {
    //         id: rememberMe
    //         text: qsTr("Save profile")
    //         visible: profileComboBox.currentIndex === 0
    //     }
    //
    //     Button {
    //         Layout.fillWidth: true
    //         text: qsTr("Login")
    //         onClicked: {
    //             if (profileComboBox.currentIndex === 0 && rememberMe.checked) {
    //                 saveProfile(profileNameField.text)
    //             }
    //             login()
    //         }
    //         background: Rectangle {
    //             color: parent.down ? "#1565C0" : "#2196F3"
    //             radius: 4
    //         }
    //         contentItem: Text {
    //             text: parent.text
    //             color: "white"
    //             horizontalAlignment: Text.AlignHCenter
    //             verticalAlignment: Text.AlignVCenter
    //         }
    //     }
    // }

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
        // Simulate loading a profile
        // hostField.text = "https://demo" + index + ".kimai.org"
        // tokenField.text = "token" + index
    }

    function login() {
        // TODO: Implement login logic
        console.log("Logging in with:", hostField.text, tokenField.text)
    }

    function testConnection() {
        // TODO: Implement actual API call to test connection and get version
        console.log("Testing connection to:", hostField.text)

        // Simulating an API call with a delay
        versionText.text = "Connecting..."
        timer.start()
    }

    Timer {
        id: timer
        interval: 1500 // 1.5 seconds delay to simulate API call
        onTriggered: {
            // TODO: Replace this with actual API response handling
            versionText.text = "Kimai v1.23.4" // Example version
        }
    }
}