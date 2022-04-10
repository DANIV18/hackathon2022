import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Styles 1.4

import Controllers 1.0

Window {
    id: mainWindow
    width: 1110
    height: 610

    minimumWidth: 1110
    minimumHeight: 610

    maximumWidth: 1110
    maximumHeight: 610

    visible: true
    color: "#ffffff"

    LoginController {
        id: loginCtrl
    }

    Rectangle {
        id: titleBar
        width: parent.width
        height: 40
        color: "transparent"
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        z: 10

        DragHandler {
            onActiveChanged: if (active) {
                                 mainWindow.startSystemMove()
                             }
        }
    }

    Rectangle {
        id: gifSection
        width: 653
        color: "#00000000"
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.leftMargin: 0
        anchors.topMargin: 0
        anchors.bottomMargin: 0

        AnimatedImage {
            id: heroImage
            anchors.fill: parent
            source: "qrc:/images/coding.gif"
            fillMode: Image.PreserveAspectFit
        }
    }

    Rectangle {
        id: formSection
        color: "#00000000"
        anchors.left: gifSection.right
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.leftMargin: 0

        states: State {
            name: "login"
            PropertyChanges { target: verifyInput; opacity:0 }
            PropertyChanges { target: forgotPasswordButton; opacity: 1}

        } State {
            name: "registration"
            PropertyChanges { target: verifyInput; opacity:1 }
            PropertyChanges { target: forgotPasswordButton; opacity:1}

        }

        transitions: Transition {
            ParallelAnimation{
                PropertyAnimation { target: forgotPasswordButton;  property: "opacity"; duration: 500;}
                PropertyAnimation { target: verifyInput;  property: "opacity"; duration: 500;}
            }
        }

        Component.onCompleted: formSection.state = 'login'


        TButton {
            id: loginButton
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: 79
            anchors.topMargin: 58
            text: "Login"
            onClicked: formSection.state = 'login'
            isActive: formSection.state == 'login'
        }

        TButton {
            id: registerButton
            anchors.top: parent.top
            anchors.leftMargin: 0
            anchors.topMargin: 58
            text: "Register"
            anchors.left: loginButton.right
            onClicked: formSection.state = 'registration'
            isActive: formSection.state == 'registration'
        }


        Label {
            id: welcomeLabel
            text: qsTr("Welcome")
            anchors.left: parent.left
            anchors.top: loginButton.bottom
            font.pixelSize: 36
            anchors.leftMargin: 79
            anchors.topMargin: 30
            font.bold: true
        }

        Label {
            id: welcomeDescription
            color: "#545454"
            text: qsTr("Pleace login to your account")
            anchors.left: parent.left
            anchors.top: welcomeLabel.bottom
            font.pixelSize: 12
            anchors.leftMargin: 79
            anchors.topMargin: 0
        }

        FormInput {
            id: usernameInput
            anchors.left: parent.left
            anchors.top: welcomeDescription.bottom
            anchors.leftMargin: 79
            anchors.topMargin: 20
            inputLabel: qsTr("Username or Email")

            TextInput {
                id: inputUsername
                y: 20
                height: 32
                color: "#545454"
                anchors.left: parent.left
                anchors.right: parent.right
                font.pixelSize: 12
                verticalAlignment: Text.AlignVCenter
                anchors.rightMargin: 0
                anchors.leftMargin: 0
                maximumLength: 31
                echoMode: TextInput.Normal

                onTextChanged: {
                    var regExp =  /(^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$)|(^(?=.*[A-Za-z0-9]$)[A-Za-z][A-Za-z\d.-]{0,19}$)/;
                    (regExp.test(this.text))?this.color = "#62aa46":this.color = "#ff0000";
                }
            }
        }

        FormInput {
            id: passwordInput
            anchors.left: parent.left
            anchors.top: usernameInput.bottom
            anchors.topMargin: 20
            anchors.leftMargin: 79
            inputLabel: "Password"

            TextInput {
                id: inputPasswd
                y: 20
                height: 32
                color: "#545454"
                anchors.left: parent.left
                anchors.right: parent.right
                font.pixelSize: 12
                verticalAlignment: Text.AlignVCenter
                anchors.rightMargin: 0
                anchors.leftMargin: 0
                maximumLength: 24
                echoMode: TextInput.Password

                onTextChanged:
                {
                    //Minimum eight characters, at least one letter and one number:
                    var regExp = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$/;
                    (regExp.test(this.text))?this.color = "#62aa46":this.color = "#ff0000";

                }
            }

        }

        FormInput {
            id: verifyInput
            anchors.left: parent.left
            anchors.top: passwordInput.bottom
            anchors.topMargin: 20
            anchors.leftMargin: 79
            inputLabel: "Verify password"
            visible: true

            TextInput {
                id: verifyPasswd
                y: 20
                height: 32
                color: "#545454"
                anchors.left: parent.left
                anchors.right: parent.right
                font.pixelSize: 12
                verticalAlignment: Text.AlignVCenter
                anchors.rightMargin: 0
                anchors.leftMargin: 0
                maximumLength: 24
                echoMode: TextInput.Password

                onTextChanged: {
                    color = text === inputPasswd.text ? "#62aa46" : "#ff0000";
                }
            }
        }


        TButton {
            id: okButton
            text: "OK"
            anchors.right: parent.right
            anchors.top: verifyInput.bottom
            anchors.topMargin: 15
            anchors.rightMargin: 79

            onClicked: {
                if (formSection.state == 'login')
                    loginCtrl.login(inputUsername.text, inputPasswd.text)
                else if (formSection.state == 'registration' && inputPasswd.text === verifyPasswd.text)
                    loginCtrl.registration(inputUsername.text, inputPasswd.text)
            }
        }

        Button {
            id: forgotPasswordButton
            implicitHeight: 40
            implicitWidth: 120
            anchors.top: verifyInput.bottom
            anchors.leftMargin: 79
            anchors.left: parent.left
            anchors.topMargin: 15
            visible: true
            opacity: 0.99

            contentItem: Item {
                Text {
                    id: btnText
                    text: "Forgot Password"
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: "#545454"
                    font.pixelSize: 12
                    font.underline: true
                    opacity: forgotPasswordButton.opacity
                }
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                }
            }

            background: Rectangle {
                id: backgroundRect
                color: "#ffffff"
                radius: 50
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.rightMargin: 0
                anchors.leftMargin: 0
                anchors.bottomMargin: 0
                anchors.topMargin: 0
            }
        }
    }
}
