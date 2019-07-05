/*********************************************************
  光电控制台的传输协议

c++ 验证程序:
    char SendBuffer[8];
    SendBuffer[0] = 0xA0;
    SendBuffer[1] = 0x03;
    SendBuffer[2] = 0x00;
    SendBuffer[3] = 0x01;
    SendBuffer[4] = -30;
    SendBuffer[5] = 0x00;
    SendBuffer[6] = 0xAF;
    SendBuffer[7] = SendBuffer[1] ^ SendBuffer[2] ^ SendBuffer[3] ^ SendBuffer[4] ^ SendBuffer[5];

    printf("%x\n", SendBuffer[4]);

 转到光电下危机的时候，用的是python，传递方法为
 senddata = bytes([0xA0, 0x03, 0x00, 0x01, 0xE2, 0x00, 0xAF, 0xE0])

 其中-30 通过 printf("%x\n", SendBuffer[4]) 得其十六进制为0xE2
*********************************************************/

// 将int类型转成十六进制字符串，如果为1位如2，则补零，即改成02
function intToHex(num){
   var str = num.toString(16);
   if (str.length < 2) str = '0' + str;
   return str;
}



/*************************白光控制***************************************/

// 放大
function whiteLightControl_row1column1() {
    var SendBuffer = new Array;
    SendBuffer[0] = "A0";
    SendBuffer[1] = 0x01;
    SendBuffer[2] = 0x00;
    SendBuffer[3] = 0x01;
    SendBuffer[4] = 0x00;
    SendBuffer[5] = 0x01;
    SendBuffer[6] = "AF";
    SendBuffer[7] = SendBuffer[1] ^ SendBuffer[2] ^ SendBuffer[3] ^ SendBuffer[4] ^ SendBuffer[5];

    SendBuffer[1] = "01";
    SendBuffer[2] = "00";
    SendBuffer[3] = "01";
    SendBuffer[4] = "00";
    SendBuffer[5] = "01";
    SendBuffer[7] = intToHex(Number(SendBuffer[7]));

    photoElectric.sendMsg = "7 " + SendBuffer.toString("");
    photoElectric.getSendMsg();
}

// 手动调焦
function whiteLightControl_row1column2() {
    var SendBuffer = new Array;
    SendBuffer[0] = "A0";
    SendBuffer[1] = 0x01;
    SendBuffer[2] = 0x00;
    SendBuffer[3] = 0x02;
    SendBuffer[4] = 0x01;
    SendBuffer[5] = 0x00;
    SendBuffer[6] = "AF";
    SendBuffer[7] = SendBuffer[1] ^ SendBuffer[2] ^ SendBuffer[3] ^ SendBuffer[4] ^ SendBuffer[5];

    SendBuffer[1] = "01";
    SendBuffer[2] = "00";
    SendBuffer[3] = "02";
    SendBuffer[4] = "01";
    SendBuffer[5] = "00";
    SendBuffer[7] = intToHex(Number(SendBuffer[7]));

    photoElectric.sendMsg = "7 " + SendBuffer.toString("");
    photoElectric.getSendMsg();
}

// 缩小
function whiteLightControl_row2column1() {
    var SendBuffer = new Array;
    SendBuffer[0] = "A0";
    SendBuffer[1] = 0x01;
    SendBuffer[2] = 0x00;
    SendBuffer[3] = 0x01;
    SendBuffer[4] = 0x00;
    SendBuffer[5] = 0x02;
    SendBuffer[6] = "AF";
    SendBuffer[7] = SendBuffer[1] ^ SendBuffer[2] ^ SendBuffer[3] ^ SendBuffer[4] ^ SendBuffer[5];

    SendBuffer[1] = "01";
    SendBuffer[2] = "00";
    SendBuffer[3] = "01";
    SendBuffer[4] = "00";
    SendBuffer[5] = "02";
    SendBuffer[7] = intToHex(Number(SendBuffer[7]));

    photoElectric.sendMsg = "7 " + SendBuffer.toString("");
    photoElectric.getSendMsg();
}

// 自动调焦
function whiteLightControl_row2column2() {
    var SendBuffer = new Array;
    SendBuffer[0] = "A0";
    SendBuffer[1] = 0x01;
    SendBuffer[2] = 0x00;
    SendBuffer[3] = 0x02;
    SendBuffer[4] = 0x02;
    SendBuffer[5] = 0x00;
    SendBuffer[6] = "AF";
    SendBuffer[7] = SendBuffer[1] ^ SendBuffer[2] ^ SendBuffer[3] ^ SendBuffer[4] ^ SendBuffer[5];

    SendBuffer[1] = "01";
    SendBuffer[2] = "00";
    SendBuffer[3] = "02";
    SendBuffer[4] = "02";
    SendBuffer[5] = "00";
    SendBuffer[7] = intToHex(Number(SendBuffer[7]));

    photoElectric.sendMsg = "7 " + SendBuffer.toString("");
    photoElectric.getSendMsg();
}

// 停止
function whiteLightControl_row3column1() {
    var SendBuffer = new Array;
    SendBuffer[0] = "A0";
    SendBuffer[1] = 0x01;
    SendBuffer[2] = 0x00;
    SendBuffer[3] = 0x01;
    SendBuffer[4] = 0x00;
    SendBuffer[5] = 0x00;
    SendBuffer[6] = "AF";
    SendBuffer[7] = SendBuffer[1] ^ SendBuffer[2] ^ SendBuffer[3] ^ SendBuffer[4] ^ SendBuffer[5];

    SendBuffer[1] = "01";
    SendBuffer[2] = "00";
    SendBuffer[3] = "01";
    SendBuffer[4] = "00";
    SendBuffer[5] = "00";
    SendBuffer[7] = intToHex(Number(SendBuffer[7]));

    photoElectric.sendMsg = "7 " + SendBuffer.toString("");
    photoElectric.getSendMsg();
}

