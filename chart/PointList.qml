/****************************************************************************
**
**此文件是GroundStation点开后产生的列表
**在MyChart中使用

**列表包括的四个按钮在Grid(menuContext)中
**add: 单击该按钮：1.使得列表多一行空数据
                 2.向外发射信号 listView_targetPointAppend()
  nullptr: 预留按钮，opacity=0，故看不到
  start: 单击该按钮：1.向外发射信号 start()
  clear: 单击该按钮：1.向外发射信号 clear()


**对象信号:
        targetPointAppend: chart MouseArea -> onClicked -> emit -> slove it here

**类内信号:
        textInputChanged              在列表中改变值的时候产生
        listView_targetPointAppend()  add按钮产生
        start()                       start按钮产生
        clear()                       clear按钮产生
****************************************************************************/

import QtQuick 2.2
import "script/chartscript.js" as Script
//地面站那块儿点开

Rectangle{
    id: pointList
    width: rectwidth*3+rectwidth/3+30; height: rectheight*8
    color: "ivory"
    border.color: "black"
    border.width: 2
    radius: 5
    opacity: 1

    // 用户属性
    property real rectwidth: 100                 //每个矩形的宽
    property real rectheight: 30                //每个矩形的高
    property color header_fontcolor: "black"    //表头字体颜色
    property real header_fontsize: 15           //表头字体大小


    // 内置属性
    property real location_x: 0 //用来设置动画的属性

    property color debugcolor: "black"  // Component的边框颜色
    property color fontcolor: "black"
    property alias model: pointModel // 外置的model接口，在Mychart用到

    states: State {
        name: "active"
        PropertyChanges {target: pointList; opacity: 1; x: -515}
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
    signal targetPointAppend(real valueX, real valueY)
    signal textInputChanged(int index, string roles)
    signal listView_targetPointAppend()
    signal start()
    signal clear()

    onTargetPointAppend: {
        pointModel.append({"orderNo": pointModel.count.toString(),
                                     "positionX": valueX.toString(), "positionY": valueY.toString()})
    }

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
                Text{text: "NO"; color: header_fontcolor;font.pixelSize: header_fontsize; anchors.centerIn: parent}
            }
            Rectangle{
                color: "#ADFF99"
                border.color: debugcolor; radius: 2
                width: rectwidth; height: rectheight
                Text{text: "posX"; color: header_fontcolor; font.pixelSize: header_fontsize;anchors.centerIn: parent}
            }
            Rectangle{
                color: "#ADFF99"
                border.color: debugcolor; radius: 2
                width: rectwidth; height: rectheight
                Text{text: "posY"; color: header_fontcolor; font.pixelSize: header_fontsize;anchors.centerIn: parent}
            }
        }
    }

    ListView{
        id: mygroudstationListView
        anchors.top: parent.top; anchors.topMargin: 40
        anchors.left: parent.left; anchors.leftMargin: 30
        clip: true
        width: 348; height: 40*3
        cacheBuffer: 40*2
        model: pointModel
        delegate: pointDelegate
        header: pointHeader
        add: Transition {
            NumberAnimation { property: "opacity"; from: 0; to: 1.0; duration: 400 }
        }
        displaced: Transition {
            id: dispTrans
                NumberAnimation{properties: "x,y"; duration: 400; easing.type: Easing.OutBounce}
        }
    }

    // PointList的操作按钮
    Grid {
        id: menuContext
        x: 10
        y: 5
        spacing: 10
        columns: 3
        opacity: 1

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
                    name: "hovering"
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
                    pointList.listView_targetPointAppend()
                }
                onEntered: {
                    if(addButton.state === "") addButton.state = "hovering";
                }
                onExited: {
                    if(addButton.state === "active") return;
                    else addButton.state = "";
                }
            }
            Text {
                id: introduction_add
                opacity: 0
                y: -parent.width
                Behavior on y { SpringAnimation{spring: 2; damping: 0.2}}
                anchors.horizontalCenter: addButton.horizontalCenter
                text: "add"; color: "black"
                font.bold: true
            }
        }

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
                    PropertyChanges {target: introduction_start; opacity: 1.0; color: "#ff1493"; y: -25}
                },
                State {
                    name: "hovering"
                    PropertyChanges {target: introduction_start; opacity: 1.0}
                }
            ]

            Behavior on opacity { NumberAnimation{duration: 500; easing.type: Easing.Linear}}

            MouseArea{
                anchors.fill: parent
                enabled: parent.opacity == 1
                hoverEnabled: parent.opacity == 1
                onClicked: {
                    startButton.state = "active"
                    start()
                }
                onEntered: {
                    if(startButton.state === "") startButton.state = "hovering";
                }
                onExited: {
                    if(startButton.state === "active") return;
                    else startButton.state = "";
                }
            }
            Text {
                id: introduction_start
                opacity: 0
                y: -parent.width
                Behavior on y { SpringAnimation{spring: 2; damping: 0.2}}
                anchors.horizontalCenter: startButton.horizontalCenter
                text: "start"; color: "black"
                font.bold: true
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
                    name: "hovering"
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
                    if(clearallButton.state === "") clearallButton.state = "hovering";
                }
                onExited: {
                    if(clearallButton.state === "active") return;
                    else clearallButton.state = "";
                }
            }
            Text {
                id: introduction_clear
                opacity: 0
                y: -parent.width
                Behavior on y { SpringAnimation{spring: 2; damping: 0.2}}
                anchors.horizontalCenter: clearallButton.horizontalCenter
                text: "clearall"; color: "black"
                font.bold: true
            }
        }
    }
}
