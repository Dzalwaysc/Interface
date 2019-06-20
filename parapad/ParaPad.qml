import QtQuick 2.9
import QtQuick.Controls 1.4

Rectangle{
    id:actualParameter
    x: posX; y: posY
    color: "ivory"
    border.color: "black"
    border.width: 2
    radius: 4
    opacity: 0
    width: 300; height: 120

    property real posX: 0
    property real posY: 0

    property real fontsize: 12
    property color fontcolor: "black"
    property string fontfamily: "Monaco"

    property double north_X
    property double east_Y
    property double yaw
    property double u
    property double v
    property double r

    states: State {
        name: "active"
        PropertyChanges {target: actualParameter; opacity: 1; x: posX-320}
    }

    transitions: [
        Transition {
            from: ""; to: "active"; reversible: false
            NumberAnimation{properties: "opacity, x"; duration: 100; easing.type: Easing.Linear}
        },
        Transition {
            from: "active"; to: ""; reversible: false
            NumberAnimation{properties: "opacity, x"; duration: 100; easing.type: Easing.Linear}
        }
    ]

    Text {
        id: title
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter
        text: "Actual Parameter"
        font.pixelSize: fontsize
        font.family: fontfamily
        color: fontcolor
    }

    Grid{
        id: x_y_yaw_parameter
        anchors.top: title.bottom; anchors.topMargin: 10
        anchors.left: parent.left; anchors.leftMargin: 25
        rows: 3
        rowSpacing: parent.height*0.015
        columns: 2
        columnSpacing: 20
        horizontalItemAlignment: Qt.AlignLeft
        verticalItemAlignment: Qt.AlignLeft

        // 若不加矩形，在数字为有小数点和没小数点之间转变的时候，左边的文字会来回跳
        Rectangle{
            width: 125; height: 20
            color: "transparent"
            Label{
                text:"北向位置X: " + north_X.toString() + "m"
                clip: true
                font.pixelSize: fontsize
                font.family: fontfamily
                color: fontcolor
            }
        }

        Rectangle{
            width: 125; height: 20
            color: "transparent"
            Label{
                text:"纵荡速度u: " + u.toString() + "m/s"
                clip: true
                font.pixelSize: fontsize
                font.family: fontfamily
                color: fontcolor
            }
        }

        Rectangle{
            width: 125; height: 20
            color: "transparent"
            Label{
                text:"南向位置Y: " + east_Y.toString() + "m"
                clip: true
                font.pixelSize: fontsize
                font.family: fontfamily
                color: fontcolor
            }
        }

        Rectangle{
            width: 125; height: 20
            color: "transparent"
            Label{
                text:"横荡速度v: " + v.toString() + "m/s"
                clip: true
                font.pixelSize: fontsize
                font.family: fontfamily
                color: fontcolor
            }
        }

        Rectangle{
            width: 125; height: 20
            color: "transparent"
            Label{
                text:"艏向角度YAW: " + yaw.toString() + "°"
                clip: true
                font.pixelSize: fontsize
                font.family: fontfamily
                color: fontcolor
            }
        }

        Rectangle{
            width: 125; height: 20
            color: "transparent"
            Label{
                text:"艏摇速度r: " + r.toString() + "°/s"
                clip: true
                font.pixelSize: fontsize
                font.family: fontfamily
                color: fontcolor
            }
        }
    }
}




