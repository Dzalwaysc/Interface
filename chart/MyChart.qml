/****************************************************************************
**这是chart主体
**因为qt chart使用qt图形视图框架进行绘图
**在main.cpp中所有的QGuiApplication必须替换为QApplication。
**我们需要在.pro文件中添加：QT += widgets以使用Qapplication

    1.zoom放大
**使用鼠标单击并释放来选择要放大的区域
**使用鼠标双击缩放重置
**使用鼠标滚轮缩放

** 放大操作在is_zoom为true的时候开始
** 绘制矩形在is_choice为true时开始
** 放大处理函数, 过程:
        1）.鼠标按下得到起始点originx、originy
        2）.鼠标拖动绘制矩形
        3）.鼠标放开，区域矩形消失，图像更新位置
                  放大后矩形左上角x值为绘制矩形过程中初始点和终止点中最大的x点值
                  放大后矩形左上角y值为绘制矩形过程中初始点和终止点中最大的y点值
                  绘制的矩形宽为绘制矩形过程中初始点和终止点x差值的绝对值
                  绘制的矩形高为绘制矩形过程中初始点和终止点y差值的绝对值

    2.drag 拖动操作
** 拖动操作在isDrag为true的时候开始
** 每隔100ms 进行一次拖动操作       间隔时间通过dragTimer设置
         拖动处理函数, 过程:
             1）.首先鼠标按压下 -> 我们得到起始点  oX和oY
             2）.然后鼠标移动 -> 我们得到终止点   cX和cY
             3）.坐标轴移动距离即为  cX-oX 和 cY-oY
                        为了让这个过程看起来更加流畅，这里对缩小移动距离，即乘上了0.8
                        为了让这个过程不那么敏感，给定一个无效范围(-0.2, 0.2)
             4）.结束一次拖动，将cX和cY赋值给oX和oY，即下一次拖动的原点为当前拖动的终止点

    3.图标
        zoom 十字架
        drag 手
        groundstation 手指尖
        其他 箭头
        Menu定义右击两种菜单
****************************************************************************/

import QtQuick 2.9
import QtCharts 2.0
import QtQuick.Controls 2.4
import "script/chartscript.js" as Script

Item{
    id: myChart
    width: chart_width
    height: chart_height
    x: posX; y: posY
    rotation: chart_rotation

    property string fontfamily: "Monaco"
    property real fontpixelSize: 15            //字体大小

    // 坐标轴属性
    property real chart_width
    property real chart_height
    property real chart_rotation: 0  //预留属性，和RotationButton配合
    property real axisX_min: 0
    property real axisX_max: 800
    property real axisY_min: 0
    property real axisY_max: 800
    property real posX: 0
    property real posY: 0

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

    // 将path暴露给外部使用
    property alias chartView: chartView
    property alias pathSeries: pathSeries
    property alias targetPointSeries: targetPointSeries
    property alias targetLineSeries: targetLineSeries
    property alias itemMouseArea: itemMouseArea

    // 当鼠标移到chart区域时，才显示operationBar，因此这里给出鼠标移到chart区域的信号
    signal mouseEnterChart()
    signal mouseExitChart()

    // 用作右侧拉伸动画
    states: State {
        name: "active"
        PropertyChanges {target: myChart; x: posX-600}
    }

    transitions: [
        Transition {
            from: "active"; to: ""; reversible: false
            NumberAnimation{properties: "opacity, x"; duration: 100; easing.type: Easing.Linear}
        },
        Transition {
            from: ""; to: "active"; reversible: false
            NumberAnimation{properties: "opacity, x"; duration: 100; easing.type: Easing.Linear}
        }
    ]

    onResetChartView: {
        axisX.min = axisX_min; axisX.max = axisX_max;
        axisY.min = axisY_min; axisY.max = axisY_max;
        chartView.zoomReset();
    }

    Image{
        id: googleMag
        anchors.centerIn: parent
        width: 400; height: 400
        source: "image/map.png"
    }

    ChartView{
        id: chartView
        anchors.fill: parent
        anchors.centerIn: parent
        antialiasing: true       //是否抗锯齿
        legend.visible: false
        backgroundColor: Qt.rgba(0, 22, 255, 0.1)
        plotAreaColor: "black"
//        theme:ChartView.ChartThemeHighContrast

        // margin between chart rectangle and the plot area
        margins.top: 0
        margins.left: 0
        margins.bottom: 0
        margins.right: 0

        ValueAxis{
            id: axisX
            min: axisX_min
            max: axisX_max
            lineVisible: false
            labelsVisible: false
            gridVisible: false
            labelsColor: "red"
            labelsFont.family: fontfamily
            labelsFont.pixelSize: fontpixelSize
        }

        ValueAxis{
            id: axisXTop
            min: axisX_min
            max: axisX_max
            lineVisible: false
            labelsVisible: false
            gridVisible: false
            labelsFont.family: fontfamily
            labelsFont.pixelSize: fontpixelSize
        }

        ValueAxis{
            id: axisY
            min: axisY_min
            max: axisY_max
            lineVisible: false
            labelsVisible: false
            gridVisible: false
            labelsColor: "red"
            labelsFont.family: fontfamily
            labelsFont.pixelSize: fontpixelSize
        }

        ValueAxis{
            id: axisYRight
            min: axisY_min
            max: axisY_max
            lineVisible: false
            labelsVisible: false
            gridVisible: false
            labelsColor: "red"
            labelsFont.family: fontfamily
            labelsFont.pixelSize: fontpixelSize
        }

        LineSeries{
            id: pathSeries
            axisX: axisX
            axisY: axisY
            useOpenGL: true // 使chart再增加点的时候更加流畅
        }

        //  接受散点图
        ScatterSeries{
            id: targetPointSeries
            axisX: axisX; axisY: axisY
            pointsVisible: true;
            color: "#7cfc00";
            borderWidth: 0     //数据点是否可见并需要绘制
            markerSize: 8                                             //标记点的大小
            pointLabelsVisible: true;
            pointLabelsColor: "red"
            pointLabelsFont: fontfamily
            property string state: "ready"

            Component.onCompleted: console.log("字体大小" + pointLabelsFont.pixelSize)

            onClicked: {
                move_point_x = point.x; move_point_y = point.y;
                itemMouseArea.enabled = true;
                state = "moving"
            }
        }

        //  LineSeries连起来画一个简单折线图
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
            opacity: 0; color: "green"           //不透明度
            x: itemMouseArea.mouseX + 5; y: itemMouseArea.mouseY - 10
            text: currentx + ", " + currenty
            font.family: fontfamily
            font.pixelSize: fontpixelSize

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

    Menu{
        id: contextMenu
        width: 60; height: 20
        MenuItem{
            text: "reset"; font.pixelSize: 10; width: 60; height: 20;font.family: fontfamily
        }
        MenuItem{
            id: removeButton
            text: "move"; font.pixelSize: 10; width: 60; height: 20;font.family: fontfamily
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
            text: "delete"; font.pixelSize: 10; width: 60; height: 20;font.family: fontfamily
        }
    }
}
