import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'awesome_bottom_navigation_state.dart';

class AwesomeBottomNavigationLogic extends GetxController
    with GetTickerProviderStateMixin {
  final AwesomeBottomNavigationState state = AwesomeBottomNavigationState();
  late AnimationController animationController;

  var topPointController = <AnimationController>[].obs;
  var bottomPointController = <AnimationController>[].obs;
  var totalTime = 800;

  @override
  void onInit() {
    for (int i = 0; i < 3; i++) {
      var c = AnimationController(
          duration: Duration(milliseconds: totalTime), vsync: this);
      topPointController.add(c);
      c.addListener(() {
        topPointController.refresh();
      });
      c.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          c.reset();
        }
      });
    }
    for (int i = 0; i < 2; i++) {
      var c = AnimationController(
          duration: Duration(milliseconds: totalTime), vsync: this);
      bottomPointController.add(c);
      c.addListener(() {
        bottomPointController.refresh();
      });
      c.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          c.reset();
        }
      });
    }

    for (var element in topPointController) {
      Tween(begin: 0.0, end: 1.0).animate(element);
    }

    animationController = AnimationController(
        duration: Duration(milliseconds: totalTime), vsync: this);
    animationController.addListener(() {
      state.animValue.value = animationController.value;
      print('动画进度:${animationController.value}');
    });
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.reset();
        print('动画完成');
        flightEnd();
      }
    });
  }

  flight() {
    int startIndex = state.selectIndex.value;
    double avg = Get.width / 3;
    state.startOff.value =
        Offset((startIndex * avg + avg / 2), kBottomNavigationBarHeight / 2);
    state.endOff.value = Offset((state.touchIndex.value * avg + avg / 2),
        kBottomNavigationBarHeight / 2);
    print('计算点击点：${state.endOff.value}');
    state.showPoint.value = true;
    animationController.forward();

    for (var i = 0; i < topPointController.length; i++) {
      var element = topPointController[i];
      Future.delayed(Duration(milliseconds: (i + 1) * 100), () {
        element.forward();
      });
    }
    for (var i = 0; i < bottomPointController.length; i++) {
      var element = bottomPointController[i];
      Future.delayed(Duration(milliseconds: (i + 1) * 150), () {
        element.forward();
      });
    }
  }

  flightEnd() {
    state.selectIndex.value = state.touchIndex.value;
    state.showPoint.value = false;
  }

  @override
  void onClose() {
    animationController.dispose();
  }

  double getDx(index) {
    var  dx = 0.0;
    if (state.touchIndex.value > state.startIndex.value) {
      if (state.startIndex.value == index) {
        dx = state.animValue.value*16+16;
      }
      if (state.touchIndex.value == index) {
        dx = state.animValue.value*16;
      }

    } else {
      if (state.startIndex.value == index) {
        dx = 16-state.animValue.value*16;
      }
      if (state.touchIndex.value == index) {
        dx = 32-state.animValue.value*16;
      }

    }

    if(state.selectIndex.value==index&&state.animValue.value==0.0){
      dx = 16;
    }
    return dx;
  }
}
