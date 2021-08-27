import 'dart:async';
import 'dart:convert';

import 'package:finlite/Constants.dart';
import 'package:finlite/models/holding_card.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';


import 'models/coindata_models.dart';

class Portfolio extends StatefulWidget {


  @override
  _PortfolioState createState() => _PortfolioState();
}

class _PortfolioState extends State<Portfolio> {
  double pnl = ProfitandLoss(coinList1);
  Future<List<Coin>> fetchCoin() async {
    coinList1 = [];
    final response = await http.get(Uri.parse(
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=10&page=1&sparkline=false'));

    if (response.statusCode == 200) {
      List<dynamic> values = [];
      values = json.decode(response.body);
      if (values.length > 0) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            coinList1.add(Coin.fromJson(map));
          }
        }
      }
      print(coinList1);
      return coinList1;
    } else {
      throw Exception('Failed to load coins');
    }
  }
  @override
  void initState() {
    fetchCoin();
    print(coinList1);
    Timer.periodic(Duration(seconds: 30), (timer) => fetchCoin());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
        FutureBuilder(
          future: fetchCoin(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {


            if (snapshot.hasData){

            return Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                "Portfolio:".text.xl5.bold.color(Colors.blueGrey).make(),
                "\$ ${portfolio+pnl}".text.xl2.make(),
              ],
            ),
          );}
            else{
              return Center(child: SpinKitWanderingCubes(size: 50,color: Colors.lightBlueAccent,),);
            }
            },
        )

          ],

        ),
      ),
    );
  }
}
double ProfitandLoss(List <Coin> coinlist){
  double total=0.0;
  for(int i=0;i<holdings.length;i++){
    total+=holdings[coinlist[i].symbol]!["Amount"]*(coinlist[i].price-holdings[coinlist[i].symbol]!["AvgPrice"]);

  }
  return total;
}




class Home1 extends StatefulWidget {
  @override
  _Home1State createState() => _Home1State();
}

class _Home1State extends State<Home1> {
  Future<List<Coin>> fetchCoin() async {
    coinList = [];
    final response = await http.get(Uri.parse(
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=10&page=1&sparkline=false'));

    if (response.statusCode == 200) {
      List<dynamic> values = [];
      values = json.decode(response.body);
      if (values.length > 0) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            coinList.add(Coin.fromJson(map));
          }
        }
        setState(() {
          coinList;
        });
      }
      print(coinList);
      return coinList;
    } else {
      throw Exception('Failed to load coins');
    }
  }

  @override
  void initState() {
    fetchCoin();
    // Timer.periodic(Duration(seconds: 30), (timer) => fetchCoin());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return coinList.isNotEmpty?  Scaffold(
        backgroundColor: Colors.white,
        // appBar: AppBar(
        //   backgroundColor: Colors.grey[300],
        //   title: Text(
        //     'COINS',
        //     style: TextStyle(
        //       color: Colors.grey[900],
        //       fontSize: 20,
        //       fontWeight: FontWeight.bold,
        //     ),
        //   ),
        // ),
        body: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: 10,
          itemBuilder: (context, index) {
            return CoinCard(
              coin: coinList[index],
              name: coinList[index].name,
              symbol: coinList[index].symbol,
              imageUrl: coinList[index].imageUrl,
              price: (holdings[coinList[index].symbol]!["Amount"]),
              change: holdings[coinList[index].symbol]!["Amount"]*(coinList[index].price-holdings[coinList[index].symbol]!["AvgPrice"]) as double,
              changePercentage: holdings[coinList[index].symbol]!["Amount"]*(coinList[index].price) as double,
            );
          },
        )): Center(child: SpinKitCubeGrid(size: 60,color: Colors.lightBlueAccent,));
  }
}