// 变倍
function whiteLightControl_row3column2() {
    var times = Number(photoElectric.whiteLightControl_textInput1.text);
    times = parseInt(times*100);
    var nZoom1 = parseInt(times/256);
    var nZoom2 = parseInt(times%256);

    var SendBuffer_4 = nZoom1.toString(16);
    var SendBuffer_5 = nZoom2.toString(16);

    var SendBuffer = new Array;
    SendBuffer[0] = "A0";
    SendBuffer[1] = 0x01;
    SendBuffer[2] = 0x00;
    SendBuffer[3] = 0x03;
    SendBuffer[4] = SendBuffer_4;
    SendBuffer[5] = SendBuffer_5;
    SendBuffer[6] = "AF";
    SendBuffer[7] = SendBuffer[1] ^ SendBuffer[2] ^ SendBuffer[3] ^ SendBuffer[4] ^ SendBuffer[5];

    SendBuffer[1] = "01";
    SendBuffer[2] = "00";
    SendBuffer[3] = "03";
    SendBuffer[4] = intToHex(nZoom1 );
    SendBuffer[5] = intToHex(nZoom2 );
    SendBuffer[7] = intToHex(Number(SendBuffer[7]) );

    photoElectric.sendMsg = "7 " + SendBuffer.toString("");
    photoElectric.getSendMsg();

}

/*************************跟踪测试***************************************/
// 白光中心跟踪
function trackTest_row1column1() {
    var SendBuffer = new Array;
    SendBuffer[0] = "A0";
    SendBuffer[1] = 0x03;
    SendBuffer[2] = 0x00;
    SendBuffer[3] = 0x08;
    SendBuffer[4] = 0x00;
    SendBuffer[5] = 0x00;
    SendBuffer[6] = "AF";

    SendBuffer[7] = SendBuffer[1] ^ SendBuffer[2] ^ SendBuffer[3] ^ SendBuffer[4] ^ SendBuffer[5];

    SendBuffer[1] = "03";
    SendBuffer[2] = "00";
    SendBuffer[3] = "08";
    SendBuffer[4] = "00";
    SendBuffer[5] = "00";
    SendBuffer[7] = intToHex(Number(SendBuffer[7]));

    photoElectric.sendMsg = "7 " + SendBuffer.toString("");
    photoElectric.getSendMsg();
}

// 白光坐标跟踪
function trackTest_row1column2() {
    var strx = photoElectric.trackTest_textInput1.text.split(',')[0];
    var stry = photoElectric.trackTest_textInput1.text.split(',')[1];
    var nx = parseInt(strx);
    var ny = parseInt(stry);

    var SendBuffer_4 = parseInt(nx/256).toString(16);
    var SendBuffer_5 = parseInt(nx%256).toString(16);
    var SendBuffer_6 = parseInt(ny/256).toString(16);
    var SendBuffer_7 = parseInt(ny%256).toString(16);


    var SendBuffer = new Array;
    SendBuffer[0] = "A0";
    SendBuffer[1] = 0x01;
    SendBuffer[2] = 0x00;
    SendBuffer[3] = 0x03;
    SendBuffer[4] = SendBuffer_4;
    SendBuffer[5] = SendBuffer_5;
    SendBuffer[6] = SendBuffer_6;
    SendBuffer[7] = SendBuffer_7;
    SendBuffer[8] = "AF";
    SendBuffer[9] = SendBuffer[1] ^ SendBuffer[2] ^ SendBuffer[3] ^ SendBuffer[4] ^ SendBuffer[5]
                        ^ SendBuffer[6] ^ SendBuffer[7];

    SendBuffer[1] = "01";
    SendBuffer[2] = "00";
    SendBuffer[3] = "03";
    SendBuffer[4] = intToHex(parseInt(nx/256, 10) );
    SendBuffer[5] = intToHex(parseInt(nx%256, 10) );
    SendBuffer[6] = intToHex(parseInt(ny/256, 10) );
    SendBuffer[7] = intToHex(parseInt(ny%256, 10) );
    SendBuffer[9] = intToHex(Number(SendBuffer[9]) );

    photoElectric.sendMsg = "7 " + SendBuffer.toString("");
    photoElectric.getSendMsg();
}

// 红外中心跟踪
function trackTest_row2column1() {
    var SendBuffer = new Array;
    SendBuffer[0] = "A0";
    SendBuffer[1] = 0x03;
    SendBuffer[2] = 0x00;
    SendBuffer[3] = 0x09;
    SendBuffer[4] = 0x00;
    SendBuffer[5] = 0x00;
    SendBuffer[6] = "AF";
    SendBuffer[7] = SendBuffer[1] ^ SendBuffer[2] ^ SendBuffer[3] ^ SendBuffer[4] ^ SendBuffer[5];

    SendBuffer[1] = "03";
    SendBuffer[2] = "00";
    SendBuffer[3] = "09";
    SendBuffer[4] = "00";
    SendBuffer[5] = "00";
    SendBuffer[7] = intToHex(Number(SendBuffer[7]));

    photoElectric.sendMsg = "7 " + SendBuffer.toString("");
    photoElectric.getSendMsg();
}

