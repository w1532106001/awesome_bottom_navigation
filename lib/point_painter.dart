import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PointPainter extends CustomPainter{

  final Offset start;
  final Offset end;
  // final double animValue;
  double height = kBottomNavigationBarHeight;
  double maxRadius = 20;
  double minRadius = 0;
  final List<AnimationController> topPointController;
  final List<AnimationController> bottomPointController;

  PointPainter(this.start, this.end, this.topPointController, this.bottomPointController);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = Colors.greenAccent;
    paint.strokeWidth = 10;
    for (int i = 0; i < topPointController.length; i++) {
      print('$i value:${topPointController[i].value}');
      Offset currentOffset = getOffset(topPointController[i].value, false);
      canvas.drawCircle(currentOffset, getRadius(topPointController[i].value), paint);
    }
    for (int i = 0; i < bottomPointController.length; i++) {
      print('$i value:${bottomPointController[i].value}');
      Offset currentOffset = getOffset(bottomPointController[i].value, true);
      canvas.drawCircle(currentOffset, getRadius(bottomPointController[i].value), paint);
    }


  }


  double getRadius(double animValue){
    // var middleRadius = maxRadius-minRadius;
    var time  = animValue;

    return animValue<=0.2?maxRadius*animValue:animValue<=0.8?maxRadius*0.2:maxRadius*(1-animValue);
  }

  //取得位置
  getOffset(double time, bool bottom) {
    double x0 = start.dx;
    double y0 = start.dy;

    double x2 = end.dx;
    double y2 = end.dy;

    double x1 = (start.dx + start.dx) / 2;
    double y1 = bottom ? start.dy * 2 : 0;

    double dx =
        pow(1 - time, 2) * x0 + 2 * time * (1 - time) * x1 + pow(time, 2) * x2;
    double dy =
        pow(1 - time, 2) * y0 + 2 * time * (1 - time) * y1 + pow(time, 2) * y2;
    return Offset(dx, dy);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate)=>true;
  
}