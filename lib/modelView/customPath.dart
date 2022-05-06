import 'package:flutter/material.dart';

class customPath extends CustomClipper<Path>{
  late double x1;
  late double y1;
  late double x2;
  late double y2;
  late double x3;
  late double y3;
  late double x4;
  late double y4;
  customPath(this.x1, this.y1, this.x2, this.y2, this.x3, this.y3, this.x4, this.y4);

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(x1*size.width, y1*size.height);
    path.lineTo(x2*size.width, y2*size.height);
    path.quadraticBezierTo(x3*size.width, y3*size.height, x4*size.width, y4*size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }

}