
import 'dart:io';
import 'dart:typed_data';

import 'package:firstapplicationeisi/Fonctions/FirestoreHelper.dart';
import 'package:firstapplicationeisi/model/MyProfil.dart';
import 'package:firstapplicationeisi/modelView/ImageRond.dart';
import 'package:flutter/material.dart';
import 'package:firstapplicationeisi/library/lib.dart';
import 'package:file_picker/file_picker.dart';


class MyUsers extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyUsersState();
  }

}

class MyUsersState extends State<MyUsers>{
  String? lienImage;
  Uint8List? bytesImages;
  String? nameImage;


  RecupererImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      withData: true,
      type: FileType.image,
    );
    if (result != null) {
      setState(() {
        nameImage = result.files.first.name;
        bytesImages = result.files.first.bytes;
      });
      popImage();
    }
  }

  popImage(){
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context){
            return AlertDialog(
              title: const Text("Souhaitez-vous utiliser cette image?"),
              content: Image.memory(bytesImages!),
              actions: [
                ElevatedButton(
                    onPressed: (){
                      FirestoreHelper().stockageImage(nameImage!, bytesImages!).then((value){
                        setState(() {
                          lienImage = value;
                          Myprofil.image = value;

                          Map<String,dynamic> map = {
                            "IMAGE": lienImage,
                          };

                          FirestoreHelper().updateUser(Myprofil.uid, map);
                          Navigator.pop(context);
                        });
                      });

                    },
                    child: const Text("OK")
                ),
                ElevatedButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    child: const Text("Annuler")
                ),
              ],
            );
        }
    );
  }




  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.all(20),
      child: bodyPage(),
    );
      
  }


  Widget bodyPage(){
    return Column(
      children: [
        //Logo de moi
        InkWell(
          child: ImageRond(image: Myprofil.image,size: 150,),
          onTap: (){
            RecupererImage();
          },
        ),

        //NOm et prénom
        Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width - 100,
              child: TextField(
                decoration: InputDecoration(
                  hintText: Myprofil.prenom,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                  )
                ),
                onChanged: (newValue){
                  setState(() {
                    Myprofil.prenom = newValue;
                  });

                },
              ),
            ),

            IconButton(
                onPressed: (){
                  Map<String,dynamic> map = {
                    "PRENOM": Myprofil.prenom,
                  };
                  FirestoreHelper().updateUser(Myprofil.uid, map);
                },
                icon: const Icon(Icons.edit)
            ),
          ],
        ),
        const SizedBox(height: 10,),


        Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width - 100,
              child: TextField(
                decoration: InputDecoration(
                    hintText: Myprofil.nom,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)
                    )
                ),
                onChanged: (newValue){
                  setState(() {
                    Myprofil.nom = newValue;
                  });

                },
              ),
            ),

            IconButton(
                onPressed: (){
                  Map<String,dynamic> map = {
                    "NOM": Myprofil.nom,
                  };
                  FirestoreHelper().updateUser(Myprofil.uid, map);
                },
                icon: const Icon(Icons.edit)
            ),
          ],
        ),
        const SizedBox(height: 10,),


        Text(Myprofil.mail)

        // adresse mail
      ],
    );
  }

}