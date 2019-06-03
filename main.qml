import QtQuick 2.9
import QtQuick.Window 2.2
import QtCharts 2.0
import QtQuick.Controls 2.4
import QtGraphicalEffects 1.0
import io.serialport 1.0
import "menu"
import "chart"


Window {
    visible: true
    width: 1024
    height: 668
    title: qsTr("Hello World")
    color: "ivory"

    SetButton{
        id: setBtn
        posX: 550; posY: 10
        width: 30; height: 30
    }

    DropShadow{
        id: setBtn_shadow
        anchors.fill: setBtn
        horizontalOffset: 3
        verticalOffset: 3
        radius: 8.0
        samples: 17
        color: "black"
        opacity: 0
        source: setBtn

        states: State {
            name: "active"
            PropertyChanges {target: setBtn_shadow; opacity: 1}
        }
        Behavior on opacity {NumberAnimation{duration: 100; easing.type: Easing.Linear}}

        Connections{
            target: setBtn
            onShadowTrig: {
                if(setBtn.state == "active") setBtn_shadow.state = "active";
                else if(setBtn.state == "hover") setBtn_shadow.state = "";
            }
        }
    }

    SerialPortButton{
        id: serialPortBtn
        posX: 510; posY: 10
        width: 30; height: 30
    }

    DropShadow{
        id:serialPortBtn_shadow
        anchors.fill: serialPortBtn
        horizontalOffset: 3
        verticalOffset: 3
        radius: 8.0
        samples: 17
        color: "black"
        opacity: 0
        source: serialPortBtn

        states: State {
            name: "active"
            PropertyChanges {target: serialPortBtn_shadow; opacity:1}
        }
        Behavior on opacity {NumberAnimation{duration: 100; easing.type: Easing.Linear}}

        Connections{
            target: serialPortBtn
            onShadowTrig: {
                if(serialPortBtn.state == "active") serialPortBtn_shadow.state = "active";
                else if(serialPortBtn.state == "hover") serialPortBtn_shadow.state = "";
            }
        }
    }

    WlanButton{
        id: wlanBtn
        posX: 470; posY: 10
        width: 30; height: 30
    }

    DropShadow{
        id: wlanBtn_shadow
        anchors.fill: wlanBtn
        horizontalOffset: 3
        verticalOffset: 3
        radius: 8.0
        samples: 17
        color: "black"
        opacity: 0
        source: wlanBtn

        states: State {
            name: "active"
            PropertyChanges {target: wlanBtn_shadow; opacity: 1}
        }
        Behavior on opacity {NumberAnimation{duration: 100; easing.type: Easing.Linear}}

        Connections{
            target: wlanBtn
            onShadowTrig: {
                if(wlanBtn.state == "active") wlanBtn_shadow.state = "active";
                else if(wlanBtn.state == "hover") wlanBtn_shadow.state = "";
            }
        }
    }

    SerialPortListView{
        id: serialPortListView
        posX: 510; posY: -45
        delegate_width: 80
        delegate_height: 30

        Connections{
            target: serialPortBtn
            onListViewTrig: {
                if(serialPortBtn.state === "hover") serialPortListView.state = "";
                else if(serialPortBtn.state === "active") serialPortListView.state = "active";
                serialPortListView.close();
            }
        }
    }

    WlanListView{
        id: wlanListView
        posX: 470; posY: -45
        delegate_width: 80
        delegate_height: 30
        Connections{
            target: wlanBtn
            onWlanTrig: {
                if (wlanBtn.state === "hover") wlanListView.state = ""
                else if (wlanBtn.state === "active") wlanListView.state = "active"
            }
        }
    }

    MyChart{
        id: myChart
        chart_width: 500
        chart_height: 500
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: 80
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: 250
        //创建与ChartOperationBar的信号连接
        Connections{
            target: chartOperationBar
            onZoomIconClicked: {
                if(chartOperationBar.zoomIconState == "") myChart.is_zoom = false;
                else myChart.is_zoom = true;
                if(chartOperationBar.dragIconState == "active"){
                   chartOperationBar.dragIconState = ""; myChart.is_drag = false;
                }
                if(chartOperationBar.groundstationIconState == "active"){
                    chartOperationBar.groundstationIconState = ""; myChart.is_groundstation = false;
               }
            }
            onDragIconClicked: {
                if(chartOperationBar.dragIconState == "") myChart.is_drag = false;
                else myChart.is_drag = true;
                if(chartOperationBar.zoomIconState == "active"){
                    chartOperationBar.zoomIconState = ""; myChart.is_zoom = false;
                }
                if(chartOperationBar.groundstationIconState == "active"){
                    chartOperationBar.groundstationIconState = ""; myChart.is_groundstation = false;
                }
            }
            onGroundstationIconClicked: {
                if(chartOperationBar.groundstationIconState == "") myChart.is_groundstation = false;
                else myChart.is_groundstation = true;
                if(chartOperationBar.zoomIconState == "active"){
                    chartOperationBar.zoomIconState = ""; myChart.is_zoom = false;
                }
                if(chartOperationBar.dragIconState == "active"){
                    chartOperationBar.dragIconState = ""; myChart.is_drag = false;
                }
            }
            onResetIconClicked: {
                chartOperationBar.zoomIconState = ""; myChart.is_zoom = false;
                chartOperationBar.dragIconState = ""; myChart.is_drag = false;
                chartOperationBar.groundstationIconState = ""; myChart.is_groundstation = false;
                myChart.resetChartView();
            }
        }
    }

    ChartOperationBar{
        id: chartOperationBar
        opacity: 0
        rectheight: 20
        rectwidth: 20
        rectmargin: 2
        anchors.right: myChart.right;   anchors.rightMargin: 15
        anchors.top: myChart.top;   anchors.topMargin: 15

        State {name: "active"; PropertyChanges {target: operationBar; opacity: 1.0}}

        Behavior on opacity { NumberAnimation{duration: 500; easing.type: Easing.OutCubic}}

        Connections{
            target: myChart
            onMouseEnterChart: {
                chartOperationBar.opacity = 1
            }
            onMouseExitChart: {
                chartOperationBar.opacity = 0
            }
        }
    }
}
