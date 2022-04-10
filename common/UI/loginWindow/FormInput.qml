import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    id: formInput
    height: 52
    color: "#ffffff"
    width: 289

    property string inputLabel

    Rectangle {
        id: inputBottomLine
        height: 0.7
        width: formInput.width
        color: "#aaaaaa"
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.IBeamCursor
    }

    Text {
        id: fieldLabel
        text: inputLabel
        font.pixelSize: 12
        color: "#aaaaaa"
    }
}
