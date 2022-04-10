import QtQuick 2.15
import QtQuick.Controls 2.15

Button {
    id: standardButton
    implicitHeight: 40
    implicitWidth: 120

    property bool isActive : true
    property bool textUnderline: false

    contentItem: Item {
        Text {
            id: btnText
            text: standardButton.text
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            color: isActive ? "white" : "#545454"
            font.pixelSize: 12
            font.underline: standardButton.textUnderline
        }
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: standardButton.clicked()
    }

    background: Rectangle {
        id: backgroundRect
        color: isActive ? "#40CC6F" : "white";
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