// 红外坐标跟踪
function trackTest_row2column2() {
    var strx = Number(photoElectric.trackTest_textInput1.text.split(',')[0]);
    var stry = Number(photoElectric.trackTest_textInput1.text.split(',')[1]);
    var nx = parseInt(strx);
    var ny = parseInt(stry);

    var SendBuffer_4 = parseInt(nx/256).toString(16);
    var SendBuffer_5 = parseInt(nx%256).toString(16);
    var SendBuffer_6 = parseInt(ny/256).toString(16);
    var SendBuffer_7 = parseInt(ny%256).toString(16);


    var SendBuffer = new Array;
    SendBuffer[0] = "A0";
    SendBuffer[1] = 0x01;
    SendBuffer[2] = 0x00;
    SendBuffer[3] = 0x05;
    SendBuffer[4] = SendBuffer_4;
    SendBuffer[5] = SendBuffer_5;
    SendBuffer[6] = SendBuffer_6;
    SendBuffer[7] = SendBuffer_7;
    SendBuffer[8] = "AF";
    SendBuffer[9] = SendBuffer[1] ^ SendBuffer[2] ^ SendBuffer[3] ^ SendBuffer[4] ^ SendBuffer[5]
                        ^ SendBuffer[6] ^ SendBuffer[7];

    SendBuffer[1] = "01";
    SendBuffer[2] = "00";
    SendBuffer[3] = "05";
    SendBuffer[4] = intToHex(parseInt(nx/256, 10) );
    SendBuffer[5] = intToHex(parseInt(nx%256, 10) );
    SendBuffer[6] = intToHex(parseInt(ny/256, 10) );
    SendBuffer[7] = intToHex(parseInt(ny%256, 10) );
    SendBuffer[9] = intToHex(Number(SendBuffer[9]) );

    photoElectric.sendMsg = "7 " + SendBuffer.toString("");
    photoElectric.getSendMsg();
}

// 停止跟踪
function trackTest_row2column3() {
    var SendBuffer = new Array;
    SendBuffer[0] = "A0";
    SendBuffer[1] = 0x03;
    SendBuffer[2] = 0x00;
    SendBuffer[3] = 0x0A;
    SendBuffer[4] = 0x00;
    SendBuffer[5] = 0x00;
    SendBuffer[6] = "AF";
    SendBuffer[7] = SendBuffer[1] ^ SendBuffer[2] ^ SendBuffer[3] ^ SendBuffer[4] ^ SendBuffer[5];

    SendBuffer[1] = "03";
    SendBuffer[2] = "00";
    SendBuffer[3] = "0A";
    SendBuffer[4] = "00";
    SendBuffer[5] = "00";
    SendBuffer[7] = intToHex(Number(SendBuffer[7]));

    photoElectric.sendMsg = "7 " + SendBuffer.toString("");
    photoElectric.getSendMsg();
}

// 白光跟踪尺寸
function trackTest_row3column1() {
    var nx = Number(photoElectric.trackTest_textInput2.text);
    var nZoom1 = parseInt(nx/256);
    var nZoom2 = parseInt(nx%256);

    var SendBuffer_4 = nZoom1.toString(16);
    var SendBuffer_5 = nZoom2.toString(16);

    var SendBuffer = new Array;
    SendBuffer[0] = "A0";
    SendBuffer[1] = 0x03;
    SendBuffer[2] = 0x00;
    SendBuffer[3] = 0x06;
    SendBuffer[4] = SendBuffer_4;
    SendBuffer[5] = SendBuffer_5;
    SendBuffer[6] = "AF";
    SendBuffer[7] = SendBuffer[1] ^ SendBuffer[2] ^ SendBuffer[3] ^ SendBuffer[4] ^ SendBuffer[5];

    SendBuffer[1] = "03";
    SendBuffer[2] = "00";
    SendBuffer[3] = "06";
    SendBuffer[4] = intToHex(nZoom1);
    SendBuffer[5] = intToHex(nZoom2);
    SendBuffer[7] = intToHex(Number(SendBuffer[7]) );

    photoElectric.sendMsg = "7 " + SendBuffer.toString("");
    photoElectric.getSendMsg();
}

// 红外跟踪尺寸
function trackTest_row3column2() {
    var nx = Number(photoElectric.trackTest_textInput2.text);
    var nZoom1 = parseInt(nx/256);
    var nZoom2 = parseInt(nx%256);

    var SendBuffer_4 = nZoom1.toString(16);
    var SendBuffer_5 = nZoom2.toString(16);

    var SendBuffer = new Array;
    SendBuffer[0] = "A0";
    SendBuffer[1] = 0x03;
    SendBuffer[2] = 0x00;
    SendBuffer[3] = 0x07;
    SendBuffer[4] = SendBuffer_4;
    SendBuffer[5] = SendBuffer_5;
    SendBuffer[6] = "AF";
    SendBuffer[7] = SendBuffer[1] ^ SendBuffer[2] ^ SendBuffer[3] ^ SendBuffer[4] ^ SendBuffer[5];

    SendBuffer[1] = "03";
    SendBuffer[2] = "00";
    SendBuffer[3] = "07";
    SendBuffer[4] = intToHex(nZoom1);
    SendBuffer[5] = intToHex(nZoom2);
    SendBuffer[7] = intToHex(Number(SendBuffer[7]) );

    photoElectric.sendMsg = "7 " + SendBuffer.toString("");
    photoElectric.getSendMsg();
}

