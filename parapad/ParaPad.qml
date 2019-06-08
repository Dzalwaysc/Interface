/************
  **左上角数据参数表
  **黑色背景为主窗口界面高宽的0.2倍
  **上、左为对其标准
  **pizza图片以黑色背景上、左为标准，宽0.08倍，高0.11倍
  **"Actual Parameter"字体为父窗口宽的1/21
  **divider为一条分隔黄线
  **“x_y_yaw_parameter”  3*2网格分布 横向间隔0.1倍宽，纵向间隔0.015高，字体1/16宽
  **“u_v_r_parameter” 同上，两个网格间隔0.1倍宽
  **“more”按钮，高=0.08父高，宽=0.15父宽，字体=1/3父宽
  **“more菜单” 宽=主宽*0.09; 高=主高*0.03；字体1/3父宽
  **接收鼠标消息切换start/close
  *********/

import QtQuick 2.9
import QtQuick.Controls 1.4

Rectangle{
    id:actualParameter
    color: "ivory"
    border.color: "black"
    border.width: 2
    radius: 4
    width: 380; height: 200

    property real fontsize: 16
    property color fontcolor: "black"
    property string fontfamily: "Monaco"

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
        Label{
            text:"北向位置X: " + "10.0" + "m"
            clip: true
            font.pixelSize: fontsize
            font.family: fontfamily
            color: fontcolor
        }

        Label{
            text:"纵荡速度u: " + "4.5" + "m/s"
            clip: true
            font.pixelSize: fontsize
            font.family: fontfamily
            color: fontcolor
        }

        Label{
            text:"南向位置Y: " + "5.0" + "m"
            clip: true
            font.pixelSize: fontsize
            font.family: fontfamily
            color: fontcolor
        }

        Label{
            text:"横荡速度v: " + "0.2" + "m/s"
            clip: true
            font.pixelSize: fontsize
            font.family: fontfamily
            color: fontcolor
        }

        Label{
            text:"艏向角度YAW: " + "10.0" + "°"
            clip: true
            font.pixelSize: fontsize
            font.family: fontfamily
            color: fontcolor
        }

        Label{
            text:"艏摇速度r: " + "0.1" + "°/s"
            clip: true
            font.pixelSize: fontsize
            font.family: fontfamily
            color: fontcolor
        }
    }
}




