import QtQuick 2.9
import QtQuick.Window 2.2
import QtCharts 2.0
import QtQuick.Controls 2.4
import QtGraphicalEffects 1.0
import io.serialport 1.0
import "menu"
import "chart"
import "parapad"

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
        onTrigger: {
            // 针对setBtn的阴影
            if(setBtn.state == "active") setBtn_shadow.state = "active";
            else if(setBtn.state == "hover") setBtn_shadow.state = "";
            // 针对serialport
            serialPortBtn.state = ""; serialPortBtn_shadow.state = "";
            serialPortListView.listView.state = ""; serialPortListView.close();
            // 针对wlan
            wlanBtn.state = ""; wlanBtn_shadow.state = "";
            wlanListView.listView.state = "";
        }
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
    }

    SerialPortButton{
        id: serialPortBtn
        posX: 510; posY: 10
        width: 30; height: 30
        onTrigger: {
            // 针对serialport的阴影
            if(serialPortBtn.state == "active") serialPortBtn_shadow.state = "active";
            else if(serialPortBtn.state == "hover") serialPortBtn_shadow.state = "";
            // 针对serialport的列表
            if(serialPortBtn.state === "hover") serialPortListView.listView.state = "";
            else if(serialPortBtn.state === "active") serialPortListView.listView.state = "active";
            serialPortListView.close();

            // 针对set
            setBtn.state = ""; setBtn_shadow.state = "";
            // 针对wlan
            wlanBtn.state = ""; wlanBtn_shadow.state = "";
            wlanListView.listView.state = ""; wlanListView.close();
        }
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
    }

    WlanButton{
        id: wlanBtn
        posX: 470; posY: 10
        width: 30; height: 30
        onTrigger: {
            // 针对wlanBtn的阴影
            if(wlanBtn.state == "active") wlanBtn_shadow.state = "active";
            else if(wlanBtn.state == "hover") wlanBtn_shadow.state = "";
            // 针对wlan的列表
            if (wlanBtn.state === "hover") wlanListView.listView.state = ""
            else if (wlanBtn.state === "active") wlanListView.listView.state = "active"
            wlanListView.close();

            // 针对serialport
            serialPortBtn.state = ""; serialPortBtn_shadow.state = "";
            serialPortListView.listView.state = ""; serialPortListView.close();
            // 针对set
            setBtn.state = ""; setBtn_shadow.state = "";
        }
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
    }

    SerialPortListView{
        id: serialPortListView
        posX: 510; posY: -45
        delegate_width: 80
        delegate_height: 30
    }

    WlanListView{
        id: wlanListView
        posX: 470; posY: -45
        delegate_width: 80
        delegate_height: 30
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
        anchors.right: myChart.right;   anchors.rightMargin: 25
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

    ParaPad{
        x:-2; y: 450
    }
}
