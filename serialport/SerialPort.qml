/*****************************************
** 用户属性：
   1.   单行列表的宽度和高度
        delegata_width | delegate_height
        对象位置
        listView.x | listView.y    用posX、posY暴露给外面，方便更改设置
        调整该项对象的位置，需要调整listView中的x和y
** 2.   设置4个串口按钮，分别为遥控，艇体，北斗，预留串口

** 内部属性：
        close()信号
        串口按钮关闭时，关闭所有选项卡

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
    单在我点开setBtn，然后在再点serialportBtn的时候，发现list没显示出来
    <输出：serialport.state="active", 而listView.state="">
    因此，我将listView暴露给外部使用，在外部直接对listView的状态进行操作
*****************************************/
import QtQuick 2.0
import QtGraphicalEffects 1.0
import io.serialport 1.0

Item{
    id:serialport

    // 暴露给外部使用的属性
    property alias listView: listView

    // 串口列表
    SerialPortList{
        id: listView
    }

    // 数传
    Item{
        id: radio

        // 数传串口
        Comm{
            id: radioComm
        }

        // 数传串口信息
        SerialPortMessageRadio{
            id: radioMessage
            commPort: "COM1"
            buadRate: "19200"
            commName: "数传电台"
            onSendMsgAlready: radioComm.send(radioMessage.sendMsg)
        }

        // 所有串口主按钮和串口信息 打开关闭 的连接
        Connections{
            target: listView
            onMessageOff: radioMessage.state = "";
        }

        // 串口信息选项按钮和串口信息 打开 的连接
        Connections{
            target: listView.comButton1.dialog1
            onClicked: {
                radioMessage.state = "active";
            }
        }

        // 串口C++信号和qml的连接
        Connections{
            target: radioComm
            onToQmlSerialportError: {
                if(error != "No error")
                    listView.comButton1.state = ""
            }
            onToQmlSerialportSendSuccess: {
                listView.comButton1.heartTimer.start();
            }
        }

        // 串口主按钮和串口C++的 开始关闭 的连接
        Connections{
            target: listView.comButton1.circleInter
            onLeftClicked: {
                console.log("数传Serialport comButton: " + listView.comButton1.state);
                if(listView.comButton1.state === "active"){
                    radioComm.run(radioMessage.commPort, radioMessage.buadRate, 10000);
                }
                else{
                    radioComm.stop();
                }
            }
        }

        // 串口定时发送按钮和C++的 定时发送 的连接
        Connections{
            target: listView.comButton1.dialog2
            onDialog2Clicked: { // 已经是只有在激活情况下才能发送dialog2Clicked信号
                if(listView.comButton1.dialog2.btnText === "关闭定时"){
                    radioComm.autoSendOpen(1000);
                }else{
                    radioComm.autoSendStop();
                }
            }
        }

        // 串口发送按钮和C++的 发送 的连接
        Connections{
            target: listView.comButton1.dialog3
            onDialog3Clicked: { // 已经是在只有激活情况下才能发送dialog3Clicked信号
                radioComm.send(radioMessage.sendMsg);
            }
        }
    }

    // 北斗
    Item{
        id: gps

        // 北斗串口
        Comm{
            id: gpsComm
        }

        // 北斗串口信息
        SerialPortMessage{
            id: gpsMessage

            commPort: "COM2"
            buadRate: "19200"
            commName: "北斗串口"
            activex: 60; posy: 200
        }

        // 串口主按钮和串口信息 打开 的连接
        Connections{
            target: listView
            onMessageOff: gpsMessage.state = "";
        }

        // 串口信息选项按钮和串口信息 打开 的连接
        Connections{
            target: listView.comButton2.dialog1
            onClicked: {
                gpsMessage.state = "active";
            }
        }

        // 串口C++信号和qml的连接
        Connections{
            target: gpsComm
            onToQmlSerialportError: {
                if(error != "No error")
                    listView.comButton2.state = ""
            }
            onToQmlSerialportSendSuccess: {
                listView.comButton2.heartTimer.start();
            }
        }

        // 串口主按钮和串口C++的 开始关闭 的连接
        Connections{
            target: listView.comButton2.circleInter
            onLeftClicked: {
                console.log("北斗Serialport comButton: " + listView.comButton2.state);
                if(listView.comButton2.state === "active")
                    gpsComm.run(gpsMessage.commPort, gpsMessage.buadRate, 10000);
                else
                    gpsComm.stop();
            }
        }

    }

    // IO
    Item{
        id: vehicle

        // IO串口
        Comm{
            id: vehicleComm
        }

        // IO串口信息
        SerialPortMessage{
            id: vehicleMessage

            commPort: "COM3"
            buadRate: "19200"
            commName: "艇体串口"
            activex: 60; posy: 200
        }

        // 串口主按钮和串口信息 打开 的连接
        Connections{
            target: listView
            onMessageOff: vehicleMessage.state = "";
        }

        // 串口信息选项按钮和串口信息 打开 的连接
        Connections{
            target: listView.comButton3.dialog1
            onClicked: {
                vehicleMessage.state = "active";
            }
        }

        // 串口C++信号和qml的连接
        Connections{
            target: vehicleComm
            onToQmlSerialportError: {
                if(error != "No error")
                    listView.comButton3.state = ""
            }
            onToQmlSerialportSendSuccess: {
                listView.comButton3.heartTimer.start();
            }
        }

        // 串口主按钮和串口C++的 开始关闭 的连接
        Connections{
            target: listView.comButton3.circleInter
            onLeftClicked: {
                console.log("艇体Serialport comButton: " + listView.comButton3.state);
                console.log(vehicleMessage.commPort + " " + vehicleMessage.buadRate)
                if(listView.comButton3.state === "active"){
                    vehicleComm.run(vehicleMessage.commPort, vehicleMessage.buadRate, 10000);
                }
                else
                    vehicleComm.stop();
            }
        }

    }

    // 遥控串口
    Item{
        id: handle

        // 遥控串口
        Comm{
            id: handleComm
        }

        // 遥控串口信息
        SerialPortMessage{
            id: handleMessage

            commPort: "COM4"
            buadRate: "19200"
            commName: "遥控串口"
            activex: 60; posy: 200
        }

        // 串口主按钮和串口信息 打开 的连接
        Connections{
            target: listView
            onMessageOff: handleMessage.state = "";
        }

        // 串口信息选项按钮和串口信息 打开 的连接
        Connections{
            target: listView.comButton4.dialog1
            onClicked: {
                handleMessage.state = "active";
            }
        }

        // 串口C++信号和qml的连接
        Connections{
            target: handleComm
            onToQmlSerialportError: {
                if(error != "No error")
                    listView.comButton4.state = ""
            }
            onToQmlSerialportSendSuccess: {
                listView.comButton4.heartTimer.start();
            }
        }

        // 串口主按钮和串口C++的 开始关闭 的连接
        Connections{
            target: listView.comButton4.circleInter
            onLeftClicked: {
                console.log("遥控Serialport comButton: " + listView.comButton2.state);
                if(listView.comButton4.state === "active"){
                    handleComm.run(handleMessage.commPort, handleMessage.buadRate, 10000);
                }
                else{
                    handleComm.stop();
                }
            }
        }

    }
}
