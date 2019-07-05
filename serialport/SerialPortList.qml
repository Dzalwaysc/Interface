import QtQuick 2.0

Item {
    property double button1_x: 30
    property double button1_y: 230

    property alias comButton1: comButton1
    property alias comButton2: comButton2
    property alias comButton3: comButton3
    property alias comButton4: comButton4

    // 无论如何只要点击了其中的一个按钮，则信息框关闭
    signal messageOff

    SerialPortButton{
        id: comButton1
        x: button1_x; y:button1_y
        circleInterSource: "image/circleInter1"
        circleOuterSource: "image/circleOuter"
        // 串口按钮和其他串口按钮的连接，如果其他串口的对话框弹出了，则关闭本串口按钮的显示
        Connections{
            target: comButton2;
            onDialogOn: {
                comButton1.circleInter.opacity = 0;
                comButton1.circleOuter.opacity = 0;
            }
            onDialogOff: {
                if(comButton1.state === "active"){
                    comButton1.circleInter.opacity = 1;
                    comButton1.circleOuter.opacity = 1;
                }else{
                    comButton1.circleInter.opacity = 0.5;
                    comButton1.circleOuter.opacity = 0;
                }
            }
        }
        Connections{
            target: comButton3;
            onDialogOn: {
                comButton1.circleInter.opacity = 0;
                comButton1.circleOuter.opacity = 0;
            }
            onDialogOff: {
                if(comButton1.state === "active"){
                    comButton1.circleInter.opacity = 1;
                    comButton1.circleOuter.opacity = 1;
                }else{
                    comButton1.circleInter.opacity = 0.5;
                    comButton1.circleOuter.opacity = 0;
                }
            }
        }
        Connections{
            target: comButton4;
            onDialogOn: {
                comButton1.circleInter.opacity = 0;
                comButton1.circleOuter.opacity = 0;
            }
            onDialogOff: {
                if(comButton1.state === "active"){
                    comButton1.circleInter.opacity = 1;
                    comButton1.circleOuter.opacity = 1;
                }else{
                    comButton1.circleInter.opacity = 0.5;
                    comButton1.circleOuter.opacity = 0;
                }
            }
        }
    }

    SerialPortButton{
        id: comButton2
        anchors.left: comButton1.left
        anchors.top: comButton1.top; anchors.topMargin: 40
        circleInterSource: "image/circleInter2"
        circleOuterSource: "image/circleOuter"
        // 串口按钮和其他串口按钮的连接，如果其他串口的对话框弹出了，则关闭本串口按钮的显示
        Connections{
            target: comButton1;
            onDialogOn: {
                comButton2.circleInter.opacity = 0;
                comButton2.circleOuter.opacity = 0;
            }
            onDialogOff: {
                if(comButton2.state === "active"){
                    comButton2.circleInter.opacity = 1;
                    comButton2.circleOuter.opacity = 1;
                }else{
                    comButton2.circleInter.opacity = 0.5;
                    comButton2.circleOuter.opacity = 0;
                }
            }
        }
        Connections{
            target: comButton3;
            onDialogOn: {
                comButton2.circleInter.opacity = 0;
                comButton2.circleOuter.opacity = 0;
            }
            onDialogOff: {
                if(comButton2.state === "active"){
                    comButton2.circleInter.opacity = 1;
                    comButton2.circleOuter.opacity = 1;
                }else{
                    comButton2.circleInter.opacity = 0.5;
                    comButton2.circleOuter.opacity = 0;
                }
            }
        }
        Connections{
            target: comButton4;
            onDialogOn: {
                comButton2.circleInter.opacity = 0;
                comButton2.circleOuter.opacity = 0;
            }
            onDialogOff: {
                if(comButton2.state === "active"){
                    comButton2.circleInter.opacity = 1;
                    comButton2.circleOuter.opacity = 1;
                }else{
                    comButton2.circleInter.opacity = 0.5;
                    comButton2.circleOuter.opacity = 0;
                }
            }
        }
    }

    SerialPortButton{
        id: comButton3
        anchors.left: comButton2.left
        anchors.top: comButton2.bottom; anchors.topMargin: 40
        circleInterSource: "image/circleInter3"
        circleOuterSource: "image/circleOuter2"
        // 串口按钮和其他串口按钮的连接，如果其他串口的对话框弹出了，则关闭本串口按钮的显示
        Connections{
            target: comButton1;
            onDialogOn: {
                comButton3.circleInter.opacity = 0;
                comButton3.circleOuter.opacity = 0;
            }
            onDialogOff: {
                if(comButton3.state === "active"){
                    comButton3.circleInter.opacity = 1;
                    comButton3.circleOuter.opacity = 1;
                }else{
                    comButton3.circleInter.opacity = 0.5;
                    comButton3.circleOuter.opacity = 0;
                }
            }
        }
        Connections{
            target: comButton2;
            onDialogOn: {
                comButton3.circleInter.opacity = 0;
                comButton3.circleOuter.opacity = 0;
            }
            onDialogOff: {
                if(comButton3.state === "active"){
                    comButton3.circleInter.opacity = 1;
                    comButton3.circleOuter.opacity = 1;
                }else{
                    comButton3.circleInter.opacity = 0.5;
                    comButton3.circleOuter.opacity = 0;
                }
            }
        }
        Connections{
            target: comButton4;
            onDialogOn: {
                comButton3.circleInter.opacity = 0;
                comButton3.circleOuter.opacity = 0;
            }
            onDialogOff: {
                if(comButton3.state === "active"){
                    comButton3.circleInter.opacity = 1;
                    comButton3.circleOuter.opacity = 1;
                }else{
                    comButton3.circleInter.opacity = 0.5;
                    comButton3.circleOuter.opacity = 0;
                }
            }
        }
    }

    SerialPortButton{
        id: comButton4
        anchors.left: comButton3.left
        anchors.top: comButton3.bottom; anchors.topMargin: 40
        circleInterSource: "image/circleInter4"
        circleOuterSource: "image/circleOuter2"
        // 串口按钮和其他串口按钮的连接，如果其他串口的对话框弹出了，则关闭本串口按钮的显示
        Connections{
            target: comButton1;
            onDialogOn: {
                comButton4.circleInter.opacity = 0;
                comButton4.circleOuter.opacity = 0;
            }
            onDialogOff: {
                if(comButton4.state === "active"){
                    comButton4.circleInter.opacity = 1;
                    comButton4.circleOuter.opacity = 1;
                }else{
                    comButton4.circleInter.opacity = 0.5;
                    comButton4.circleOuter.opacity = 0;
                }
            }
        }
        Connections{
            target: comButton2;
            onDialogOn: {
                comButton4.circleInter.opacity = 0;
                comButton4.circleOuter.opacity = 0;
            }
            onDialogOff: {
                if(comButton4.state === "active"){
                    comButton4.circleInter.opacity = 1;
                    comButton4.circleOuter.opacity = 1;
                }else{
                    comButton4.circleInter.opacity = 0.5;
                    comButton4.circleOuter.opacity = 0;
                }
            }
        }
        Connections{
            target: comButton3;
            onDialogOn: {
                comButton4.circleInter.opacity = 0;
                comButton4.circleOuter.opacity = 0;
            }
            onDialogOff: {
                if(comButton4.state === "active"){
                    comButton4.circleInter.opacity = 1;
                    comButton4.circleOuter.opacity = 1;
                }else{
                    comButton4.circleInter.opacity = 0.5;
                    comButton4.circleOuter.opacity = 0;
                }
            }
        }
    }

    // 串口按钮与串口信息的连接，无论如何只要点击了其中一个按钮，则信息框关闭
    Connections{
        target: comButton1.circleInter
        onLeftClicked: messageOff() // 发送至SerialPort
        onRightClicked: messageOff() // 发送至SerialPort
    }

    Connections{
        target: comButton2.circleInter
        onLeftClicked: messageOff() // 发送至SerialPort
        onRightClicked: messageOff() // 发送至SerialPort
    }

    Connections{
        target: comButton3.circleInter
        onLeftClicked: messageOff() // 发送至SerialPort
        onRightClicked: messageOff() // 发送至SerialPort
    }

    Connections{
        target: comButton4.circleInter
        onLeftClicked: messageOff() // 发送至SerialPort
        onRightClicked: messageOff() // 发送至SerialPort
    }



}
