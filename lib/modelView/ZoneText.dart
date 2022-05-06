import 'package:firstapplicationeisi/Fonctions/FirestoreHelper.dart';
import 'package:firstapplicationeisi/model/MyProfil.dart';
import 'package:firstapplicationeisi/model/MyProfil.dart';
import 'package:firstapplicationeisi/model/MyProfil.dart';
import 'package:firstapplicationeisi/model/MyProfil.dart';
import 'package:flutter/material.dart';

class ZoneText extends StatefulWidget{
  MyProfil partenaire;
  MyProfil moi;
  ZoneText(@required MyProfil this.partenaire,@required MyProfil this.moi);

  @override
  State<StatefulWidget> createState() {
// TODO: implement createState
    return ZoneTextState();
  }
}



class ZoneTextState extends State<ZoneText>{
  final TextEditingController _textEditingController = TextEditingController();


  @override
  Widget build(BuildContext context) {
// TODO: implement build
    return Container(
      color: Colors.grey[300],
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          Flexible(
            child: TextField(
              controller: _textEditingController,
              decoration: const InputDecoration.collapsed(
                hintText: "écrivez votre message",),
              maxLines: null,
            ),
          ),
          IconButton(icon: Icon(Icons.send), onPressed: _sendBouttonpressed)
        ],
      ),
    );
  }

  _sendBouttonpressed(){
    if(_textEditingController.text != ""){
      String text = _textEditingController.text;
      FirestoreHelper().sendMessage(text, widget.partenaire,widget.moi);
      setState(() {
        _textEditingController.text='';
      });
      FocusScope.of(context).requestFocus(new FocusNode());
    }
  }
}