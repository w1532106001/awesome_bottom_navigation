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

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(AwesomeBottomNavigationLogic());
    final state = Get.find<AwesomeBottomNavigationLogic>().state;
    state.selectIndex = defaultIndex.obs;

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20))
      ),
      padding: padding,
      height: kBottomNavigationBarHeight + (padding?.vertical ?? 0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: icons.length,
            mainAxisSpacing: 0,
            crossAxisSpacing: 0,
            childAspectRatio: 3,

        ),
        itemBuilder: (child, index) {
          return Container(
            color: Colors.red,
            alignment: Alignment.center,
            child: GestureDetector(
              child: Obx(() => Icon(
                    state.selectIndex.value == index
                        ? selectIcons[index]
                        : icons[index],
                    color: color,
                    size: 24,
                  )),
              onTap: () {},
            ),
          );
        },
        itemCount: icons.length,
      ),
    );
  }
}
