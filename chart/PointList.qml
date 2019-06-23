/****************************************************************************
**
**此文件是GroundStation点开后产生的列表
**在MyChart中使用

**列表包括三个按钮：
**添加: 单击该按钮：1.使得列表多一行空数据，
                 2.向外发射信号 targetPointAppend()
  开始: 单击该按钮：1.向外发射信号 start()，开始连线
  清理: 单击该按钮：1.向外发射信号 clear()，清理数据

**类内信号:
        textInputChanged              在列表中改变值的时候产生
        targetPointAppend()           add按钮产生
        start()                       start按钮产生
        clear()                       clear按钮产生
****************************************************************************/

import QtQuick 2.2
import "script/chartscript.js" as Script
import "../button"
//地面站那块儿点开

Rectangle{
    id: pointList
    width: 380; height: 200
    color: "ivory"
    border.color: "black"
    border.width: 2
    radius: 5
    opacity: 0

    property string fontfamily: "Monaco"

    // 用户属性
    property real rectwidth: 100                 //每个矩形的宽
    property real rectheight: 30                //每个矩形的高
    property color header_fontcolor: "black"    //表头字体颜色
    property real fontpixelSize: 15             //字体大小


    property color debugcolor: "black"  // Component的边框颜色
    property color fontcolor: "black"
    property alias pointModel: pointModel // 暴露给外部使用的接口

    states: State {
        name: "active"
        PropertyChanges {target: pointList; opacity: 1; x: -5}
    }
    transitions: [
        Transition {
            from: ""; to: "active"; reversible: false
            ParallelAnimation{
                NumberAnimation{ properties: "opacity"; duration: 500}
                SpringAnimation{ properties: "x"; spring: 2; damping: 0.2}
            }
        },
        Transition {
            from: "active"; to: ""; reversible: false
            ParallelAnimation{
                NumberAnimation{ properties: "opacity"; duration: 150}
                SpringAnimation{ properties: "x"; spring: 2; damping: 0.2}
            }
        }
    ]

    signal textInputChanged(int index, string roles)
    signal targetPointAppend()
    signal start()
    signal clear()


    ListModel{
        id: pointModel
        // 1. orderNo 2.positionX  3.positionY
    }

    Component{
        id: pointDelegate
        Grid {
            columns: 3
            rows: 1
            Rectangle{
                color: "#FEF3B8"
                border.color: debugcolor
                width: rectwidth; height: rectheight
                TextInput{
                    color: fontcolor
                    selectByMouse: true
                    selectedTextColor: "red"
                    text: orderNo; anchors.centerIn: parent
                    font.family: fontfamily
                    font.pixelSize: fontpixelSize
                    onAccepted: {
                        orderNo = text
                        textInputChanged(index,"orderNo")
                    }
                }
            }
            Rectangle{
                color: "#FEF3B8"
                border.color: debugcolor
                width: rectwidth; height: rectheight
                TextInput{
                    color: fontcolor
                    selectByMouse: true
                    selectedTextColor: "red"
                    text: positionX; anchors.centerIn: parent
                    font.family: fontfamily
                    font.pixelSize: fontpixelSize
                    onAccepted: {
                        positionX = text
                        textInputChanged(index,"positionX")
                        console.log(index)
                    }
                }
            }
            Rectangle{
                color: "#FEF3B8"
                border.color: debugcolor
                width: rectwidth; height: rectheight
                TextInput{
                    color: fontcolor
                    selectByMouse: true
                    selectedTextColor: "red"
                    text: positionY; anchors.centerIn: parent
                    font.family: fontfamily
                    font.pixelSize: fontpixelSize
                    onAccepted: {
                        positionY = text
                        textInputChanged(index,"positionY")
                        console.log(index)
                    }
                }
            }
        }
    }

    Component{
        id: pointHeader
        Grid {
            columns: 3
            rows: 1
            Rectangle{
                color: "#ADFF99"
                border.color: debugcolor; radius: 2
                width: rectwidth; height: rectheight
                Text{text: "NO"; color: header_fontcolor;font.pixelSize: fontpixelSize; anchors.centerIn: parent;font.family: fontfamily}
            }
            Rectangle{
                color: "#ADFF99"
                border.color: debugcolor; radius: 2
                width: rectwidth; height: rectheight
                Text{text: "posX"; color: header_fontcolor; font.pixelSize: fontpixelSize;anchors.centerIn: parent;font.family: fontfamily}
            }
            Rectangle{
                color: "#ADFF99"
                border.color: debugcolor; radius: 2
                width: rectwidth; height: rectheight
                Text{text: "posY"; color: header_fontcolor; font.pixelSize: fontpixelSize;anchors.centerIn: parent;font.family: fontfamily}
            }
        }
    }

    ListView{
        id: mygroudstationListView
        anchors.top: parent.top; anchors.topMargin: 45
        anchors.left: parent.left; anchors.leftMargin: 40
        clip: true
        width: 348; height: 40*3
        model: pointModel
        delegate: pointDelegate
        header: pointHeader
        highlightFollowsCurrentItem: true
        onCountChanged: {
            mygroudstationListView.currentIndex = mygroudstationListView.count - 1;
        }
    }

    // PointList的操作按钮
    Grid {
        id: menuContext
        x: 15
        y: 10
        spacing: 15
        columns: 3
        opacity: 1

        Rectangle{
            id: startButton
            width: 20; height: 20
            opacity: menuContext.opacity
            radius: 2
            color: "ivory"

            Image {
                id: image2
                anchors.fill: parent
                source: startButton.state === "active" ? "image/start_pink.png" : "image/start.png"
            }

            states: [
                State {
                    name: "active"
                    PropertyChanges {target: introduction_start; opacity: 1.0; color: "#ff1493"; y: -40}
                },
                State {
                    name: "hover"
                    PropertyChanges {target: introduction_start; opacity: 1.0}
                }
            ]

            Behavior on opacity { NumberAnimation{duration: 500; easing.type: Easing.Linear}}

            MouseArea{
                anchors.fill: parent
                enabled: parent.opacity == 1
                hoverEnabled: parent.opacity == 1
                onClicked: {
                    if(startButton.state === "hover") startButton.state = "active"
                    else startButton.state = "hover"
                    start() // 发送给外部start信号
                }
                onEntered: {
                    if(startButton.state === "") startButton.state = "hover";
                }
                onExited: {
                    if(startButton.state === "active") return;
                    else startButton.state = "";
                }
            }

            BoxOne{
                id:introduction_start
                mW: 40; mH: rectheight
                opacity: 0
                y: -40
                anchors.horizontalCenter: startButton.horizontalCenter
                context: "开始"
            }
        }

        Rectangle{
            id: addButton
            width: 20; height: 20
            opacity: menuContext.opacity
            radius: 2
            color: "ivory"

            Image {
                id: image1
                anchors.fill: parent
                source: "image/add.png"
            }

            states: [
                State {
                    name: "active"
                    PropertyChanges {target: introduction_add; opacity: 1.0; color: "#ff1493"; y: -25}
                },
                State {
                    name: "hover"
                    PropertyChanges {target: introduction_add; opacity: 1.0}
                }
            ]

            Behavior on opacity { NumberAnimation{duration: 500; easing.type: Easing.Linear}}

            MouseArea{
                anchors.fill: parent
                enabled:  parent.opacity == 1
                hoverEnabled: parent.opacity == 1

                onClicked: {
                    pointModel.append({"orderNo": pointModel.count.toString(),
                                       "positionX": "0.0", "positionY": "0.0"})
                    pointList.targetPointAppend()
                }
                onEntered: {
                    if(addButton.state === "") addButton.state = "hover";
                }
                onExited: {
                    if(addButton.state === "active") return;
                    else addButton.state = "";
                }
            }

            BoxOne{
                id:introduction_add
                mW: 40; mH: rectheight
                opacity: 0
                y: -40
                anchors.horizontalCenter: addButton.horizontalCenter
                context: "添加"
            }
        }

        Rectangle{
            id: clearallButton
            width: 20; height: 20
            opacity: menuContext.opacity
            radius: 2
            color: "ivory"

            Image {
                id: image3
                anchors.fill: parent
                source: "image/clear.png"
            }

            states: [
                State {
                    name: "active"
                    PropertyChanges {target: introduction_clear; opacity: 1.0; color: "#ff1493"; y: -25}
                },
                State {
                    name: "hover"
                    PropertyChanges {target: introduction_clear; opacity: 1.0}
                }
            ]

            Behavior on opacity { NumberAnimation{duration: 500; easing.type: Easing.Linear}}

            MouseArea{
                anchors.fill: parent
                enabled: parent.opacity == 1
                hoverEnabled: parent.opacity == 1

                onClicked: clear()
                onEntered: {
                    if(clearallButton.state === "") clearallButton.state = "hover";
                }
                onExited: {
                    if(clearallButton.state === "active") return;
                    else clearallButton.state = "";
                }
            }
            BoxOne{
                id:introduction_clear
                mW: 40; mH: rectheight
                opacity: 0
                y: -40
                anchors.horizontalCenter: clearallButton.horizontalCenter
                context: "清理"
            }
        }
    }
}
