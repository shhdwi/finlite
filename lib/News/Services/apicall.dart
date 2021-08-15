import 'package:http/http.dart';
import 'package:finlite/News/Models/News_Model.dart';
import 'dart:convert';
import 'package:finlite/api.dart';
class ApiService {
  final endPointUrl = "newsapi.org";

  Future<List<NewsData>> getNewsData() async {

    final queryParameters = {
      'q':"Cryptocurrency",
      'sortBy':"relevancy",

      'apiKey': '$apikey',
    };
    // final uri = Uri.https(endPointUrl, '/v2/everything', queryParameters);
    // print(uri);
    final response = await get(Uri.parse("https://newsapi.org/v2/everything?q=Cryptocurrency&apiKey=f5de23d07bf54058a4ea928df9558ceb&language=en&from=2021-08-13&to=2021-08-14&sortBy=popularity"));
    print("call over");
    if(response.statusCode==200){
      Map<String, dynamic> json = jsonDecode(response.body);
      print(response.body);
      List<dynamic> body = json['articles'];
      List<NewsData> articles = body.map((dynamic item) => NewsData.fromJson(item)).toList();
      print(body);
      print(articles.length);
      return articles;

    }
    else{
      print("not working");
      throw Exception("mkc");
    }

  }
}
