import 'package:firstapplicationeisi/Controller/MessageController.dart';
import 'package:firstapplicationeisi/library/lib.dart';
import 'package:firstapplicationeisi/model/MyProfil.dart';
import 'package:firstapplicationeisi/modelView/ZoneText.dart';
import 'package:firstapplicationeisi/modelView/fondEcran.dart';
import 'package:flutter/material.dart';

import '../Fonctions/FirestoreHelper.dart';
import '../main.dart';

class ConversationView extends StatefulWidget {
  late MyProfil partner;
  ConversationView({required this.partner});

  @override
  State<StatefulWidget> createState() {
    return ConversationViewState();
  }

}

class ConversationViewState extends State<ConversationView> {
  String partnerName = "";
  String partnerFName = "";

  @override
  Widget build(BuildContext context) {
    setState(() {
      partnerName = widget.partner.nom;
      partnerFName = widget.partner.prenom;
    });

    return Scaffold(
      appBar : AppBar(
        title : Center(child: Text("$partnerFName $partnerName"),),
        actions: [
          IconButton(
            onPressed: (){
              FirestoreHelper().deconnexion();
              Navigator.push(context, MaterialPageRoute(
                builder: (context){
                  return const MyHomePage(title: "");
                }
              ));

            },
            icon: const Icon(Icons.exit_to_app)
          )

        ]
      ),
      body : bodyPage(),
    );
  }

  Widget bodyPage() {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          fondEcran(),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ZoneText(widget.partner, Myprofil),
              Expanded(child: Messagecontroller(Myprofil, widget.partner))
            ],
          ),
        ],
      )
    );
  }
}