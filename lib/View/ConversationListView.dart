import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Fonctions/FirestoreHelper.dart';
import '../library/lib.dart';
import '../main.dart';
import '../model/MyProfil.dart';
import '../modelView/ImageRond.dart';
import 'ConversationView.dart';

class ConversationListView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ConversationListViewState();
  }

}

class ConversationListViewState extends State<ConversationListView> {
  @override
  Widget build(BuildContext context) {
    return bodyPage();
  }

  Widget bodyPage() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirestoreHelper().fire_conversation.where('idmoi', isEqualTo: Myprofil.uid).orderBy('envoimessage',descending: true).snapshots(),
        //stream: FirestoreHelper().fire_conversation.orderBy('envoimessage',descending: true).snapshots(),
        builder: (context, snapshot){
          // Pas d'information dans la collection Users
          if(!snapshot.hasData){
            return const CircularProgressIndicator();
          }
          // Information dans la collection Users
          else
          {
            List documents = snapshot.data!.docs;
            return ListView.builder(
                itemCount: documents.length,
                itemBuilder: (context,index){
                  return InkWell(
                    child: Card(
                      elevation: 5.0,
                      color: Colors.amber,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      child: ListTile(
                        //Image
                        leading: ImageRond(image: documents[index]["IMAGE"],size:60),

                        title: Text("${documents[index]["PRENOM"]} ${documents[index]["NOM"]}"),
                        subtitle: Text("${documents[index]["MAIL"]}"),
                      ),
                    ),
                    onTap: (){
                      FirestoreHelper().getProfilByUID(documents[index]["destinateur"]).then(
                        (value) {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context){
                                return ConversationView(partner: value);
                              }
                          )
                          );
                        }
                      );
                    },
                  );
                }
            );
          }
        }
    );
  }
}