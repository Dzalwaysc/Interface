/****************************************************************************
**这是chart主体
**因为qt chart使用qt图形视图框架进行绘图
**在main.cpp中所有的QGuiApplication必须替换为QApplication。
**我们需要在.pro文件中添加：QT += widgets以使用Qapplication

**使用鼠标单击并释放来选择要放大的区域
**使用鼠标双击缩放重置
**使用鼠标滚轮缩放
**使用键滚动
**旋转功能仅在工作中
**--我们已经有了旋转属性
**鼠标拖动
**——还是想弄清楚

**ChartView

**表格横纵坐标刻度线划分：min（主宽*12/1480，主高*12/960）
**LineSeries   画一个简单折线图
**ScatterSeries  接受散点图  LineSeries连起来
**映射的x,y是中心点，因此我们需要让图片的中心点对准映射的xy，同时照片旋转的点是中心点，但是image的重心点在2/3Height处
**zoom 十字架
**drag 手
**groundstation 手指尖
**其他 箭头
**zoomArea 点击zoom时在表格范围内定义的一个矩形框
**Menu定义右击两种菜单

chart进行zoom操作的时候，产生的矩形在zoomArea组件更改
****************************************************************************/

import QtQuick 2.9
import QtCharts 2.0
import QtQuick.Controls 2.4
import "script/chartscript.js" as Script

