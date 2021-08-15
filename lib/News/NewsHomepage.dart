import 'package:finlite/News/NewsCard.dart';
import 'package:flutter/material.dart';
import 'package:finlite/News/Models/News_Model.dart';
import 'package:finlite/News/Services/apicall.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class NewsHomePage extends StatefulWidget {
  const NewsHomePage({Key? key}) : super(key: key);

  @override
  _NewsHomePageState createState() => _NewsHomePageState();
}

class _NewsHomePageState extends State<NewsHomePage> {
  @override
  ApiService client= ApiService();
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: client.getNewsData(),
          builder: ( BuildContext context,AsyncSnapshot <List<NewsData>> snapshot){
            if(snapshot.hasData){
              List<NewsData>? articles=snapshot.data;
              return ListView.builder(
                  itemCount: articles!.length,
                  itemBuilder: (context,index)=>customListTile(articles[index]));
            }
            return Center(child: SpinKitCubeGrid(
            color: Colors.blue,
            size: 50.0,));
          },
        ),
      ),

    );
  }
}
