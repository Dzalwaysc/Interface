import QtQuick 2.0

Item {
    id: photoElectric
    width: 450; height: 265

    // 由此控件产生的发送信息
    property string sendMsg
    signal getSendMsg();

    // 各个按钮的状态，激活为1，未激活为0
    property var stateBox: new Array

    function makeSendMsg(){
        sendMsg = stateBox.toString(" ");
        sendMsg = "5 " + sendMsg;
        getSendMsg();
    }

    Grid{
        anchors.top: parent.top; anchors.topMargin: 10
        anchors.left: parent.left; anchors.leftMargin: 5
        rows: 4
        rowSpacing: 15
        columns: 6
        columnSpacing: 15

        IOButton{
            id: ioBtn1
            onClicked: {
                if(ioBtn1.state === "active") stateBox[0] = 1;
                else stateBox[0] = 0;
                makeSendMsg();
            }
        }

        IOButton{
            id: ioBtn2
            onClicked: {
                if(ioBtn2.state === "active") stateBox[1] = 1;
                else stateBox[1] = 0;
                makeSendMsg();
            }
        }

        IOButton{
            id: ioBtn3
            onClicked: {
                if(ioBtn3.state === "active") stateBox[2] = 1;
                else stateBox[2] = 0;
                makeSendMsg();
            }
        }

        IOButton{
            id: ioBtn4
            onClicked: {
                if(ioBtn4.state === "active") stateBox[3] = 1;
                else stateBox[3] = 0;
                makeSendMsg();
            }
        }

        IOButton{
            id: ioBtn5
            onClicked: {
                if(ioBtn5.state === "active") stateBox[4] = 1;
                else stateBox[4] = 0;
                makeSendMsg();
            }
        }

        IOButton{
            id: ioBtn6
            onClicked: {
                if(ioBtn5.state === "active") stateBox[5] = 1;
                else stateBox[5] = 0;
                makeSendMsg();
            }
        }

        IOButton{
            id: ioBtn7
            onClicked: {
                if(ioBtn7.state === "active") stateBox[6] = 1;
                else stateBox[6] = 0;
                makeSendMsg();
            }
        }

        IOButton{
            id: ioBtn8
            onClicked: {
                if(ioBtn8.state === "active") stateBox[7] = 1;
                else stateBox[7] = 0;
                makeSendMsg();
            }
        }

        IOButton{
            id: ioBtn9
            onClicked: {
                if(ioBtn9.state === "active") stateBox[8] = 1;
                else stateBox[8] = 0;
                makeSendMsg();
            }
        }

        IOButton{
            id: ioBtn10
            onClicked: {
                if(ioBtn10.state === "active") stateBox[9] = 1;
                else stateBox[9] = 0;
                makeSendMsg();
            }
        }

        IOButton{
            id: ioBtn11
            onClicked: {
                if(ioBtn11.state === "active") stateBox[10] = 1;
                else stateBox[10] = 0;
                makeSendMsg();
            }
        }

        IOButton{
            id: ioBtn12
            onClicked: {
                if(ioBtn12.state === "active") stateBox[11] = 1;
                else stateBox[11] = 0;
                makeSendMsg();
            }
        }

        IOButton{
            id: ioBtn13
            onClicked: {
                if(ioBtn13.state === "active") stateBox[12] = 1;
                else stateBox[12] = 0;
                makeSendMsg();
            }
        }

        IOButton{
            id: ioBtn14
            onClicked: {
                if(ioBtn14.state === "active") stateBox[13] = 1;
                else stateBox[13] = 0;
                makeSendMsg();
            }
        }

        IOButton{
            id: ioBtn15
            onClicked: {
                if(ioBtn15.state === "active") stateBox[14] = 1;
                else stateBox[14] = 0;
                makeSendMsg();
            }
        }

        IOButton{
            id: ioBtn16
            onClicked: {
                if(ioBtn16.state === "active") stateBox[15] = 1;
                else stateBox[15] = 0;
                makeSendMsg();
            }
        }

        IOButton{
            id: ioBtn17
            onClicked: {
                if(ioBtn17.state === "active") stateBox[16] = 1;
                else stateBox[16] = 0;
                makeSendMsg();
            }
        }

        IOButton{
            id: ioBtn18
            onClicked: {
                if(ioBtn18.state === "active") stateBox[17] = 1;
                else stateBox[17] = 0;
                makeSendMsg();
            }
        }

        IOButton{
            id: ioBtn19
            onClicked: {
                if(ioBtn19.state === "active") stateBox[18] = 1;
                else stateBox[18] = 0;
                makeSendMsg();
            }
        }

        IOButton{
            id: ioBtn20
            onClicked: {
                if(ioBtn20.state === "active") stateBox[19] = 1;
                else stateBox[19] = 0;
                makeSendMsg();
            }
        }

        IOButton{
            id: ioBtn21
            onClicked: {
                if(ioBtn21.state === "active") stateBox[20] = 1;
                else stateBox[20] = 0;
                makeSendMsg();
            }
        }

        IOButton{
            id: ioBtn22
            onClicked: {
                if(ioBtn22.state === "active") stateBox[21] = 1;
                else stateBox[21] = 0;
                makeSendMsg();
            }
        }

        IOButton{
            id: ioBtn23
            onClicked: {
                if(ioBtn23.state === "active") stateBox[22] = 1;
                else stateBox[22] = 0;
                makeSendMsg();
            }
        }

        IOButton{
            id: ioBtn24
            onClicked: {
                if(ioBtn24.state === "active") stateBox[23] = 1;
                else stateBox[23] = 0;
                makeSendMsg();
            }
        }
    }

    Component.onCompleted: {
        for(var i=0; i<24; i++) stateBox[i] = 0;
    }
}
