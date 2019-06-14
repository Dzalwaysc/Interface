/****************************************************************************
**
chart的控制按钮文档，主结构为Rectangle
**用户接口:
**property:
           rectwidth: 单个按钮的宽度，默认为50； rectheight: 单个按钮的高度，默认为50；
           rectmargin：两个按钮之间的间隙，默认为10

**zoom:点击zoom图标，mychartcile将发送一个zoom被点击信号，
**mychart接收此信号，并将光标形状更改为十字，以告诉用户
**已启用缩放。放大的过程介于按和松开之间。
**属性zoomIconstate用于告诉mychart zoomin已就绪。

**Drag：单击Drag图标，operationBar将发送一个Drag图标被点击信号
**mychart收到这个符号，并将光标形状改为手，以告诉用户
**启用拖动。拖拽的过程介于按和松开之间。
**计时器是用于提高流畅性
**属性dragIconstate用于告诉mychart拖动准备就绪。

**rest：点击Reset按钮，operationBar将发送Reset按钮被点击信号，
**mychart接收此信号，并向self发出resetchartview信号，然后重置chart窗口。

** 细节解释：
1.在每个Rect的MouseArea中，enabled的属性是只有当整个Bar的opacity为1的时候才可以使用
2.在每个Rect的MouseArea的onEnter里，发现都存在以下句子
            operationBar.opacity = 1
  // 首先鼠标进入chart区域，这个时候Bar显示出来，这里的MouseArea可以使用
  // 如果不加这一行，则鼠标在进入到Bar区域的时候，Bar的opacity变为0（离开了chart的区域）
****************************************************************************/

import QtQuick 2.0
import "script/chartscript.js" as Script

