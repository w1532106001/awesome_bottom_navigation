import 'dart:math';

import 'package:awesome_bottom_navigation/icon_clipper.dart';
import 'package:awesome_bottom_navigation/point_painter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'awesome_bottom_navigation_logic.dart';

class AwesomeBottomNavigationComponent extends StatelessWidget {
  final EdgeInsetsGeometry? padding;
  final List<IconData> icons;
  final List<IconData> selectIcons;
  final Color color;
  final int defaultIndex;

  AwesomeBottomNavigationComponent(this.icons, this.selectIcons,
      {Key? key,
      this.padding,
      this.color = Colors.greenAccent,
      this.defaultIndex = 0})
      : assert(padding == null || padding.isNonNegative),
        assert(icons.isNotEmpty),
        assert(selectIcons.isNotEmpty),
        super(key: key);
  final logic = Get.put(AwesomeBottomNavigationLogic());
  final state = Get.find<AwesomeBottomNavigationLogic>().state;

  @override
  Widget build(BuildContext context) {
    state.selectIndex = defaultIndex.obs;

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      ),
      padding: padding,
      height: kBottomNavigationBarHeight + (padding?.vertical ?? 0),
      child: Stack(
        children: [
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: icons.length,
              mainAxisSpacing: 0,
              crossAxisSpacing: 0,
              childAspectRatio:
                  Get.width / icons.length / kBottomNavigationBarHeight,
            ),
            itemBuilder: (child, index) {
              return Container(
                // color: Colors.red,
                alignment: Alignment.center,
                child: GestureDetector(
                  child: Obx(() => Container(
                        decoration: (state.showPoint.value &&
                                index == state.touchIndex.value)
                            ? BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                border: Border.all(
                                    color: Colors.greenAccent,
                                    width:
                                        max(6 - 8 * state.animValue.value, 0)))
                            : const BoxDecoration(),
                        height: 50,
                        width: 50,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Visibility(
                              child: Icon(
                                icons[index],
                                color: Colors.black,
                                size: state.touchIndex.value == index
                                    ? state.animValue <= 0.5
                                        ? 32 + state.animValue * 8
                                        : 36 - state.animValue * 8
                                    : 32,
                              ),
                              //todo 可见性问题
                              visible: logic.animationController.isAnimating
                                  ? true
                                  : state.selectIndex.value!=index,
                            ),
                            Visibility(
                              child: ClipOval(
                                child: Icon(
                                  selectIcons[index],
                                  color: color,
                                  size: state.touchIndex.value == index
                                      ? state.animValue <= 0.5
                                          ? 32 + state.animValue * 8
                                          : 36 - state.animValue * 8
                                      : 32,
                                ),
                                clipper:
                                    IconClipper(dx: logic.getDx(index), dy: 16),
                              ),
                              visible: state.selectIndex.value == index ||
                                  state.touchIndex.value == index,
                            )
                          ],
                        ),
                      )),
                  onTap: () {
                    if (index != state.selectIndex.value) {
                      state.startIndex.value = state.selectIndex.value;
                      state.touchIndex.value = index;
                      logic.flight();
                      print('index:$index');
                    }
                  },
                  onTapDown: (e) {
                    print('onTapDown:${e.globalPosition}');
                  },
                ),
              );
            },
            itemCount: icons.length,
          ),
          Obx(() => CustomPaint(
                // size: Offset(Get.width,kBottomNavigationBarHeight),
                painter: PointPainter(
                    state.startOff.value,
                    state.endOff.value,
                    logic.topPointController.value,
                    logic.bottomPointController.value),
              ))
        ],
      ),
    );
  }
}
