import 'package:flutter/cupertino.dart';

class IconClipper extends CustomClipper<Rect>{
  IconClipper({
    required this.dx,
    required this.dy,
  });
  final double dx;
  final double dy;
  @override
  getClip(Size size) => Rect.fromCircle(center: Offset(dx,dy), radius: 16);

  @override
  bool shouldReclip(covariant CustomClipper oldClipper)=>true;

}