Rectangle{
    id: operationBar
    width: rectwidth*4 + 10*3
    height: rectheight
    color: "white"
    border.color: "white"

    property string fontfamily: "Monaco"

    // 用户接口属性
    property real rectwidth: 50
    property real rectheight: 50
    property real rectmargin: 10

    // 内置属性
    property alias zoomIconState: zoomRect.state //是否开始zoom模式
    property alias dragIconState: dragRect.state //是否开始drag模式
    property alias groundstationIconState: groundstationRect.state //是否开始station模式

    // 内置信号
    signal zoomIconClicked
    signal dragIconClicked
    signal resetIconClicked
    signal groundstationIconClicked

    Item {
        anchors.fill: parent
        Rectangle{
            id: resetRect
            width: rectwidth
            height: rectheight
            color: "white"
            anchors.top: parent.top
            anchors.left: parent.left
            opacity: 0.65
            Image {
                id: reset
                anchors.centerIn: parent
                width: parent.width; height: parent.width
                source: "image/reset.png"
            }

            states: [
                State {
                    name: "hover"
                    PropertyChanges {target: resetRect; opacity: 1.0}
                    PropertyChanges {target: introduction_reset; opacity: 1.0}
                },
                State {
                    name: ""
                    PropertyChanges {target: groundstationRect; opacity: 0.65}
                    PropertyChanges {target: introduction_groundstation; opacity: 0.0}
                }
            ]

            Behavior on opacity { NumberAnimation{duration: 500; easing.type: Easing.OutCubic}}

            RotationAnimation{
                id: rotaionAnimation
                target: reset
                from: 0; to: 360; duration: 500; running: false
            }

            MouseArea{
                anchors.fill: parent
                enabled: operationBar.opacity == 0 ? false : true
                hoverEnabled: true
                onClicked: {
                    operationBar.resetIconClicked();
                    rotaionAnimation.restart();
                }
                onEntered: {
                    if(resetRect.state === "") resetRect.state = "hover";
                    operationBar.opacity = 1
                }
                onExited: {
                    resetRect.state = "";
                }
            }

            Rectangle{
                id:introduction_reset
                border.color: "black"; radius: 2
                width: 40; height: rectheight
                opacity: 0
                y: -40
                Behavior on y { SpringAnimation{spring: 2; damping: 0.2}}
                anchors.horizontalCenter: resetRect.horizontalCenter
                Text{
                    text: "刷新"
                    color: "black"
                    anchors.centerIn: parent
                    font.family: fontfamily
                    font.bold: true
                }
            }
        }

        Rectangle{
            id: zoomRect
            width: rectwidth
            height: rectheight
            color: "white"
            anchors.top: parent.top
            anchors.left: resetRect.right; anchors.leftMargin: 15
            opacity: 0.65
            Image {
                id: zoom
                anchors.fill: parent
                source: zoomRect.state === "active" ? "image/zoom_pink.png" : "image/zoom.png"
            }

            states: [          //此属性保存此项的可能状态列表。若要更改此项的状态，请将State属性设置为这些状态之一，或将State属性设置为空字符串以将该项还原为默认状态。
                State {
                    name: "active"
                    PropertyChanges {target: zoomRect; opacity: 1.0}
                    PropertyChanges {target: introduction_zoom; opacity: 1.0; color: "#ff1493"; y: -40}
                },
                State {
                    name: "hover"
                    PropertyChanges {target: zoomRect; opacity: 1.0}
                    PropertyChanges {target: introduction_zoom; opacity: 1.0}
                },
                State {
                    name: ""
                    PropertyChanges {target: zoomRect; opacity: 0.65}
                    PropertyChanges {target: introduction_zoom; opacity: 0.0}
                }
            ]

            Behavior on opacity { NumberAnimation{duration: 500; easing.type: Easing.OutCubic}}

            MouseArea{
                anchors.fill: parent
                enabled: operationBar.opacity == 0 ? false : true
                hoverEnabled: true
                onClicked: {
                    zoomRect.state = Script.stateTransition(zoomRect.state);
                    operationBar.zoomIconClicked();
                }
                onEntered: {
                    if(zoomRect.state === "") zoomRect.state = "hover";
                    operationBar.opacity = 1
                }
                onExited: {
                    if(zoomRect.state === "active") return;
                    else zoomRect.state = "";
                }
            }

            Rectangle{
                id:introduction_zoom
                border.color: "black"; radius: 2
                width: 40; height: rectheight
                opacity: 0
                y: -40
                Behavior on y { SpringAnimation{spring: 2; damping: 0.2}}
                anchors.horizontalCenter: zoomRect.horizontalCenter
                Text{
                    text: "放大"
                    color: "black"
                    anchors.centerIn: parent
                    font.family: fontfamily
                    font.bold: true
                }
            }
        }

        Rectangle{
            id: dragRect
            width: rectwidth
            height: rectheight
            color: "white"
            anchors.top: parent.top
            anchors.left: zoomRect.right; anchors.leftMargin: 15
            opacity: 0.65
            Image {
                id: drag
                anchors.fill: parent
                source: dragRect.state === "active" ? "image/drag_pink.png" : "image/drag.png"
            }

            states: [
                State {
                    name: "active"
                    PropertyChanges {target: dragRect; opacity: 1.0}
                    PropertyChanges {target: introduction_drag; opacity: 1.0; color: "#ff1493"; y: -40}
                },
                State {
                    name: "hover"
                    PropertyChanges {target: dragRect; opacity: 1.0}
                    PropertyChanges {target: introduction_drag; opacity: 1.0}
                },
                State {
                    name: ""
                    PropertyChanges {target: dragRect; opacity: 0.65}
                    PropertyChanges {target: introduction_drag; opacity: 0.0}
                }
            ]

            Behavior on opacity { NumberAnimation{duration: 500; easing.type: Easing.OutCubic}}

            MouseArea{
                anchors.fill: parent
                enabled: operationBar.opacity == 0 ? false : true
                hoverEnabled: true
                onClicked: {
                    dragRect.state =  Script.stateTransition(dragRect.state);
                    operationBar.dragIconClicked();
                }
                onEntered: {
                    if(dragRect.state === "") dragRect.state = "hover";
                    operationBar.opacity = 1
                }
                onExited: {
                    if(dragRect.state === "active") return;
                    else dragRect.state = "";
                }
            }

            Rectangle{
                id: introduction_drag
                border.color: "black"; radius: 2
                width: 40; height: rectheight
                opacity: 0
                y: -40
                Behavior on y { SpringAnimation{spring: 2; damping: 0.2}}
                anchors.horizontalCenter: dragRect.horizontalCenter
                Text{
                    text: "拖拽"
                    color: "black"
                    anchors.centerIn: parent
                    font.family: fontfamily
                    font.bold: true
                }
            }
        }

        Rectangle{
            id: groundstationRect
            width: rectwidth
            height: rectheight
            color: "white"
            anchors.top: parent.top
            anchors.left: dragRect.right; anchors.leftMargin: 15
            opacity: 0.65
            Image {
                id: groundstation
                anchors.centerIn: parent
                width: parent.width; height: parent.width
                source: groundstationRect.state === "active" ?  "image/groundstation_pink.png" : "image/groundstation.png"
            }

            states: [
                State {
                    name: "active"
                    PropertyChanges {target: groundstationRect; opacity: 1.0}
                    PropertyChanges {target: introduction_groundstation; opacity: 1.0; color: "#ff1493"; y: -40}
                },
                State {
                    name: "hover"
                    PropertyChanges {target: groundstationRect; opacity: 1.0}
                    PropertyChanges {target: introduction_groundstation; opacity: 1.0}
                },
                State {
                    name: ""
                    PropertyChanges {target: groundstationRect; opacity: 0.65}
                    PropertyChanges {target: introduction_groundstation; opacity: 0.0}
                }
            ]

            Behavior on opacity { NumberAnimation{duration: 500; easing.type: Easing.OutCubic}}

            MouseArea{
                anchors.fill: parent
                enabled: operationBar.opacity == 0 ? false : true
                hoverEnabled: true
                onClicked: {
                    groundstationRect.state = Script.stateTransition(groundstationRect.state);
                    operationBar.groundstationIconClicked();
                }
                onEntered: {
                    if(groundstationRect.state === "") groundstationRect.state = "hover";
                    operationBar.opacity = 1
                }
                onExited: {
                    if(groundstationRect.state === "active") return;
                    else groundstationRect.state = "";
                }
            }

            Rectangle{
                id: introduction_groundstation
                border.color: "black"; radius: 2
                width: 40; height: rectheight
                opacity: 0
                y: -40
                Behavior on y { SpringAnimation{spring: 2; damping: 0.2}}
                anchors.horizontalCenter: groundstationRect.horizontalCenter
                Text{
                    text: "地面站"
                    color: "black"
                    anchors.centerIn: parent
                    font.family: fontfamily
                    font.bold: true
                }
            }
        }
    }
}
