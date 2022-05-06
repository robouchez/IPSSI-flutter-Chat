
import 'package:flutter/material.dart';

import '../model/Message.dart';
import '../model/MyProfil.dart';


class messageBubble extends StatelessWidget{
  Message message;
  MyProfil partenaire;
  String monId;
  Animation? animation;
  messageBubble(
    @required String this.monId,
    @required MyProfil this.partenaire,
    @required Message this.message,
    {Animation? this.animation}
  );

  @override
  Widget build(BuildContext context) {
// TODO: implement build

    return Row(children: widgetBubble(message.from==monId, context),);
  }

  List< Widget> widgetBubble(bool moi, BuildContext context){
    CrossAxisAlignment alignment = (moi) ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    Color colorBubble = (moi) ? Colors.lightGreen : Colors.lightBlue;
    Color textcolor = Colors.white;
    double bottomLeftCorner = (moi) ? 10 : 0;
    double bottomRightCorner = (moi) ? 0 : 10;
    Color leftBorderBubble = (moi) ? Colors.transparent : Colors.blue;
    Color rightBorderBubble = (moi) ? Colors.green : Colors.transparent;

    return <Widget>[
      Expanded(
        child: Column(
          crossAxisAlignment: alignment,
          children: [
            Card(
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(10),
                  topRight: const Radius.circular(10),
                  bottomLeft: Radius.circular(bottomLeftCorner),
                  bottomRight: Radius.circular(bottomRightCorner),
                )
              ),
              color: colorBubble,
              child: ClipPath(
                clipper: const ShapeBorderClipper(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)
                    )
                  )
                ),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(
                        color: leftBorderBubble,
                        width: 10,
                      ),
                      right: BorderSide(
                        color: rightBorderBubble,
                        width: 10,
                      ),
                    ),
                  ),
                  constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width*0.8),
                  padding: EdgeInsets.all(animation?.value ?? 10),
                  child: Text(
                    message.texte,
                    style: TextStyle(
                      color: textcolor,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    ];
  }
}