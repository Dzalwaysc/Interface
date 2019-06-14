import QtQuick 2.0

Rectangle{
    id: box
    width: mW
    height: mH
    color: "transparent"
    border.color: "white"

    property int mW: 40
    property int mH: 40
    property string context: boxText.text
    property bool isMirror: false

    Text {
        id: boxText
        anchors.centerIn: parent
        color: "white"
        text: context
        font.family: "Monaco"
    }
}
