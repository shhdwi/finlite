import 'package:finlite/Constants.dart';
import 'package:finlite/database_coin/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LeaderBoard extends StatefulWidget {


  @override
  _LeaderBoardState createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  getLeaderboard()async{
    await DatabaseMethods().getData().then((value) {
      return value;

    });

  }




  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: SafeArea(

          child:
          FutureBuilder(
            future: DatabaseMethods().getData(),
            builder: (context, snapshot) {


                if (snapshot.hasData){
                  leaderboard= snapshot.data as List<Map<String, dynamic>>;

                  return ListView.builder(itemCount: leaderboard.length ,itemBuilder: (context,index){
                    print(snapshot);
                    print(snapshot.runtimeType);

                 return ListTile(title: Text(leaderboard[index]["email"]),leading: Text("${index+1}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),subtitle: Text("portfolio: ${leaderboard[index]["portfolio"]}"),);}

                  );}
                      else{return Center(child: SpinKitCubeGrid(color: Colors.lightBlueAccent,),);}

            }
          )



        )
    );
  }
}
// Future<List<Map<String,dynamic>>> getLeaderboard()async{
//   await DatabaseMethods().getData().then((value) {
//     return value;
//
//   });


