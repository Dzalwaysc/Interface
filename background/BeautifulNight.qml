// 静态星云图
import QtQuick 2.0

Item {
    property int mW: 1024
    property int mH: 668

    property int starsColor: 230    // 星星颜色(hsla的hue色调)
    property int starCount: 250  // 星星的数量
    property int starsradius: 3    // 星星半径比
    property int movrange: 2        // 星星移动范围（值越大范围越小）
    property int speed: 5000000       // 星星移动速度（值越大速度越慢）
    property double trailing: 0.5   // 星星拖尾效果(0~1值越小拖尾越明显
    property int count: 0           // 星星闪烁计数器

    property int rainCount: 2 // 流星的数量
    property double rainAlpha: 0.8
    property int rainLength: 10  // 流星的最小长度
    property int rainLengthPlus: 10 // 流星的随机长度范围，即流星长度为random*plus+length
    property int rainAngle: 30    // 流星下落的角度
    property double rainspeed: 10    // 流星下落的速度
    Canvas{
        id: startBackground
        anchors.centerIn: parent
        width: mW
        height: mH

        property int starNowCount: 0  // 星星的当前数量
        property var stars: []   // 星星列表


        onPaint: {
            var ctx = getContext("2d");
            /**********************星星*********************/
            var random = function(min, max){
                // 如果max和min都为整数的话
                // 随机过程: err = max-min+1 , k = random(0,1]
                //          result = k * err + min;
                if(arguments.length < 2){
                    max = min;
                    min = 0;
                }
                if(min > max){
                    var hold = max;
                    max = min;
                    min = hold;
                }
                // Math.floor()想下取整  Math.random()随机反正为[0,1)
                return Math.floor(Math.random() * (max - min + 1)) + min;
            }

            var maxOrbit = function(x, y){
                var max = Math.max(x, y);
                // diameter直径  Math.round四舍五入给整数
                var diameter = Math.round(Math.sqrt(max*max + max*max));
                return diameter / movrange;
                // 星星移动范围，值越大移动范围越小
            }

            var Star = function() {
                // 至画布中心的距离
                this.orbitRadius = random(maxOrbit(mW, mH), 50);
                // 星星的半径
                this.radius = random(starsradius, 3);

                this.orbitX = mW / 2;
                this.orbitY = mH / 2;
                this.timePassed = random(0, starCount);
                // 星星的移动速度
                this.speed = random(10) / speed;
                // 星星的透明度
                this.alpha = random(2, 10) / 10;

                count++;
                stars[count] = this;
            }

            Star.prototype.draw = function(){

                // 星星此刻的位置，以画布中心为圆心，半径随机的一个圆上的一个点
                var x = Math.sin(this.timePassed) * this.orbitRadius + this.orbitX;
                var y = Math.cos(this.timePassed) * this.orbitRadius + this.orbitY;

                // 星星闪烁
                var twinkle = random(10);
                if(twinkle === 1 && this.alpha>0){
                    this.alpha -= 0.01;
                }else if(twinkle === 2 && this.alpha<1){
                    this.alpha += 0.01;
                }
                ctx.globalAlpha = this.alpha;
                // 在画布上画星星，参数(image, x, y, w, h)
                ctx.drawImage(star, x-this.radius/2, y-this.radius/2, this.radius, this.radius);
                this.timePassed += this.speed;
            }
            for(var i=0; i<starCount; i++){
                stars[i] = new Star();
            }

            function animation() {
                ctx.globalCompositeOperation = 'source-over'
                ctx.globalAlpha = trailing;
                ctx.fillStyle = 'hsla(' + starsColor + ', 64%, 6%, 2)';
                ctx.fillRect(0, 0, mW, mH);

                ctx.globalCompositeOperation = 'lighter';

                for(var i=1, l= stars.length; i<l; i++){
                    stars[i].draw();
                }
                requestAnimationFrame(animation);
             }

            animation();
        }
    }

    Canvas{
        id: metorBackground
        anchors.centerIn: parent
        width: mW
        height: mH

        property int rainNowCount: 1  // 星星的当前数量
        property var rains: []   // 星星列表

        onPaint: {
            var ctx = getContext("2d");
            /*********************流星雨*********************/
            var MeteorRain = function() {
                this.x = -1;        // 横坐标
                this.y = -1;        // 纵坐标
                this.length = -1;   // 长度
                this.angle = 30;    // 倾斜角度
                this.width = -1;    // 宽度
                this.height = -1;   // 高度
                this.speed = 1;     // 速度
                this.offset_x = -1; // 横轴移动偏移量
                this.offset_y = -1; // 纵轴移动偏移量
                this.alpha = 1;     // 透明度
                this.color1 = "";   // 流星的中段颜色
                this.color2 = "";   // 流星的结束颜色

                // 获取随机坐标的函数
                this.getPos = function(){
                    this.x = Math.random() * mW/2 + mW/2;
                    this.y = Math.random() * 10;
                }

                // 获取随机颜色的函数
                this.getColor = function(){
                    // Math.ceil 向上取整
                    var a = Math.ceil(255 - 240*Math.random());
                    // 中段颜色
                    this.color1 = "rgba(" + a + "," + a + "," + a  + ",1)";
                    // 结束颜色
                    this.color2 = "#090723";
                }

                // 获取随机长度/速度的函数
                this.getLength = function(){
                    var x = Math.random() * 10 + rainLength;
                    this.length = Math.ceil(x); // 流星长度
                    x = Math.random() + rainspeed;
                    this.speed = Math.ceil(x); // 流星速度
                }

                // 获取倾斜角度/宽度/高度
                this.getSize = function(){
                    this.angle = rainAngle;
                    var cos = Math.cos(this.angle * Math.PI / 180);
                    var sin = Math.sin(this.angle * Math.PI / 180);
                    this.width = this.length * cos; // 流星所占宽度
                    this.height = this.length * sin // 流星所占高度
                    this.offset_x = this.speed * cos;
                    this.offset_y = this.speed * sin;
                }

                // 重新计算流星坐标
                this.newPos = function(){
                    this.x = this.x - this.offset_x;
                    this.y = this.y + this.offset_y;
                }

                // 初始化
                this.init = function(){
                    this.alpha = rainAlpha; // 透明度
                    this.getPos()
                    this.getColor();
                    this.getLength();
                    this.getSize();
                }

                // 绘制流星
                this.draw = function(){
                    ctx.save();
                    ctx.beginPath();
                    ctx.lineWidth = 1;
                    ctx.globalAlpha = this.alpha;

                    // 创建横行渐变颜色，起点坐标至终点坐标
                    var line_grd = ctx.createLinearGradient(this.x, this.y, this.x+this.width, this.y-this.height);
                    line_grd.addColorStop(0, "white");
                    line_grd.addColorStop(0.3, this.color1);
                    line_grd.addColorStop(0.6, this.color2);
                    ctx.strokeStyle = line_grd;

                    // 起点
                    ctx.moveTo(this.x, this.y)
                    // 终点
                    ctx.lineTo(this.x + this.width, this.y - this.height);

                    ctx.closePath();
                    ctx.stroke();
                    ctx.restore();
                }

                // 流星移动
                this.move = function(){
                    // 清空流星像素
                    var x = this.x + this.width - this.offset_x;
                    var y = this.y - this.height;
                    ctx.clearRect(x-3, y-3, this.offset_x+5, this.offset_y+5);
                    // 重新计算位置，往左下移动
                    this.newPos();
                    // 透明度改变
                    if(this.alpha>0.1)
                        this.alpha -= 0.002;
                    // 重绘
                    this.draw();
                }
            }

            // 创建流星雨
            for (var i=rainNowCount; i<rainCount; i++){
                var rain = new MeteorRain();
                rain.init();
                rain.draw();
                rains.push(rain);
            }

            function animation() {
                if(rainNowCount == 0){
                    var _r = Math.random();
                    if(_r <= 0.01){
                        rains[0] = new MeteorRain();
                        rains[0].init();
                        rainNowCount++;
                    }
                }

                for(var n=0; n<rainNowCount; n++){
                    rains[n].move(); // 移动
                    if(rains[n].y > mH){
                        ctx.clearRect(rains[n].x, rains[n].y-rains[n].height,
                                      rains[n].width, rains[n].height);
                        rainNowCount -= 1;
                        if(Math.random() <= 1){
                            rains[n] = new MeteorRain();
                            rains[n].init();
                        }
                    }
                    console.log(rainNowCount)
                }
                requestAnimationFrame(animation);
             }

            animation();
        }
    }


    Canvas{
        id: star
        width: 100
        height: 100
        opacity: 0
        onPaint: {
            var ctx = getContext("2d");
            var half = star.width/2;
            var grd = ctx.createRadialGradient(half, half, 0, half, half, half);
            // 偏白色调
            grd.addColorStop(0.15, '#CCC');
            grd.addColorStop(0.5, 'hsl(230, 61%, 33%)');
            grd.addColorStop(0.6, 'hsl(230, 64%, 6%)');
            grd.addColorStop(1, 'transparent');
            ctx.fillStyle = grd;
            ctx.beginPath();
            ctx.arc(half, half, half, 0, Math.PI*2);
            ctx.fill();
            ctx.globalAlpha = 0;
        }
    }

}
