import QtQuick 2.9
import QtQuick.Window 2.2
import QtCharts 2.0
import QtQuick.Controls 2.4
import QtGraphicalEffects 1.0
import "menu"
import "chart"
import "parapad"
import "board"
import "background"
import "serialport"
import "control"
import "button"

Window {
    visible: true
    width: 1024
    height: 668
    title: qsTr("Hello World")
    color: Qt.hsla(230, 0.64, 0.06, 1)

    /**************** 星空背景 ************************/
    // 星星和仪表盘框架  使用图片是因为这样加载更快
    // 该图片制造在Qt技术储备 -> 仪表盘 -> 完整仪表盘
    Image{
        z: -1
        anchors.centerIn: parent
        anchors.fill: parent
        source: "background/image/frame.png"
    }

    /**************** 菜单栏 ************************/
    // 设置按钮
    ControlButton{
        id: controlBtn
        posX: 240; posY: 160
        width: 30; height: 30
        onTrigger: {
            // 针对set的列表
            if(controlBtn.state == "hover") control.listView.state = "";
            else if(controlBtn.state == "active") control.listView.state = "active";
            control.close();
            // 针对wlan
            wlanBtn.state = "";
            wlanListView.listView.state = ""; wlanListView.close();
            //针对parapad
            parapadbutton.state = ""; parapad.state = ""
        }
        BoxOne{
            mW: 40; mH:20
            opacity: parent.state === "hover" ? 1 : 0
            anchors.left: parent.left; anchors.leftMargin: -3
            anchors.bottom: parent.top
            context: "设置"
        }
    }

    // 无线按钮
    WlanButton{
        id: wlanBtn
        posX: 160; posY: 160
        width: 30; height: 30
        onTrigger: {
            // 针对wlan的列表
            if (wlanBtn.state === "hover") wlanListView.listView.state = ""
            else if (wlanBtn.state === "active") wlanListView.listView.state = "active"
            wlanListView.close();
            // 针对set
            controlBtn.state = "";
            control.listView.state = "";   control.close()
            //针对parapad
            parapadbutton.state = ""; parapad.state = ""
        }
        BoxOne{
            mW: 40; mH:20
            opacity: parent.state === "hover" ? 1 : 0
            anchors.left: parent.left; anchors.leftMargin: -3
            anchors.bottom: parent.top
            context: "无线"
        }
    }

    // 设置选项卡
    Control{
        id: control
    }

    // 串口选项卡
    SerialPort{
        id: serialPort
    }

    // 无线选项卡
    WlanListView{
        id: wlanListView
        posX: 160; posY: 195
        delegate_width: 60
        delegate_height: 20
    }

    /**************** 随体坐标 ************************/
    // 随体坐标图
    MyChart{
        id: myChart
        chart_width: 500
        chart_height: 500
        posX: 1112; posY: 164
        //创建与ChartOperationBar的信号连接
        Connections{
            target: chartOperationBar
            onZoomIconClicked: {
                if(chartOperationBar.zoomIconState === "") myChart.is_zoom = false;
                else myChart.is_zoom = true;
                if(chartOperationBar.dragIconState === "active"){
                   chartOperationBar.dragIconState = ""; myChart.is_drag = false;
                }
                if(chartOperationBar.groundstationIconState === "active"){
                    chartOperationBar.groundstationIconState = ""; myChart.is_groundstation = false;
               }
            }
            onDragIconClicked: {
                if(chartOperationBar.dragIconState === "") myChart.is_drag = false;
                else myChart.is_drag = true;
                if(chartOperationBar.zoomIconState === "active"){
                    chartOperationBar.zoomIconState = ""; myChart.is_zoom = false;
                }
                if(chartOperationBar.groundstationIconState === "active"){
                    chartOperationBar.groundstationIconState = ""; myChart.is_groundstation = false;
                }
            }
            onGroundstationIconClicked: {
                if(chartOperationBar.groundstationIconState === "") myChart.is_groundstation = false;
                else myChart.is_groundstation = true;
                if(chartOperationBar.zoomIconState === "active"){
                    chartOperationBar.zoomIconState = ""; myChart.is_zoom = false;
                }
                if(chartOperationBar.dragIconState === "active"){
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

        // 创建与Simulation的信号连接
        Connections{
            target: control.simulationMessage
            onUpdateSimulate: {
                myChart.pathSeries.append(control.simulationMessage.actual_x,
                                          control.simulationMessage.actual_y)
            }
            onResetSimulate: {
                myChart.pathSeries.clear();
            }

            onChartPopup: {
                myChart.state = "active"
                chartbutton.state = "active"
            }
            onChartPopdown: {
                myChart.state = ""
                chartbutton.state = ""
            }
        }
    }

    // 随体坐标图的拖拉按钮
    ChartButton{
        id: chartbutton
        posX: 1010; posY: 350
        onParapadTrigger: {
            if(chartbutton.state == "active") myChart.state = "active"
            else if(chartbutton.state == "hover") myChart.state = ""
        }

        // 提示框
        BoxOne{
            mW: 100; mH:20
            opacity: chartbutton.state === "hover" ? 1 : 0
            anchors.right: parent.left
            anchors.top: parent.top; anchors.topMargin: 20
            isMirror: true
            context: "随体坐标"
        }
    }

    // 随体坐标图中的菜单栏
    ChartOperationBar{
        id: chartOperationBar
        opacity: 0
        rectheight: 20
        rectwidth: 20
        rectmargin: 2
        anchors.right: myChart.right;   anchors.rightMargin: 35
        anchors.top: myChart.top;   anchors.topMargin: 20

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

    // 期望坐标点列表
    PointList{
        id: pointList
        x:-380;  y: 230
        state: myChart.is_groundstation == true ? "active" : ""

        onTextInputChanged: {
            // textInputChanged(index, roles):
            // 第一个参数为当前修改的值的位置，第二个参数为修改的内容(no,x,y)
            var modifypoint = targetPointSeries.at(index)
            console.log(myChart.targetLineSeries.at(index))
            if(roles == "positionX" || roles == "positionY"){
                myChart.targetLineSeries.replace(modifypoint.x, modifypoint.y, pointModel.get(index).positionX, pointModel.get(index).positionY)
                myChart.targetPointSeries.replace(modifypoint.x, modifypoint.y, pointModel.get(index).positionX, pointModel.get(index).positionY)
            }
        }

        onTargetPointAppend: {
            myChart.targetLineSeries.append(0, 0)
            myChart.targetPointSeries.append(0, 0)
        }

        onStart: {
            myChart.targetLineSeries.opacity = 0.8
        }

        onClear: {
            myChart.targetLineSeries.clear()
            myChart.targetPointSeries.clear()
            pointModel.clear()
        }

        Connections{
            target: myChart.itemMouseArea
            onClicked: {
                if(myChart.is_groundstation && mouse.button === Qt.LeftButton){
                    var mouseX = myChart.itemMouseArea.mouseX;
                    var mouseY = myChart.itemMouseArea.mouseY;
                    var newpoint = myChart.chartView.mapToValue(Qt.point(mouseX, mouseY))
                    myChart.targetPointSeries.append(newpoint.x.toFixed(1), newpoint.y.toFixed(1))
                    myChart.targetLineSeries.append(newpoint.x.toFixed(1), newpoint.y.toFixed(1))
                    pointList.pointModel.append({"orderNo": pointList.pointModel.count.toString(),
                                       "positionX": newpoint.x.toFixed(1).toString(),
                                       "positionY": newpoint.y.toFixed(1).toString()})
                }
            }
        }
    }

    /**************** 艇体参数面板 ************************/
    // 艇体参数面板
    ParaPad{
        id: parapad
        posX: 1025; posY: 20
        north_X: control.simulationMessage.actual_x
        east_Y: control.simulationMessage.actual_y
        yaw: control.simulationMessage.actual_yaw
        u: control.simulationMessage.actual_u
        v: control.simulationMessage.actual_v
        r: control.simulationMessage.actual_r

        // 创建与Simulation的信号连接
        Connections{
            target: control.simulationMessage
            onParaPopup: {
                parapadbutton.state = "active"
                parapad.state = "active"
            }
            onParaPopdown: {
                parapadbutton.state = ""
                parapad.state = ""
            }
        }
    }

    // 艇体参数面板的拖拉按钮
    ParaPadButton{
        id: parapadbutton
        posX: 1010; posY: 20
        onParapadTrigger: {
            if(parapadbutton.state == "active") parapad.state = "active"
            else if(parapadbutton.state == "hover") parapad.state = ""
        }

        // 提示框
        BoxOne{
            mW: 100; mH:20
            opacity: parapadbutton.state === "hover" ? 1 : 0
            anchors.right: parent.left
            anchors.top: parent.top; anchors.topMargin: 20
            isMirror: true
            context: "艇体参数面板"
        }
    }

    /**************** 仪表盘 ************************/
    // 速度仪表盘
    VelocityBoard{
        id: dashBoard
        x: 140; y: 20
        currentValue: control.simulationMessage.actual_u
    }

    // 航向仪表盘
    CourseBoard{
        id: courseBoard
        x: 300; y: 20
        currentValue: control.simulationMessage.actual_yaw
    }

    // 航向速度仪表盘
    CourseRateBoard{
        id: courseRateBoard
        x: 23; y: 45
        currentValue: control.simulationMessage.actual_r
    }

    // 油量
    FuelTank{
        x: 50; y: 30
    }

//    My3DBar{
//        x: 0; y: 440
//    }
}