// 白光跟踪参数
function trackTest_row4column1() {
    var nx = Number(photoElectric.trackTest_textInput3.text);
    var nZoom1 = parseInt(nx/256);
    var nZoom2 = parseInt(nx%256);

    var SendBuffer_4 = nZoom1.toString(16);
    var SendBuffer_5 = nZoom2.toString(16);

    var SendBuffer = new Array;
    SendBuffer[0] = "A0";
    SendBuffer[1] = 0x03;
    SendBuffer[2] = 0x00;
    SendBuffer[3] = 0x12;
    SendBuffer[4] = SendBuffer_4;
    SendBuffer[5] = SendBuffer_5;
    SendBuffer[6] = "AF";
    SendBuffer[7] = SendBuffer[1] ^ SendBuffer[2] ^ SendBuffer[3] ^ SendBuffer[4] ^ SendBuffer[5];

    SendBuffer[1] = "03";
    SendBuffer[2] = "00";
    SendBuffer[3] = "12";
    SendBuffer[4] = intToHex(nZoom1);
    SendBuffer[5] = intToHex(nZoom2);
    SendBuffer[7] = intToHex(Number(SendBuffer[7]) );

    photoElectric.sendMsg = "7 " + SendBuffer.toString("");
    photoElectric.getSendMsg();
}

// 红外跟踪参数
function trackTest_row4column2() {
    var nx = Number(photoElectric.trackTest_textInput3.text);
    var nZoom1 = parseInt(nx/256);
    var nZoom2 = parseInt(nx%256);

    var SendBuffer_4 = nZoom1.toString(16);
    var SendBuffer_5 = nZoom2.toString(16);

    var SendBuffer = new Array;
    SendBuffer[0] = "A0";
    SendBuffer[1] = 0x03;
    SendBuffer[2] = 0x00;
    SendBuffer[3] = 0x13;
    SendBuffer[4] = SendBuffer_4;
    SendBuffer[5] = SendBuffer_5;
    SendBuffer[6] = "AF";
    SendBuffer[7] = SendBuffer[1] ^ SendBuffer[2] ^ SendBuffer[3] ^ SendBuffer[4] ^ SendBuffer[5];

    SendBuffer[1] = "03";
    SendBuffer[2] = "00";
    SendBuffer[3] = "13";
    SendBuffer[4] = intToHex(nZoom1);
    SendBuffer[5] = intToHex(nZoom2);
    SendBuffer[7] = intToHex(Number(SendBuffer[7]) );

    photoElectric.sendMsg = "7 " + SendBuffer.toString("");
    photoElectric.getSendMsg();
}

// 跟踪信息查询
function trackTest_row5column1() {
    var SendBuffer = new Array;
    SendBuffer[0] = "A0";
    SendBuffer[1] = 0x03;
    SendBuffer[2] = 0x00;
    SendBuffer[3] = 0x14;
    SendBuffer[4] = 0x00;
    SendBuffer[5] = 0x00;
    SendBuffer[6] = "AF";
    SendBuffer[7] = SendBuffer[1] ^ SendBuffer[2] ^ SendBuffer[3] ^ SendBuffer[4] ^ SendBuffer[5];

    SendBuffer[1] = "03";
    SendBuffer[2] = "00";
    SendBuffer[3] = "14";
    SendBuffer[4] = "00";
    SendBuffer[5] = "00";
    SendBuffer[7] = intToHex(Number(SendBuffer[7]));

    photoElectric.sendMsg = "7 " + SendBuffer.toString("");
    photoElectric.getSendMsg();
}

// 跟踪特性 打开
function trackTest_row5column2_open () {
    var SendBuffer = new Array;
    SendBuffer[0] = "A0";
    SendBuffer[1] = 0x03;
    SendBuffer[2] = 0x00;
    SendBuffer[3] = 0x0C;
    SendBuffer[4] = 0x00;
    SendBuffer[5] = 0x01;
    SendBuffer[6] = "AF";
    SendBuffer[7] = SendBuffer[1] ^ SendBuffer[2] ^ SendBuffer[3] ^ SendBuffer[4] ^ SendBuffer[5];

    SendBuffer[1] = "03";
    SendBuffer[2] = "00";
    SendBuffer[3] = "0C";
    SendBuffer[4] = "00";
    SendBuffer[5] = "01";
    SendBuffer[7] = intToHex(Number(SendBuffer[7]));

    photoElectric.sendMsg = "7 " + SendBuffer.toString("");
    photoElectric.getSendMsg();
}

// 跟踪特性 关闭
function trackTest_row5column2_close(){
    var SendBuffer = new Array;
    SendBuffer[0] = "A0";
    SendBuffer[1] = 0x03;
    SendBuffer[2] = 0x00;
    SendBuffer[3] = 0x0C;
    SendBuffer[4] = 0x00;
    SendBuffer[5] = 0x00;
    SendBuffer[6] = "AF";
    SendBuffer[7] = SendBuffer[1] ^ SendBuffer[2] ^ SendBuffer[3] ^ SendBuffer[4] ^ SendBuffer[5];

    SendBuffer[1] = "03";
    SendBuffer[2] = "00";
    SendBuffer[3] = "0C";
    SendBuffer[4] = "00";
    SendBuffer[5] = "00";
    SendBuffer[7] = intToHex(Number(SendBuffer[7]));

    photoElectric.sendMsg = "7 " + SendBuffer.toString("");
    photoElectric.getSendMsg();
}


