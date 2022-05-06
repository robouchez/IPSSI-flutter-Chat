import 'package:firstapplicationeisi/modelView/customPath.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class fondEcran extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return fondEcranState();
  }

}

class fondEcranState extends State<fondEcran> {
  @override
  Widget build(BuildContext context) {
    return buildFondEcran();
  }

  buildFondEcran() {
    return Stack(
      children: [
        pathLogo(Colors.black12, 0 , 1, 0.7, 1, 0.5, 0.5, 1, 0),
        pathLogo(Colors.black26, 0 , 1, 0.4, 1, 0.5, 0.3, 1, 0),
        pathLogo(Colors.black38, 0 , 1, 0.1, 1, 0.5, 0.2, 1, 0),
      ],
    );
  }

  Widget pathLogo(Color color, double x1, double y1, double x2, double y2, double x3, double y3, double x4, double y4) {
    return ClipPath(
      clipper: customPath(x1, y1, x2, y2, x3, y3, x4, y4),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: color,
      )
    );
  }
}