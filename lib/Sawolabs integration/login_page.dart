
import 'package:finlite/database_coin/database.dart';
import 'package:finlite/models/user_models.dart';
import 'package:finlite/screens/display_page.dart';
import 'package:finlite/services/getcoins.dart';
import 'package:finlite/widgets/nav_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sawo/sawo.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../Constants.dart';

class GetStarted extends StatefulWidget {

  @override
  _GetStartedState createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {


  @override
  Sawo sawo = Sawo(
    apiKey: "369bd82b-3c18-4816-ba09-b762159b93c7",
    secretKey: "6116536e257f957f4ae13426eAA1WBtZK4eT5JTNer0oFm5H",
  );
  late User user;

  void payloadCallback(context, payload) {
    if (payload == null || (payload is String && payload.length == 0)) {
      payload = "Login Failed :(";
    }

    setState(() {
      print(jsonDecode(payload));
      user = User.fromJson(jsonDecode(payload));
      print(user.userId);
      print(payload);
      Map<String,dynamic> userInfoMap = {"email":user.identifier,"portfolio":portfolio};

      SignOut();

      DatabaseMethods().createUser(user.identifier,userInfoMap);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage()

      ));





    });
  }
  @override
  Widget build(BuildContext context) {
    // MediaQueryData mediaQueryData = MediaQuery.of(context);
    // double screenWidth = mediaQueryData.size.width;
    // double screenHeight = mediaQueryData.size.height;
    // double blockSizeHorizontal = screenWidth / 100;
    // double blockSizeVertical = screenHeight / 100;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.blue[50],
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(

                children: [
                  AnimatedContainer(
                    curve: Curves.easeIn,
                    duration: Duration(milliseconds: 400),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                    Container(

                    child: Column(
                    children: [
                        GestureDetector(
                        onTap: (){
                  setState(() {
                  });
                  },
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: AnimatedContainer(
                        margin: EdgeInsets.only(top: 50),
                        duration: Duration(milliseconds: 400),
                        curve: Curves.easeIn,
                        child: Center(child: Column(
                          children: [
                            Text("Hey There!",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
                            Text("Crypto to the Moon!",style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),)
                          ],
                        )),

                      ),
                    ),
                  ),
                ],

              ),
              ),
              Container(
              padding: EdgeInsets.all(30),
              child: AnimatedImage()
              ),
                           GestureDetector(
                             onTap: (){
                               sawo.signIn(
                                   context: context,
                                   identifierType: 'email',
                                   callback: payloadCallback);

                             },
                             child: Container(
                               margin: EdgeInsets.only(bottom: 30),
                               child: InkWell(

                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 200),
                                  width: 250,
                                  height: 50,

                                  alignment: Alignment.center,
                                  child: Text(
                                    "Get Started!",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      // fontWeight: FontWeight.bold,
                                    ),

                                  ),
                                  decoration: BoxDecoration(
                                      color: Colors.blue[400],
                                      borderRadius: BorderRadius.circular(25)
                                  ),

                                ),
                          ),
                             ),
                           ),

                        ]))]),
            ],
          ),
        ),
      ),
    );
  }
}
class AnimatedImage extends StatefulWidget {
  @override
  _AnimatedImageState createState() => _AnimatedImageState();
}

class _AnimatedImageState extends State<AnimatedImage> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(vsync: this,
      duration: const Duration(seconds: 3))..repeat(reverse: true);
  late Animation<Offset> _animation= Tween(
      begin: Offset.zero,
      end: Offset(0,0.1)
  ).animate(_controller);



  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(position: _animation,
      child: Image.asset("lib/img.png"),);
  }
}
Future SignOut() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();}