/***************************稳台控制************************************/
// 上
function stabilityControl_top() {
    var SendBuffer = new Array;
    SendBuffer[0] = "A0";
    SendBuffer[1] = 0x03;
    SendBuffer[2] = 0x00;
    SendBuffer[3] = 0x01;
    SendBuffer[4] = 0x00;
    SendBuffer[5] = 0xE2;  // int: -30
    SendBuffer[6] = "AF";
    SendBuffer[7] = SendBuffer[1] ^ SendBuffer[2] ^ SendBuffer[3] ^ SendBuffer[4] ^ SendBuffer[5];

    SendBuffer[1] = "03";
    SendBuffer[2] = "00";
    SendBuffer[3] = "01";
    SendBuffer[4] = "00";
    SendBuffer[5] = "E2";  // int: -30
    SendBuffer[7] = intToHex(Number(SendBuffer[7]));

    photoElectric.sendMsg = "7 " + SendBuffer.toString("");
    photoElectric.getSendMsg();
}

// 左
function stabilityControl_left() {
    var SendBuffer = new Array;
    SendBuffer[0] = "A0";
    SendBuffer[1] = 0x03;
    SendBuffer[2] = 0x00;
    SendBuffer[3] = 0x01;
    SendBuffer[4] = 0x1E; // int: 30
    SendBuffer[5] = 0x00;
    SendBuffer[6] = "AF";
    SendBuffer[7] = SendBuffer[1] ^ SendBuffer[2] ^ SendBuffer[3] ^ SendBuffer[4] ^ SendBuffer[5];

    SendBuffer[1] = "03";
    SendBuffer[2] = "00";
    SendBuffer[3] = "01";
    SendBuffer[4] = "1E";
    SendBuffer[5] = "00";
    SendBuffer[7] = intToHex(Number(SendBuffer[7]));

    photoElectric.sendMsg = "7 " + SendBuffer.toString("");
    photoElectric.getSendMsg();
}

// 停
function stabilityControl_stop() {
    var SendBuffer = new Array;
    SendBuffer[0] = "A0";
    SendBuffer[1] = 0x03;
    SendBuffer[2] = 0x00;
    SendBuffer[3] = 0x01;
    SendBuffer[4] = 0x00;
    SendBuffer[5] = 0x00;
    SendBuffer[6] = "AF";
    SendBuffer[7] = SendBuffer[1] ^ SendBuffer[2] ^ SendBuffer[3] ^ SendBuffer[4] ^ SendBuffer[5];

    SendBuffer[1] = "03";
    SendBuffer[2] = "00";
    SendBuffer[3] = "01";
    SendBuffer[4] = "00";
    SendBuffer[5] = "00";
    SendBuffer[7] = intToHex(Number(SendBuffer[7]));

    photoElectric.sendMsg = "7 " + SendBuffer.toString("");
    photoElectric.getSendMsg();
}

// 右
function stabilityControl_right() {
    var SendBuffer = new Array;
    SendBuffer[0] = "A0";
    SendBuffer[1] = 0x03;
    SendBuffer[2] = 0x00;
    SendBuffer[3] = 0x01;
    SendBuffer[4] = 0xE2;
    SendBuffer[5] = 0x00;
    SendBuffer[6] = "AF";
    SendBuffer[7] = SendBuffer[1] ^ SendBuffer[2] ^ SendBuffer[3] ^ SendBuffer[4] ^ SendBuffer[5];

    SendBuffer[1] = "03";
    SendBuffer[2] = "00";
    SendBuffer[3] = "01";
    SendBuffer[4] = "E2";
    SendBuffer[5] = "00";
    SendBuffer[7] = intToHex(Number(SendBuffer[7]));

    photoElectric.sendMsg = "7 " + SendBuffer.toString("");
    photoElectric.getSendMsg();
}

// 下
function stabilityControl_down() {
    var SendBuffer = new Array;
    SendBuffer[0] = "A0";
    SendBuffer[1] = 0x03;
    SendBuffer[2] = 0x00;
    SendBuffer[3] = 0x01;
    SendBuffer[4] = 0x00;
    SendBuffer[5] = 0x1E;
    SendBuffer[6] = "AF";
    SendBuffer[7] = SendBuffer[1] ^ SendBuffer[2] ^ SendBuffer[3] ^ SendBuffer[4] ^ SendBuffer[5];

    SendBuffer[1] = "03";
    SendBuffer[2] = "00";
    SendBuffer[3] = "01";
    SendBuffer[4] = "00";
    SendBuffer[5] = "1E";
    SendBuffer[7] = intToHex(Number(SendBuffer[7]));

    photoElectric.sendMsg = "7 " + SendBuffer.toString("");
    photoElectric.getSendMsg();
}

// 两轴稳像
function stabilityControl_row1column1() {
    var SendBuffer = new Array;
    SendBuffer[0] = "A0";
    SendBuffer[1] = 0x03;
    SendBuffer[2] = 0x00;
    SendBuffer[3] = 0x02;
    SendBuffer[4] = 0x00;
    SendBuffer[5] = 0x00;
    SendBuffer[6] = "AF";
    SendBuffer[7] = SendBuffer[1] ^ SendBuffer[2] ^ SendBuffer[3] ^ SendBuffer[4] ^ SendBuffer[5];

    SendBuffer[1] = "03";
    SendBuffer[2] = "00";
    SendBuffer[3] = "02";
    SendBuffer[4] = "00";
    SendBuffer[5] = "00";
    SendBuffer[7] = intToHex(Number(SendBuffer[7]));

    photoElectric.sendMsg = "7 " + SendBuffer.toString("");
    photoElectric.getSendMsg();
}

