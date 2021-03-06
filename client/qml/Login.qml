import QtQuick 2.0
import QtQuick.Controls 1.0

Item {
    //color: "#eee"
    property variant window
    id: thisLogin

    function login(pretend) {
        label.text = qsTr("Please wait...")
        if (!pretend) window.login(userNameField.text, passwordField.text, null, homeserverField.text)
        userNameField.enabled = false
        passwordField.enabled = false
        homeserverField.enabled = false
        userNameField.opacity = 0
        passwordField.opacity = 0
        homeserverField.opacity = 0
    }

    function restore(msg) {
        userNameField.enabled = true
        passwordField.enabled = true
        homeserverField.enabled = true
        userNameField.opacity = 1
        passwordField.opacity = 1
        homeserverField.opacity = 1
        logoAnimation.start()
        thisLogin.visible = true
        label.text = qsTr(msg)
    }

    function hide() {
        logoAnimation.stop()
        thisLogin.visible = false
    }

    Column {
        width: parent.width / 2
        anchors.centerIn: parent
        opacity: 0
        spacing: 18

        Item {
            width: parent.width
            height: 1
        }

        Item {
            width: 256
            height: 256
            anchors.horizontalCenter: parent.horizontalCenter
            Image {
                anchors.fill: parent
                fillMode: Image.PreserveAspectFit
                antialiasing: true
                source: "qrc:/logo.png"

                RotationAnimation on rotation {
                    id: logoAnimation
                    loops: Animation.Infinite
                    from: 0
                    to: 360
                    duration: 60000
                }
            }
        }

        Label { id: phantomLabel; visible: false }

        Label {
            id: label
            font.pixelSize: phantomLabel.font.pixelSize * 5/2
            text: qsTr("Tensor")
            color: "#888"
        }

        TextField {
            id: userNameField
            width: parent.width
            placeholderText: qsTr("Username")
        }

        TextField {
            id: homeserverField
            width: parent.width
            text: "https://matrix.org"
        }

        TextField {
            id: passwordField
            echoMode: TextInput.Password
            width: parent.width
            placeholderText: qsTr("Password")
            onAccepted: login()
        }

        NumberAnimation on opacity {
            id: fadeIn
            to: 1.0
            duration: 2000
        }

        Component.onCompleted: fadeIn.start()
    }
}
