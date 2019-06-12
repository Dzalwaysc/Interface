import QtQuick 2.7
import QtQuick.Controls 2.0

Item {

    // range信息
    property int rangeValue: 66
    property int nowRange: 66

    // 画布
    property int mW: 80
    property int mH: 80
    property int lineWidth: 1

    // Sin曲线
    property int sX: 0
    property int sY: mH / 2
    property int axisLength: mW;       // 轴长
    property double waveWidth: 0.015   // 波浪宽度，数越小越宽
    property double waveHeight: 1      // 波浪高度，数越大越高
    property double speed: 0.09        // 波浪速度，数越大速度越快
    property double xOffset: 0         // 波浪x偏移量

    Canvas{
        id: canvas
        height: mH
        width: mW
        anchors.centerIn: parent
        onPaint: {
            var ctx = getContext("2d");
            ctx.lineWidth = lineWidth

            // 画油箱
            var IsdrawTanked = false;
            var drawCirc = function(){
                var r = mH/2;
                var cR = r - 8*lineWidth
                ctx.strokeStyle = '#1080d0'; // 线条颜色
                ctx.beginPath();
                ctx.arc(r, r, cR+1, 100*Math.PI/180, 355*Math.PI/180);
                ctx.stroke();
                ctx.beginPath();
                ctx.arc(r, r, cR, 100*Math.PI/180, 355*Math.PI/180);
                ctx.stroke();
                ctx.clip();
            }

            // 显示sin曲线
            var drawSin = function(xOffset){
                ctx.save();
                var points = [];
                ctx.strokeStyle = "red";
                ctx.fillStyle = Qt.lighter('#1080d0');
                ctx.beginPath();
                for(var x = sX; x < sX + axisLength; x += 20 / axisLength){
                    var y = - Math.sin((sX + x) * waveWidth + xOffset);
                    var dY = mH * (1 - nowRange / 100);
                    points.push([x, dY + y * waveHeight]);
                    ctx.lineTo(x, dY + y * waveHeight);
                }

                // 封闭路径
                ctx.lineTo(axisLength, mH);
                ctx.lineTo(sX, mH);
                ctx.lineTo(points[0][0], points[0][1]);
                ctx.stroke();
                ctx.fill()
                ctx.restore();
            }

            // 显示百分数
            var drawText = function(){
                ctx.save();
                var size = 0.2*mW;
                ctx.font = size + 'px Monaco';
                ctx.textAlign = 'center';
                ctx.fillStyle = "rgba(14, 80, 14, 0.8)";
                ctx.fillText(~~nowRange + '%', mW/2, mW/2 + size / 2);

                ctx.restore();
            }

            // 加入渲染
            var render = function(){
                ctx.clearRect(0, 0, mW, mH);
                if(IsdrawTanked == false){
                    //drawTank();
                    drawCirc();
                }


                drawSin(xOffset);
                drawText();

                xOffset += speed;
                requestAnimationFrame(render);
            }
            render();
            //drawTank();
        }

    }

}
