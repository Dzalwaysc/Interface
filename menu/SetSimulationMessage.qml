import QtQuick 2.0
import QtGraphicalEffects 1.0
import io.simulation 1.0
import "../button"

Rectangle{
    id: simulationMessage
    width: 380; height: 200
    color: Qt.rgba(255, 0, 0, .4)
    border.color: Qt.rgba(255, 0, 0, .4)
    border.width: 2
    opacity: 0
    radius: 4
    x: -380
    y: 230

    // 仿真数据
    property double actual_x
    property double actual_y
    property double actual_yaw: 30
    property double actual_u: 10
    property double actual_v
    property double actual_r: 1.5

    // 字体
    property string fontfamily: "Monaco"
    property color fontcolor: "white"

    // 传给chart的信号，告诉chart仿真数据已更新
    signal updateSimulate()
    signal resetSimulate()

    // 传给paraPad的信号，告诉paraPad弹出或者弹回
    signal paraPopup()
    signal paraPopdown()

    // 传给chart的信号，告诉paraPad弹出或者弹回
    signal chartPopup()
    signal chartPopdown()

    states: State {
        name: "active"
        PropertyChanges { target: simulationMessage; opacity: 1; x: 2 }
    }

    transitions: [
        Transition {
            from: "";  to: "active"; reversible: false
            NumberAnimation{properties: "opacity, x"; duration: 100; easing.type: Easing.Linear}
        },
        Transition {
            from: "active"; to: ""; reversible: false
            NumberAnimation{properties: "opacity, x"; duration: 100; easing.type: Easing.Linear}
        }
    ]

    // 仿真状态文本
    Text{
        id: simuState
        text: "未开始..."
        font.family: fontfamily
        font.pixelSize: 15
        color:fontcolor
        anchors.top: simulationMessage.top; anchors.topMargin: 10
        anchors.right: simulationMessage.right; anchors.rightMargin: 10
    }

    // 开始按钮
    ButtonOne{
        id: startBtn
        btnWidth: 80; btnHeight: 30
        x: 20; y: 160
        btnText: "开始仿真"
        onClicked: {
            simulation.run();
            simuState.text = "正在进行";
        }
    }

    // 关闭按钮
    ButtonOne{
        id: stopBtn
        btnWidth: 80; btnHeight: 30
        anchors.bottom: startBtn.bottom
        anchors.left: startBtn.right; anchors.leftMargin: 10
        btnText: "停止仿真"
        onClicked: {
            simulation.stop();
            simuState.text = "已停止...";
        }
    }

    // 重置按钮
    ButtonOne{
        id: resetBtn
        btnWidth: 80; btnHeight: 30
        anchors.bottom: stopBtn.bottom
        anchors.left: stopBtn.right; anchors.leftMargin: 10
        btnText: "重置"
        onClicked: {
            simulation.reset();
            simuState.text = "未开始...";
        }
    }

    // 弹出参数面板按钮
    ButtonOne{
        id: popParaBtn
        btnWidth: 100; btnHeight: 30
        anchors.bottom: startBtn.top; anchors.bottomMargin: 10
        anchors.left: startBtn.left
        btnText: "弹出参数面板"
        onClicked: {
            if(btnText === "弹出参数面板"){
                paraPopup()
                btnText = "弹回参数面板"
            }else{
                paraPopdown()
                btnText = "弹出参数面板"
            }
        }
    }

    // 弹出坐标面板按钮
    ButtonOne{
        id: popChartBtn
        btnWidth: 100; btnHeight: 30
        anchors.top: popParaBtn.top
        anchors.left: popParaBtn.right; anchors.leftMargin: 15
        btnText: "弹出随体坐标"
        onClicked: {
            if(btnText === "弹出随体坐标"){
                chartPopup()
                btnText = "弹回随体坐标"
            }else{
                chartPopdown()
                btnText = "弹出随体坐标"
            }
        }
    }

    // 仿真测试
    Simulation{
       id: simulation
       onShipDataUpdate: {
           actual_x = simulation.x.toFixed(1);
           actual_y = simulation.y.toFixed(1);
           actual_yaw = simulation.yaw.toFixed(1);
           actual_u = simulation.u.toFixed(1);
           actual_v = simulation.v.toFixed(1);
           actual_r = simulation.r.toFixed(1);
           updateSimulate();
       }
       onSimulationReset: {
           actual_x = 0; actual_y = 0; actual_yaw = 0;
           actual_u = 0; actual_v = 0; actual_r = 0;
           resetSimulate();
       }
    }

    Image {
        id: name
        width: 200; height: 200
        source: "image/bian.png"
        anchors.right: simulationMessage.right
        anchors.rightMargin: -62
        anchors.top: simulationMessage.top
        opacity: 0.15
    }

    Glow {
        anchors.fill: simulationMessage
        radius: 7            //半径决定辉光的柔和度，半径越大辉光的边缘越模糊  样本值=1+半径*2
        samples: 13           //每个像素采集的样本值，值越大，质量越好，渲染越慢
        color: "#ddd"
        source: Rectangle{
            width: 380; height: 200
            radius: 2
            color: "transparent"
            border.color: "white"
        }
        spread: 0.5         //在光源边缘附近增强辉光颜色的大部分
        opacity: simulationMessage.opacity
    }
}