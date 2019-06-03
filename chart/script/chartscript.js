function originPressPosition(newX, newY){
    originx = newX;
    originy = newY;
}

function finalZoomIn(newX, newY){
    var finalarea = Qt.rect(newX > originx ? originx : newX,
                        newY > originy ? originy : newY,
                        Math.abs(newX - originx),
                        Math.abs(newY - originy));;
    chartView.zoomIn(finalarea);
}

function choiceZoomArea(newX, newY, newWidth, newHeight){
    zoomArea.x = newX;
    zoomArea.y = newY;
    zoomArea.width = newWidth;
    zoomArea.height = newHeight;
}

function wheelZoom(angleDelta){
    if(angleDelta > 0)
        chartView.zoom(1.01);
    else if(angleDelta < 0)
        chartView.zoom(0.99);
}

function flashImage(){
    var newPoint = pathSeries.at(pathSeries.count-1)
    var point_posiont = chartView.mapToPosition(newPoint, pathSeries);
}

function dragScroll(currentX, currentY){
    var move_x = currentX - originx;
    var move_y = currentY - originy;
    move_y *= 0.8;
    move_x *= 0.8;

    if(move_y > 0.2) chartView.scrollUp(Math.abs(move_y));
    else if(move_y < -0.2) chartView.scrollDown(Math.abs(move_y));
    if(move_x > 0.2) chartView.scrollLeft(Math.abs(move_x));
    else if(move_x < -0.2) chartView.scrollRight(Math.abs(move_x));
    originx = currentX; originy = currentY;
}

function groundstationAppend(newX, newY)
{
    originPressPosition(newX, newY); // 忘记当初为什么写了

    var newpoint = chartView.mapToValue(Qt.point(newX, newY))
    targetPointSeries.append(newpoint.x.toFixed(1), newpoint.y.toFixed(1))
    targetLineSeries.append(newpoint.x.toFixed(1), newpoint.y.toFixed(1))
    pointList.targetPointAppend(newpoint.x.toFixed(1), newpoint.y.toFixed(1))
}

function stateTransition(currentState)
{
    if(currentState === "" || currentState === "hovering") return "active";
    else return "";
}