// 水平稳像
function stabilityControl_row1column2() {
    var SendBuffer = new Array;
    SendBuffer[0] = "A0";
    SendBuffer[1] = 0x03;
    SendBuffer[2] = 0x00;
    SendBuffer[3] = 0x02;
    SendBuffer[4] = 0x00;
    SendBuffer[5] = 0x01;
    SendBuffer[6] = "AF";
    SendBuffer[7] = SendBuffer[1] ^ SendBuffer[2] ^ SendBuffer[3] ^ SendBuffer[4] ^ SendBuffer[5];

    SendBuffer[1] = "03";
    SendBuffer[2] = "00";
    SendBuffer[3] = "02";
    SendBuffer[4] = "00";
    SendBuffer[5] = "01";
    SendBuffer[7] = intToHex(Number(SendBuffer[7]));

    photoElectric.sendMsg = "7 " + SendBuffer.toString("");
    photoElectric.getSendMsg();
}

// 俯仰稳像
function stabilityControl_row1column3() {
    var SendBuffer = new Array;
    SendBuffer[0] = "A0";
    SendBuffer[1] = 0x03;
    SendBuffer[2] = 0x00;
    SendBuffer[3] = 0x02;
    SendBuffer[4] = 0x00;
    SendBuffer[5] = 0x02;
    SendBuffer[6] = "AF";
    SendBuffer[7] = SendBuffer[1] ^ SendBuffer[2] ^ SendBuffer[3] ^ SendBuffer[4] ^ SendBuffer[5];

    SendBuffer[1] = "03";
    SendBuffer[2] = "00";
    SendBuffer[3] = "02";
    SendBuffer[4] = "00";
    SendBuffer[5] = "02";
    SendBuffer[7] = intToHex(Number(SendBuffer[7]));

    photoElectric.sendMsg = "7 " + SendBuffer.toString("");
    photoElectric.getSendMsg();
}

// 释放
function stabilityControl_row2column1() {
    var SendBuffer = new Array;
    SendBuffer[0] = "A0";
    SendBuffer[1] = 0x03;
    SendBuffer[2] = 0x00;
    SendBuffer[3] = 0x03;
    SendBuffer[4] = 0x00;
    SendBuffer[5] = 0x00;
    SendBuffer[6] = "AF";
    SendBuffer[7] = SendBuffer[1] ^ SendBuffer[2] ^ SendBuffer[3] ^ SendBuffer[4] ^ SendBuffer[5];

    SendBuffer[1] = "03";
    SendBuffer[2] = "00";
    SendBuffer[3] = "03";
    SendBuffer[4] = "00";
    SendBuffer[5] = "00";
    SendBuffer[7] = intToHex(Number(SendBuffer[7]));

    photoElectric.sendMsg = "7 " + SendBuffer.toString("");
    photoElectric.getSendMsg();
}

// 展开
function stabilityControl_row2column2() {
    var SendBuffer = new Array;
    SendBuffer[0] = "A0";
    SendBuffer[1] = 0x03;
    SendBuffer[2] = 0x00;
    SendBuffer[3] = 0x0D;
    SendBuffer[4] = 0x00;
    SendBuffer[5] = 0x00;
    SendBuffer[6] = "AF";
    SendBuffer[7] = SendBuffer[1] ^ SendBuffer[2] ^ SendBuffer[3] ^ SendBuffer[4] ^ SendBuffer[5];

    SendBuffer[1] = "03";
    SendBuffer[2] = "00";
    SendBuffer[3] = "0D";
    SendBuffer[4] = "00";
    SendBuffer[5] = "00";
    SendBuffer[7] = intToHex(Number(SendBuffer[7]));

    photoElectric.sendMsg = "7 " + SendBuffer.toString("");
    photoElectric.getSendMsg();
}

// 零位设置
function stabilityControl_row2column3() {
    var SendBuffer = new Array;

    // 第一次发送
    SendBuffer[0] = "A0";
    SendBuffer[1] = 0x03;
    SendBuffer[2] = 0x00;
    SendBuffer[3] = 0x0F;
    SendBuffer[4] = 0x00;
    SendBuffer[5] = 0x01;
    SendBuffer[6] = "AF";
    SendBuffer[7] = SendBuffer[1] ^ SendBuffer[2] ^ SendBuffer[3] ^ SendBuffer[4] ^ SendBuffer[5];

    SendBuffer[1] = "03";
    SendBuffer[2] = "00";
    SendBuffer[3] = "0F";
    SendBuffer[4] = "00";
    SendBuffer[5] = "01";
    SendBuffer[7] = intToHex(Number(SendBuffer[7]));

    photoElectric.sendMsg = "7 " + SendBuffer.toString("");
    photoElectric.getSendMsg();

    // 第二次发送
    SendBuffer[0] = "A0";
    SendBuffer[1] = 0x03;
    SendBuffer[2] = 0x00;
    SendBuffer[3] = 0x0F;
    SendBuffer[4] = 0x00;
    SendBuffer[5] = 0x02;
    SendBuffer[6] = "AF";
    SendBuffer[7] = SendBuffer[1] ^ SendBuffer[2] ^ SendBuffer[3] ^ SendBuffer[4] ^ SendBuffer[5];

    SendBuffer[1] = "03";
    SendBuffer[2] = "00";
    SendBuffer[3] = "0F";
    SendBuffer[4] = "00";
    SendBuffer[5] = "02";
    SendBuffer[7] = intToHex(Number(SendBuffer[7]));

    photoElectric.sendMsg = "7 " + SendBuffer.toString("");
    photoElectric.getSendMsg();
}

