

import 'package:finlite/Constants.dart';
import 'package:finlite/News/NewsHomepage.dart';
import 'package:finlite/Quiz/Welcome_screen.dart';
import 'package:finlite/Quiz/quiz-screen/Quiz-screen.dart';
import 'package:finlite/database_coin/sharedprefs.dart';
import 'package:finlite/screens/leaderboard.dart';
import 'package:finlite/services/getcoins.dart';
import 'package:finlite/widgets/nav_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



// ignore: must_be_immutable
class MyDrawer extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    Future map =SharedPreferenceHelper().getUserinfo();
    // String email = SharedPreferenceHelper().getEmailValues();
    // String? imageUrl= user!.photoURL;
    print(map);

    // print(email);
    // print(imageUrl);




    return Drawer(
      child: Container(
        color: Colors.indigoAccent[50],
        child: ListView(
          children: [
            DrawerHeader(
                padding: EdgeInsets.zero,
                margin: EdgeInsets.zero,



                child: FutureBuilder(
                  future: SharedPreferenceHelper().getUserinfo(),
                  builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasData){
                      Map userinfo=snapshot.data;
                      return UserAccountsDrawerHeader(
                          margin: EdgeInsets.zero,
                          decoration: BoxDecoration(
                            color: Colors.blueGrey[200],),
                          accountEmail: Text(userinfo["email"]),
                          accountName: Text("Portfolio: \$ $portfolio"),
                          currentAccountPicture: Image.asset("lib/stonks.jpg")
                            //),


                          );


                    }
                    return Container(
                        child: Center(child: CircularProgressIndicator()));


                  },
                )
            ),
            GestureDetector(
              onTap:(){ Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyHomePage()));},
              child: ListTile(
                leading: Icon(
                  CupertinoIcons.home,
                  color: Colors.black45,
                ),
                title: Text("Home"),



              ),
            ),
            GestureDetector(
              onTap:(){},
              child: ListTile(
                leading: Icon(
                  CupertinoIcons.heart,
                  color: Colors.redAccent,
                ),
                title: Text("Developers",style: TextStyle(color: Colors.redAccent),),



              ),
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>LeaderBoard()));
              },
              child: ListTile(
                leading: Icon(
                  CupertinoIcons.game_controller,
                  color: Colors.blue,
                ),
                title: Text("Friends"),



              ),
            )
          ],

        ),
      ),

    );
  }

}