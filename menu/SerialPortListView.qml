/*****************************************
** 用户属性：
        单行列表的宽度和高度
        delegata_width | tab_height
        对象位置
        listView.x | listView.y

** 调整该项对象的位置，需要调整listView中的x和y
*****************************************/
import QtQuick 2.0
import QtGraphicalEffects 1.0
import io.serialport 1.0
Item{
    id:serialport
    property real posX: 0
    property real posY: 0
    property real delegate_width: 80
    property real delegate_height: 16

    // 内置属性 highligth的透明度
    property real highligth_opacity: 1
    Behavior on highligth_opacity{SpringAnimation { spring: 2; damping: 0.2 }}           //弹性动画

    states: State {
                name: "active"
                PropertyChanges {target: listView; state: "active"}
    }

    // 点击SerialPortBtn时，关闭Message窗口
    signal close()
    onClose: {
        handleMessage.state = "";
        vehicleMessage.state = "";
    }

    Rectangle{
        id: listView
        x: posX; y: posY // 最终位置为x:650  y:45
        opacity: 0
        width: delegate_width*4; height: delegate_height
        radius: 2
        color: "ivory"
        border.color: "black"

        states:State {
                name: "active"
                PropertyChanges {target: listView; opacity: 1; y: posY+90}
                PropertyChanges {target: listView_shadow; opacity: 1}
        }

        ListModel{
            id: contactModel
            ListElement{name: "handle"}
            ListElement{name: "vehicle"}
            ListElement{name: "empty"}
            ListElement{name: "empty"}
        }

        Component{
            id: contactDelegate
            Item{
                id: item
                width: delegate_width; height: delegate_height
                Text {
                    id: contactInfo
                    anchors.centerIn: parent
                    textFormat: Text.StyledText
                    color: Qt.lighter("black")
                    text: name
                }
            }
        }

        Component{
            id: highlight
            Rectangle{
                id: high_rect
                width: delegate_width; height: delegate_height-20
                radius: 2.5
                color: "lightsteelblue"
                border.color: "black"
                opacity: highligth_opacity
                y:list.currentItem.y
                Behavior on y { SpringAnimation{ spring: 3; damping: 0.2} }
            }
        }

        ListView{
            id: list
            anchors.fill: parent
            model: contactModel
            delegate: contactDelegate
            highlight: highlight
            highlightFollowsCurrentItem: true
            orientation: ListView.Horizontal
        }

        MouseArea{
            id: mousearea1
            x:0; y:0
            width: delegate_width; height: delegate_height
            enabled: listView.opacity == 1
            hoverEnabled: true
            onEntered: {
                highligth_opacity = 1
                list.currentIndex = 0
            }
            onExited: {
                highligth_opacity = 0
            }
        }

        MouseArea{
            id: mousearea2
            x:delegate_width; y:0
            width: delegate_width; height: delegate_height
            enabled: listView.opacity == 1
            hoverEnabled: true
            onEntered: {
                highligth_opacity = 1
                list.currentIndex = 1
            }
            onExited: {
                highligth_opacity = 0
            }
        }

        MouseArea{
            id: mousearea3
            x:delegate_width*2; y:0
            width: delegate_width; height: delegate_height
            enabled: listView.opacity == 1
            hoverEnabled: true
            onEntered: {
                highligth_opacity = 1
                list.currentIndex = 2
            }
            onExited: {
                highligth_opacity = 0
            }
        }

        MouseArea{
            id: mousearea4
            x:delegate_width*3; y:0
            width: delegate_width; height: delegate_height
            enabled: listView.opacity == 1
            hoverEnabled: true
            onEntered: {
                highligth_opacity = 1
                list.currentIndex = 3
            }
            onExited: {
                highligth_opacity = 0
            }
        }

        Component.onCompleted: {
            highligth_opacity = 0
        }
    }

    DropShadow{
        id: listView_shadow
        anchors.fill: listView
        horizontalOffset: 3
        verticalOffset: 3
        radius: 8
        samples: 17
        color: "black"
        opacity: 0
        source: listView
    }

    SerialPortMessage{
        id: handleMessage
        commName: "COM16" /*myTest.portName*/; dataBits: "Data8"; stopBits: "oneStop"; parity: "NoParity"
        source: "image/handle.png"
        imgname: "ID: HANDLE"
        Connections{
            target: mousearea1
            onClicked: {
                vehicleMessage.state = "";
                if(handleMessage.state === "") handleMessage.state = "active";
                else if(handleMessage.state === "active") handleMessage.state = "";
                //console.log(handleMessage.x); //配合anchors.right使用，用来获取x的位置
            }
        }
    }

    SerialPortMessage{
        id: vehicleMessage
        commName: "COM18"; dataBits: "Data8"; stopBits: "oneStop"; parity: "NoParity"
        source: "image/vehicle.png"
        imgname: "ID: VEHICLE"
        Connections{
            target: mousearea2
            onClicked: {
                handleMessage.state = "";
                if(vehicleMessage.state === "") vehicleMessage.state = "active";
                else if(vehicleMessage.state === "active") vehicleMessage.state = "";
                console.log(handleMessage.x)
            }
        }
    }

}