// 两轴锁定
function stabilityControl_row3column1() {
    var SendBuffer = new Array;
    SendBuffer[0] = "A0";
    SendBuffer[1] = 0x03;
    SendBuffer[2] = 0x00;
    SendBuffer[3] = 0x02;
    SendBuffer[4] = 0x00;
    SendBuffer[5] = 0x03;
    SendBuffer[6] = "AF";
    SendBuffer[7] = SendBuffer[1] ^ SendBuffer[2] ^ SendBuffer[3] ^ SendBuffer[4] ^ SendBuffer[5];

    SendBuffer[1] = "03";
    SendBuffer[2] = "00";
    SendBuffer[3] = "02";
    SendBuffer[4] = "00";
    SendBuffer[5] = "03";
    SendBuffer[7] = intToHex(Number(SendBuffer[7]));

    photoElectric.sendMsg = "7 " + SendBuffer.toString("");
    photoElectric.getSendMsg();
}

// 撤收
function stabilityControl_row3column2() {
    var SendBuffer = new Array;
    SendBuffer[0] = "A0";
    SendBuffer[1] = 0x03;
    SendBuffer[2] = 0x00;
    SendBuffer[3] = 0x0D;
    SendBuffer[4] = 0x00;
    SendBuffer[5] = 0x01;
    SendBuffer[6] = "AF";
    SendBuffer[7] = SendBuffer[1] ^ SendBuffer[2] ^ SendBuffer[3] ^ SendBuffer[4] ^ SendBuffer[5];

    SendBuffer[1] = "03";
    SendBuffer[2] = "00";
    SendBuffer[3] = "0D";
    SendBuffer[4] = "00";
    SendBuffer[5] = "01";
    SendBuffer[7] = intToHex(Number(SendBuffer[7]));

    photoElectric.sendMsg = "7 " + SendBuffer.toString("");
    photoElectric.getSendMsg();
}

// 转到指定角度
function stabilityControl_row3column3() {
    var nFWJ = Number(photoElectric.stabilityControl_textInput1.text );
    nFWJ = parseInt(nFWJ);
    var nFYJ = Number(photoElectric.stabilityControl_textInput2.text );
    nFYJ = parseInt(nFYJ);

    var SendBuffer_4 = (parseInt(nFWJ/256) ).toString(16);
    var SendBuffer_5 = (parseInt(nFWJ%256) ).toString(16);
    var SendBuffer_6 = (parseInt(nFYJ/256) ).toString(16);
    var SendBuffer_7 = (parseInt(nFYJ%256) ).toString(16);

    var SendBuffer = new Array;
    SendBuffer[0] = "A0";
    SendBuffer[1] = 0x03;
    SendBuffer[2] = 0x00;
    SendBuffer[3] = 0x0E;
    SendBuffer[4] = SendBuffer_4;
    SendBuffer[5] = SendBuffer_5;
    SendBuffer[6] = SendBuffer_6;
    SendBuffer[7] = SendBuffer_7;
    SendBuffer[8] = "AF";
    SendBuffer[9] = SendBuffer[1] ^ SendBuffer[2] ^ SendBuffer[3] ^ SendBuffer[4] ^ SendBuffer[5]
                        ^ SendBuffer[6] ^ SendBuffer[7];

    SendBuffer[1] = "03";
    SendBuffer[2] = "00";
    SendBuffer[3] = "0E";
    SendBuffer[4] = intToHex(parseInt(nFWJ/256, 10) );
    SendBuffer[5] = intToHex(parseInt(nFWJ%256, 10) );
    SendBuffer[6] = intToHex(parseInt(nFYJ/256, 10) );
    SendBuffer[7] = intToHex(parseInt(nFYJ%256, 10) );
    SendBuffer[9] = intToHex(Number(SendBuffer[9]) );



    photoElectric.sendMsg = "7 " + SendBuffer.toString("");
    photoElectric.getSendMsg();
}

/***************************红外控制************************************/
// 调焦+
function infraredControl_row1column1() {
    var SendBuffer = new Array;
    SendBuffer[0] = "A0";
    SendBuffer[1] = 0x02;
    SendBuffer[2] = 0x00;
    SendBuffer[3] = 0x01;
    SendBuffer[4] = 0x00;
    SendBuffer[5] = 0x01;
    SendBuffer[6] = "AF";
    SendBuffer[7] = SendBuffer[1] ^ SendBuffer[2] ^ SendBuffer[3] ^ SendBuffer[4] ^ SendBuffer[5];

    SendBuffer[1] = "02";
    SendBuffer[2] = "00";
    SendBuffer[3] = "01";
    SendBuffer[4] = "00";
    SendBuffer[5] = "01";
    SendBuffer[7] = intToHex(Number(SendBuffer[7]));

    photoElectric.sendMsg = "7 " + SendBuffer.toString("");
    photoElectric.getSendMsg();
}

// 调焦-
function infraredControl_row1column2() {
    var SendBuffer = new Array;
    SendBuffer[0] = "A0";
    SendBuffer[1] = 0x02;
    SendBuffer[2] = 0x00;
    SendBuffer[3] = 0x01;
    SendBuffer[4] = 0x00;
    SendBuffer[5] = 0x02;
    SendBuffer[6] = "AF";
    SendBuffer[7] = SendBuffer[1] ^ SendBuffer[2] ^ SendBuffer[3] ^ SendBuffer[4] ^ SendBuffer[5];

    SendBuffer[1] = "02";
    SendBuffer[2] = "00";
    SendBuffer[3] = "01";
    SendBuffer[4] = "00";
    SendBuffer[5] = "02";
    SendBuffer[7] = intToHex(Number(SendBuffer[7]));

    photoElectric.sendMsg = "7 " + SendBuffer.toString("");
    photoElectric.getSendMsg();
}

