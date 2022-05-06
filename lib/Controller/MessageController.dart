import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firstapplicationeisi/Fonctions/FirestoreHelper.dart';
import 'package:firstapplicationeisi/model/MyProfil.dart';
import 'package:firstapplicationeisi/model/MyProfil.dart';
import 'package:firstapplicationeisi/model/MyProfil.dart';
import 'package:firstapplicationeisi/model/MyProfil.dart';
import 'package:flutter/material.dart';

import '../model/Message.dart';
import '../modelView/MessageBubble.dart';

class Messagecontroller extends StatefulWidget{
  MyProfil id;
  MyProfil idPartner;
  Messagecontroller(@required MyProfil this.id,@required MyProfil this.idPartner);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MessagecontrollerState();
  }
}

class MessagecontrollerState extends State<Messagecontroller> {
  late Animation animation;
  late AnimationController controller;
  @override

  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirestoreHelper().fire_message.orderBy('envoiMessage',descending:
      true).snapshots(),
      builder: (BuildContext context, AsyncSnapshot <QuerySnapshot>snapshot)
      {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        } else {
          List<DocumentSnapshot> documents = snapshot.data!.docs;

          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (ctx,index) {
              Message discussion = Message(documents[index]);

              if((discussion.from==widget.id.uid && discussion.to==widget.idPartner.uid) ||
                (discussion.from==widget.idPartner.uid && discussion.to==widget.id.uid))
              {
                return messageBubble(widget.id.uid, widget.idPartner, discussion,);
              }
              else
              {
                return Container();
              }
            }
          );
        }
      }
    );
  }
}