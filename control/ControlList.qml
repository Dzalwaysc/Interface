import QtQuick 2.0
import QtGraphicalEffects 1.0

Rectangle{
    id: controlList
    x: 240; y: -45
    opacity: 1
    width: delegate_width; height: delegate_height
    radius: 2
    color: "transparent"
    border.color: "white"

    // 字体
    property string fontfamily: "Monaco"
    property color fontcolor: "white"
    property real fontpixelSize: 13

    // 大小
    property real delegate_width: 60
    property real delegate_height: 20

    // 高光
    property real highligth_opacity: 0
    Behavior on highligth_opacity{SpringAnimation { spring: 2; damping: 0.2 }}

    // 暴露给外部使用的鼠标感应
    property alias mousearea1: mousearea1

    states: [
        State {
            name: "active"
            PropertyChanges {target: controlList; opacity: 1; y: 195}
        },
        State {
            name: ""
            PropertyChanges {target: controlList; opacity: 0; y: -45}
        }
    ]

    ListView{
        id: list
        anchors.fill: parent
        model: contactModel
        delegate: contactDelegate
        highlight: highlight
        highlightFollowsCurrentItem: true
        orientation: ListView.Horizontal
    }

    // 模型
    ListModel{
        id: contactModel
        ListElement{name: "仿真测试"}
    }

    // 委托项
    Component{
        id: contactDelegate
        Item{
            id: item
            width: delegate_width; height: delegate_height
            Text {
                id: contactInfo
                anchors.centerIn: parent
                font.family: fontfamily
                font.pixelSize: fontpixelSize
                color: fontcolor
                text: name
            }
        }
    }

    // 高光
    Component{
        id: highlight
        Rectangle{
            id: high_rect
            width: delegate_width; height: delegate_height-20
            radius: 2.5
            color: "lightsteelblue"
            border.color: "black"
            opacity: highligth_opacity
        }
    }

    // 鼠标感应
    MouseArea{
        id: mousearea1
        x: 0; y: 0
        width: delegate_width; height: delegate_height
        enabled: controlList.opacity == 1
        hoverEnabled: controlList.opacity == 1
        onEntered: {
            highligth_opacity = 0.5
            list.currentIndex = 0
        }
        onExited: {
            highligth_opacity = 0
        }
    }

    // 阴影
    Glow {
        anchors.fill: controlList
        radius: 3             //半径决定辉光的柔和度，半径越大辉光的边缘越模糊  样本值=1+半径*2
        samples: 13           //每个像素采集的样本值，值越大，质量越好，渲染越慢
        color: "#ddd"
        source: Rectangle{
            width: delegate_width; height: delegate_height
            radius: 2
            color: "transparent"
            border.color: "white"
        }
        spread: 0.5           //在光源边缘附近增强辉光颜色的大部分
        opacity: 0.8
    }
}