Item{
    id: myChart
    width: chart_width
    height: chart_height
    anchors.verticalCenter: parent.verticalCenter
    anchors.horizontalCenter: parent.horizontalCenter
    rotation: chart_rotation

    // 坐标轴属性
    property real chart_width
    property real chart_height
    property real chart_rotation: 0  //预留属性，和RotationButton配合
    property real axisX_min: 0
    property real axisX_max: 800
    property real axisY_min: 0
    property real axisY_max: 800

    // 坐标轴内的值
    property real originx: 0
    property real originy: 0
    property real currentx: 0
    property real currenty: 0

    // 当前点的位置
    property real current_point_x: pathSeries.at(pathSeries.count-1).x
    property real current_point_y: pathSeries.at(pathSeries.count-1).y

    // 当前要移动的目标点的位置
    property real move_point_x: 0
    property real move_point_y: 0

    // 控制MouseArea的功能
    property bool is_zoom: false
    property bool is_drag: false
    property bool is_groundstation: false

    // 用来实现reset功能
    signal resetChartView()

    // 当鼠标移到chart区域时，才显示operationBay，因此这里给出鼠标移到chart区域的信号
    signal mouseEnterChart()
    signal mouseExitChart()

    onResetChartView: {
        axisX.min = axisX_min; axisX.max = axisX_max;
        axisY.min = axisY_min; axisY.max = axisY_max;
        chartView.zoomReset();
    }

    ChartView{
        id: chartView
        anchors.fill: parent
        anchors.centerIn: parent
        antialiasing: true       //是否抗锯齿
        legend.visible: false
        //backgroundColor: "black"
        theme:ChartView.ChartThemeHighContrast

        // margin between chart rectangle and the plot area
//        margins.top: 0
//        margins.left: 0
//        margins.bottom: 0
//        margins.right: 0

        ValueAxis{
            id: axisX
            min: axisX_min
            max: axisX_max
            lineVisible: true
            labelsVisible: true
            gridVisible: false
            labelsColor: "red"
        }

        ValueAxis{
            id: axisXTop
            min: axisX_min
            max: axisX_max
            lineVisible: true
            labelsVisible: false
            gridVisible: false
        }

        ValueAxis{
            id: axisY
            min: axisY_min
            max: axisY_max
            lineVisible: true
            labelsVisible: true
            gridVisible: false
            labelsColor: "red"
        }

        ValueAxis{
            id: axisYRight
            min: axisY_min
            max: axisY_max
            lineVisible: true
            labelsVisible: false
            gridVisible: false
            labelsColor: "red"
        }

        LineSeries{                       
            id: pathSeries
            axisX: axisX
            axisY: axisY
            XYPoint { x: 0; y: 0 }
            XYPoint { x: 1.1; y: 2.1 }
            XYPoint { x: 1.9; y: 3.3 }
            XYPoint { x: 2.1; y: 2.1 }
            XYPoint { x: 2.9; y: 4.9 }
            XYPoint { x: 3.4; y: 3.0 }
            XYPoint { x: 4.1; y: 3.3 }
            XYPoint { x: 10;  y: 10 }
        }

        ScatterSeries{                                  
            id: targetPointSeries
            axisX: axisX; axisY: axisY
            pointsVisible: true; color: "#7cfc00"; borderWidth: 0     //数据点是否可见并需要绘制
            markerSize: 8                                             //标记点的大小
            pointLabelsVisible: true; pointLabelsColor: "#EFFFE9"
            property string state: "ready"

            onClicked: {
                console.log(point)
                move_point_x = point.x; move_point_y = point.y;
                itemMouseArea.enabled = true;
                state = "moving"
            }
        }

        LineSeries{
            id: targetLineSeries
            axisXTop: axisXTop; axisYRight: axisYRight
            opacity: 0
            Behavior on opacity { NumberAnimation{duration: 1000}}
        }
    }

    MouseArea{
        id: itemMouseArea
        anchors.fill: parent
        anchors.centerIn: parent
        hoverEnabled: true
        acceptedButtons: Qt.LeftButton | Qt.RightButton

        signal zoomDone
        signal zoomBegin
        signal zoomCurrent
        signal groundStationCurrent

        Text {
            // opacity在 onEntered中被改成1
            id: mouseValueText
            opacity: 0; color: "black"           //不透明度
            x: itemMouseArea.mouseX + 5; y: itemMouseArea.mouseY - 10
            text: currentx + ", " + currenty
        }

        onEntered: {
            myChart.mouseEnterChart()
            if(myChart.is_zoom){
                cursorShape = Qt.CrossCursor
            }else if(myChart.is_drag){
                cursorShape = Qt.OpenHandCursor
            }else if(myChart.is_groundstation){
                cursorShape = Qt.PointingHandCursor
                mouseValueText.opacity = 1
            }else{
                cursorShape = Qt.ArrowCursor
            }
        }

        onExited: {
            myChart.mouseExitChart()
            mouseValueText.opacity = 0
        }

        onPressed: {
            // 开始zoomIn， 这一步选取zoomIn的起始点
            if(myChart.is_zoom){
                Script.originPressPosition(mouseX, mouseY);
                zoomBegin(); // send signal to zoomArea
            }
            // 开始drag，这一步打开drag定时器，同时获得lastX, lastY -- drag用定时器是因为提高流畅度
            else if(myChart.is_drag){
                cursorShape = Qt.ClosedHandCursor;
                Script.originPressPosition(mouseX, mouseY)
                dragTimer.start();
            }
        }

        onPositionChanged: {
            // zoomIn过程，这一步绘制zoomIn的区域矩形
            if(myChart.is_zoom){
                zoomCurrent(); // send signal to zoomArea
            }
            // drag过程，这一步实时获取当前的鼠标位置
            else if(myChart.is_drag){
                currentx = mouseX; currenty = mouseY; // 在drag过程中，直接用position的值就行
            }
            // ground过程，这一步显示Text内容
            else if(myChart.is_groundstation){
                currentx = chartView.mapToValue(Qt.point(mouseX, mouseY)).x.toFixed(1);
                currenty = chartView.mapToValue(Qt.point(mouseX, mouseY)).y.toFixed(1);
            }

            //移动
            if(targetPointSeries.state === "moving"){
                currentx = chartView.mapToValue(Qt.point(mouseX, mouseY)).x;
                currenty = chartView.mapToValue(Qt.point(mouseX, mouseY)).y;
                targetPointSeries.replace(move_point_x, move_point_y, currentx, currenty);
                targetLineSeries.replace(move_point_x, move_point_y, currentx, currenty);
                move_point_x = currentx; move_point_y = currenty;
            }
        }

        onReleased: {
            // 结束zoomIn，区域矩形消失，图像更新位置
            if(myChart.is_zoom){
                Script.finalZoomIn(mouseX, mouseY);
                zoomDone(); // send signal to zoomArea
            }
            // 结束drag， 定时器关闭
            else if(myChart.is_drag){
                cursorShape = Qt.OpenHandCursor;
                dragTimer.stop();
            }
        }

        onClicked: {
            console.log(chartView.mapToPosition(Qt.point(0, 0))); // 用来定位航行器位置
            Script.flashImage();
            if(myChart.is_groundstation && mouse.button === Qt.LeftButton){
                Script.groundstationAppend(mouseX, mouseY)
            }
            if(mouse.button === Qt.RightButton){
                contextMenu.popup();
            }

            // 移动
            if(targetPointSeries.state === "moving"){
                targetPointSeries.state = "ready"
                move_point_x = 0; move_point_y = 0;
            }
        }

        //wheelzoom
        onWheel: Script.wheelZoom(wheel.angleDelta.y)
    }

    Rectangle{
        id: zoomArea;
        opacity: 0.5
        color: "white"

        radius: 5             //此属性保留用于绘制圆角矩形的角半径。
        border.color: "black"

        property real left_topx: originx > itemMouseArea.mouseX ? itemMouseArea.mouseX : originx
        property real left_topy: originy > itemMouseArea.mouseY ? itemMouseArea.mouseY : originy
        property real area_width: Math.abs(itemMouseArea.mouseX - originx)
        property real area_height: Math.abs(itemMouseArea.mouseY - originy)
        property bool is_choice: false

        Connections{
            target: itemMouseArea
            onZoomBegin:{
                zoomArea.is_choice = true;
            }

            onZoomCurrent:{
                if(zoomArea.is_choice)
                    Script.choiceZoomArea(zoomArea.left_topx, zoomArea.left_topy,
                                            zoomArea.area_width, zoomArea.area_height);
                else
                    Script.choiceZoomArea(zoomArea.left_topx, zoomArea.left_topy, 0, 0);
            }

            onZoomDone: {
                Script.choiceZoomArea(zoomArea.left_topx, zoomArea.left_topy, 0, 0);
                zoomArea.is_choice = false;
            }
        }
    }

    Timer{
        id: dragTimer
        interval: 100; running: false; repeat: true          //时间间隔
        onTriggered: Script.dragScroll(currentx, currenty)
    }

    PointList{
        id: pointList
        x:-chart_width*2;  y: -15
        location_x: chart_width
        state: myChart.is_groundstation == true ? "active" : ""
        onTextInputChanged: {
            var modifypoint = targetPointSeries.at(index)
            console.log(targetLineSeries.at(index))
            if(roles == "positionX" || roles == "positionY"){
                    targetLineSeries.replace(modifypoint.x, modifypoint.y, model.get(index).positionX, model.get(index).positionY)
                    targetPointSeries.replace(modifypoint.x, modifypoint.y, model.get(index).positionX, model.get(index).positionY)
            }
        }
        onListView_targetPointAppend: {
            targetLineSeries.append(0, 0)
            targetPointSeries.append(0, 0)
        }

        onStart: {
            targetLineSeries.opacity = 0.8;
        }
        onClear: {
            targetLineSeries.clear()
            targetPointSeries.clear()
            model.clear()
        }
    }

    Menu{
        id: contextMenu
        width: 60; height: 20
        MenuItem{
            text: "reset"; font.pixelSize: 10; width: 60; height: 20
        }

        MenuItem{
            id: removeButton
            text: "move"; font.pixelSize: 10; width: 60; height: 20;
            enabled: targetPointSeries.count > 0
            onEnabledChanged: {
                if(enabled === true){
                    console.log("hi")
                    contextMenu.height = 80
                }else{
                    contextMenu.height = 20
                }

            }

            onTriggered: {
                if(text === "move") {
                    text = "ensure";
                    itemMouseArea.enabled = false
                }else{
                    text = "move"
                    itemMouseArea.enabled = true
                }
            }
        }
        MenuItem{
            text: "delete"; font.pixelSize: 10; width: 60; height: 20;
        }
    }
}
