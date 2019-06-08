/*****************************************
** 用户属性：
        单行列表的宽度和高度
        delegata_width | tab_height
        对象位置
        listView.x | listView.y

** 调整该项对象的位置，需要调整listView中的x和y

** 情况：
   一开始，listView的状态传递，是通过给serialport写一个状态，代码如下
   ----------------------------------------------------------
    states: State {
                name: "active"
                PropertyChanges {target: ListView; state: "active"}
    }
   ----------------------------------------------------------
   但是很快发现了问题：状态传导不过去
情景描述：
    在就单独对serialportBtn操作的时候一切正常，
    单在我点开setBtn，然后在再点serialportBtn的时候，发现listView没显示出来
    <输出：serialport.state="active", 而listView.state="">
    因此，我将listView暴露给外部使用，在外部直接对listView的状态进行操作
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

    //字体
    property string fontfamily: "Monaco"

    // 内置属性 highligth的透明度
    property real highligth_opacity: 1
    Behavior on highligth_opacity{SpringAnimation { spring: 2; damping: 0.2 }}           //弹性动画

    // 暴露给外部使用的属性
    property alias listView: listView

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
            ListElement{name: "遥控串口";}
            ListElement{name: "艇体串口";}
            ListElement{name: "预留串口";}
            ListElement{name: "预留串口";}
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
                    font.family: fontfamily
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

    SerialPortHandleMessage{
        id: handleMessage
        Connections{
            target: mousearea1
            onClicked: {
                vehicleMessage.state = "";
                gpsMessage.state = "";
                emptyMessage2.state = "";
                if(handleMessage.state === "") handleMessage.state = "active";
                else if(handleMessage.state === "active") handleMessage.state = "";
                //console.log(handleMessage.x); //配合anchors.right使用，用来获取x的位置
            }
        }
    }

    SerialPortVehicleMessage{
        id: vehicleMessage
        Connections{
            target: mousearea2
            onClicked: {
                handleMessage.state = "";
                gpsMessage.state = "";
                emptyMessage2.state = "";
                if(vehicleMessage.state === "") vehicleMessage.state = "active";
                else if(vehicleMessage.state === "active") vehicleMessage.state = "";
            }
        }
    }

    SerialPortGPSMessage{
        id: gpsMessage
        Connections{
            target: mousearea3
            onClicked: {
                handleMessage.state = "";
                vehicleMessage.state = "";
                emptyMessage2.state = "";
                if(gpsMessage.state === "") gpsMessage.state = "active";
                else if(gpsMessage.state === "active") gpsMessage.state = "";
            }
        }
    }

    SerialPortMessage{
        id: emptyMessage2
        commName: " "; dataBits: " "; stopBits: " "; parity: " "
        imgname: "ID: "
        Connections{
            target: mousearea4
            onClicked: {
                handleMessage.state = "";
                vehicleMessage.state = "";
                emptyMessage1.state = "";
                if(emptyMessage2.state === "") emptyMessage2.state = "active";
                else if(emptyMessage2.state === "active") emptyMessage2.state = "";
            }
        }
    }
}
