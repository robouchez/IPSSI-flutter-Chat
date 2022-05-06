import 'package:firstapplicationeisi/Fonctions/FirestoreHelper.dart';
import 'package:firstapplicationeisi/View/AllUsers.dart';
import 'package:firstapplicationeisi/View/ConversationListView.dart';
import 'package:firstapplicationeisi/View/MyUsers.dart';
import 'package:firstapplicationeisi/main.dart';
import 'package:flutter/material.dart';
class Dashboard extends StatefulWidget {


  @override
  State<Dashboard> createState()=> DashboardState();

}

class DashboardState extends State<Dashboard>{
  int selected = 0;
  PageController controller = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar : AppBar(
            title : const Text("Mon DashBoard"),
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selected,
        onTap: (newValue){
          setState(() {
            selected = newValue;
            controller.jumpToPage(newValue);
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
            label: "Utilisateurs"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.message),
              label: "Conversations"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings),
            label : "Paramètres"
          )
        ],
      ),
    );
  }

  Widget bodyPage(){
    return PageView(
      onPageChanged: (value){
        setState(() {
          selected = value;
        });
      },
      children: [
        //Afficher tous les utilisateurs
        AllUsers(),

        ConversationListView(),

        //Créer une page de profil
        MyUsers()

      ],
      controller: controller,
    );


  }

}