// 调焦停止
function infraredControl_row1column3() {
    var SendBuffer = new Array;
    SendBuffer[0] = "A0";
    SendBuffer[1] = 0x02;
    SendBuffer[2] = 0x00;
    SendBuffer[3] = 0x01;
    SendBuffer[4] = 0x00;
    SendBuffer[5] = 0x00;
    SendBuffer[6] = "AF";
    SendBuffer[7] = SendBuffer[1] ^ SendBuffer[2] ^ SendBuffer[3] ^ SendBuffer[4] ^ SendBuffer[5];

    SendBuffer[1] = "02";
    SendBuffer[2] = "00";
    SendBuffer[3] = "01";
    SendBuffer[4] = "00";
    SendBuffer[5] = "00";
    SendBuffer[7] = intToHex(Number(SendBuffer[7]));

    photoElectric.sendMsg = "7 " + SendBuffer.toString("");
    photoElectric.getSendMsg();
}

// 自动调焦
function infraredControl_row1column4() {
    var SendBuffer = new Array;
    SendBuffer[0] = "A0";
    SendBuffer[1] = 0x02;
    SendBuffer[2] = 0x00;
    SendBuffer[3] = 0x01;
    SendBuffer[4] = 0x00;
    SendBuffer[5] = 0x03;
    SendBuffer[6] = "AF";
    SendBuffer[7] = SendBuffer[1] ^ SendBuffer[2] ^ SendBuffer[3] ^ SendBuffer[4] ^ SendBuffer[5];

    SendBuffer[1] = "02";
    SendBuffer[2] = "00";
    SendBuffer[3] = "01";
    SendBuffer[4] = "00";
    SendBuffer[5] = "03";
    SendBuffer[7] = intToHex(Number(SendBuffer[7]));

    photoElectric.sendMsg = "7 " + SendBuffer.toString("");
    photoElectric.getSendMsg();
}

// 黑热
function infraredControl_row2column1() {
    var SendBuffer = new Array;
    SendBuffer[0] = "A0";
    SendBuffer[1] = 0x02;
    SendBuffer[2] = 0x00;
    SendBuffer[3] = 0x02;
    SendBuffer[4] = 0x00;
    SendBuffer[5] = 0x00;
    SendBuffer[6] = "AF";
    SendBuffer[7] = SendBuffer[1] ^ SendBuffer[2] ^ SendBuffer[3] ^ SendBuffer[4] ^ SendBuffer[5];

    SendBuffer[1] = "02";
    SendBuffer[2] = "00";
    SendBuffer[3] = "02";
    SendBuffer[4] = "00";
    SendBuffer[5] = "00";
    SendBuffer[7] = intToHex(Number(SendBuffer[7]));

    photoElectric.sendMsg = "7 " + SendBuffer.toString("");
    photoElectric.getSendMsg();
}

// 白热
function infraredControl_row2column2() {
    var SendBuffer = new Array;
    SendBuffer[0] = "A0";
    SendBuffer[1] = 0x02;
    SendBuffer[2] = 0x00;
    SendBuffer[3] = 0x02;
    SendBuffer[4] = 0x00;
    SendBuffer[5] = 0x01;
    SendBuffer[6] = "AF";
    SendBuffer[7] = SendBuffer[1] ^ SendBuffer[2] ^ SendBuffer[3] ^ SendBuffer[4] ^ SendBuffer[5];

    SendBuffer[1] = "02";
    SendBuffer[2] = "00";
    SendBuffer[3] = "02";
    SendBuffer[4] = "00";
    SendBuffer[5] = "01";
    SendBuffer[7] = intToHex(Number(SendBuffer[7]));

    photoElectric.sendMsg = "7 " + SendBuffer.toString("");
    photoElectric.getSendMsg();
}

// 铁锈红
function infraredControl_row2column3() {
    var SendBuffer = new Array;
    SendBuffer[0] = "A0";
    SendBuffer[1] = 0x02;
    SendBuffer[2] = 0x00;
    SendBuffer[3] = 0x02;
    SendBuffer[4] = 0x00;
    SendBuffer[5] = 0x02;
    SendBuffer[6] = "AF";
    SendBuffer[7] = SendBuffer[1] ^ SendBuffer[2] ^ SendBuffer[3] ^ SendBuffer[4] ^ SendBuffer[5];

    SendBuffer[1] = "02";
    SendBuffer[2] = "00";
    SendBuffer[3] = "02";
    SendBuffer[4] = "00";
    SendBuffer[5] = "02";
    SendBuffer[7] = intToHex(Number(SendBuffer[7]));

    photoElectric.sendMsg = "7 " + SendBuffer.toString("");
    photoElectric.getSendMsg();
}

// 彩虹
function infraredControl_row2column4() {
    var SendBuffer = new Array;
    SendBuffer[0] = "A0";
    SendBuffer[1] = 0x02;
    SendBuffer[2] = 0x00;
    SendBuffer[3] = 0x02;
    SendBuffer[4] = 0x00;
    SendBuffer[5] = 0x03;
    SendBuffer[6] = "AF";
    SendBuffer[7] = SendBuffer[1] ^ SendBuffer[2] ^ SendBuffer[3] ^ SendBuffer[4] ^ SendBuffer[5];

    SendBuffer[1] = "02";
    SendBuffer[2] = "00";
    SendBuffer[3] = "02";
    SendBuffer[4] = "00";
    SendBuffer[5] = "03";
    SendBuffer[7] = intToHex(Number(SendBuffer[7]));

    photoElectric.sendMsg = "7 " + SendBuffer.toString("");
    photoElectric.getSendMsg();
}
