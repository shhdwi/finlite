
import 'package:finlite/Constants.dart';
import 'package:finlite/News/NewsHomepage.dart';
import 'package:finlite/Quiz/Welcome_screen.dart';
import 'package:finlite/Quiz/quiz-screen/Quiz-screen.dart';
import 'package:finlite/portfolio_page.dart';
import 'package:finlite/screens/leaderboard.dart';
import 'package:finlite/services/getcoins.dart';
import 'package:finlite/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

var tstyle = TextStyle(color: Colors.white.withOpacity(0.6),
    fontSize: 50
);
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var padding = EdgeInsets.symmetric(horizontal: 18,vertical: 5);
  double gap =10;

  int _index = 0;
  List<Color> colors = [
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white
  ];

  List<Widget> text = [
    Home(),
    NewsHomePage(),
    Home1(),
    WelcomeScreen(),
  ];
  PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Finlite",style: TextStyle(color: Colors.lightBlueAccent,fontFamily: "Poppins",fontSize: 28,fontWeight: FontWeight.bold),),


          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.blueGrey,

          ),
        ),
         drawer: MyDrawer(),

        extendBody: true,
        body:PageView.builder(
            itemCount: 4,
            controller: controller,
            onPageChanged: (page){
              setState(() {
                _index= page;
              });
            },
            itemBuilder:(context,position){
              return Container(
                color: colors[position],
                child:Center(child: text[position]),
              );
            }),
        bottomNavigationBar: SafeArea(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(100)),
                boxShadow: [
                  BoxShadow(
                    spreadRadius: -10,
                    blurRadius: 60,
                    color: Colors.black.withOpacity(0.4),
                    offset: Offset(0,25),
                  )
                ]
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3,vertical: 3),
              child: GNav(
                curve: Curves.easeInOutExpo,
                duration: Duration(milliseconds: 900),
                tabs: [
                  GButton(
                    gap: gap,
                    icon: Icons.attach_money_outlined,
                    iconColor: Colors.black,
                    iconActiveColor: Colors.lightBlueAccent,
                    text: 'Market',
                    textColor: Colors.lightBlueAccent,
                    backgroundColor: Colors.lightBlueAccent.withOpacity(0.2),
                    iconSize: 24,
                    padding: padding,
                  ),
                  GButton(
                    gap: gap,
                    icon: Icons.feed,
                    iconColor: Colors.black,
                    iconActiveColor: Colors.lightBlueAccent,
                    text: 'News',
                    textColor: Colors.lightBlueAccent,
                    backgroundColor: Colors.lightBlueAccent.withOpacity(0.2),
                    iconSize: 24,
                    padding: padding,
                  ),

                  GButton(
                    gap: gap,
                    icon: Icons.person,
                    iconColor: Colors.black,
                    iconActiveColor: Colors.lightBlueAccent,
                    text: 'portfolio',
                    textColor: Colors.lightBlueAccent,
                    backgroundColor: Colors.lightBlueAccent.withOpacity(0.2),
                    iconSize: 24,
                    padding: padding,
                  ),
                  GButton(
                    gap: gap,
                    icon: Icons.videogame_asset,
                    iconColor: Colors.black,
                    iconActiveColor: Colors.lightBlueAccent,
                    text: "Trivia",
                    textColor: Colors.lightBlueAccent,
                    backgroundColor: Colors.lightBlueAccent.withOpacity(0.2),
                    iconSize: 24,
                    padding: padding,
                  ),

                ],
                selectedIndex: _index,
                onTabChange: (index){
                  setState(() {
                    _index =index;
                  });
                  controller.animateToPage(index,duration: Duration(milliseconds: 1000),curve: Curves.easeInOutExpo);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
