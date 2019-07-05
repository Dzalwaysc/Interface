import QtQuick 2.0
import QtGraphicalEffects 1.0

Rectangle{
    id: message
    width: 380; height: 200
    color: rectColor
    border.color: borderColor
    border.width: 1
    opacity: 0
    radius: 4
    x: defaultx
    y: posy

    // 暴露给外部使用的属性
    property double defaultx: -500
    property double activex: 2
    property double posy: 230
    property color rectColor: Qt.rgba(255, 0, 0, .4)
    property color borderColor: Qt.rgba(255, 0, 0, .4)

    // 字体
    property string fontfamily: "Monaco"
    property color fontcolor: "white"
    property real fontpixelSize: 13

    states: [
        State {
                name: "active"
                PropertyChanges {target: message; opacity: 1; x: activex}
        },
        State {
            name: ""
            PropertyChanges {target: message; opacity: 0; x:defaultx}
        }
    ]

    transitions: [
        Transition {
            from: "";  to: "active"; reversible: false
            NumberAnimation{properties: "opacity, x"; duration: 100; easing.type: Easing.Linear}
        },
        Transition {
            from: "active"; to: ""; reversible: false
            NumberAnimation{properties: "opacity, x"; duration: 100; easing.type: Easing.Linear}
        }
    ]

    Image {
        id: close_circle
        width: 13; height: 13
        source: "image/circle.png"
        anchors.left: message.left; anchors.leftMargin: 5
        anchors.top: message.top; anchors.topMargin: 4
        opacity: 1
        MouseArea{
            anchors.fill: parent
            hoverEnabled: message.state === "active" ? true : false
            enabled: message.state === "active" ? true : false
            onEntered: {
                close_close.opacity = 1;
            }
            onExited: close_close.opacity = 0;
            onClicked: {
                message.state = "";
            }
        }
    }

    Image {
        id: close_close
        width: 8; height: 8
        source: "image/close.png"
        anchors.horizontalCenter: close_circle.horizontalCenter
        anchors.verticalCenter: close_circle.verticalCenter
        opacity: 0
    }
}

