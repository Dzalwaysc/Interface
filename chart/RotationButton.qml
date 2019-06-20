/****************************************************************************
**使用方法:
        创建一个RotationButton对象
        定义好width和height
        给另一个需要旋转的对象附一个属性 rotation: lolly_rotation
****************************************************************************/

import QtQuick 2.0

Rectangle{
    id: lollyRect
    width: 50
    height:50
    color: "black"
    anchors.left: parent.left
    anchors.top: parent.top
    property alias lolly_rotation: lolly.rotation //冰棍旋转的角度

    Image {
        id: lolly
        anchors.fill: parent
        source: "image/lolly.png"

        function rotation_angle(newX, newY){
            var xlength = newX - lolly.width/2
            var ylength = - (newY - lolly.height/2) // 因为这里y指向N
            var angle = Math.atan2(xlength, ylength)
            angle = angle*57.3
            lolly.rotation = angle;
            // console.log(angle);
        }
    }

    MouseArea{
        anchors.fill: parent
        hoverEnabled: false
        onPressed: hoverEnabled = true
        onPositionChanged: {
            lolly.rotation_angle(mouseX, mouseY);
        }
        onReleased: hoverEnabled = false
        onDoubleClicked: lolly.rotation = 0
    }
}
