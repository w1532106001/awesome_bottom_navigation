import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AwesomeBottomNavigationState {
  var selectIndex = 0.obs;
  var showPoint = false.obs;
  var startOff = const Offset(0, 0).obs;
  var endOff = const Offset(0, 0).obs;
  var animValue = 0.0.obs;
  var touchIndex = 0.obs;
  var startIndex = 1.obs;
  var topAnimValues = <double>[0.0,0.0,0.0].obs;

  AwesomeBottomNavigationState() {
    ///Initialize variables
  }
}
