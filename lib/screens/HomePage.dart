
//
// import 'package:finlite/screens/coin_details.dart';
// import 'package:finlite/services/model_coin.dart';
// import 'package:flutter/material.dart';
//
// import 'package:provider/provider.dart';
//
//
// class Home extends StatelessWidget{
//   @override
//   Widget build(BuildContext context) {
//     List<Coin> coin = Provider.of<List<Coin>>(context);
//
//     return Scaffold(
//         appBar: AppBar(title: Text('Employees'),
//         ),
//         body: (coin == null)
//             ? Center(child: CircularProgressIndicator(),)
//             : ListView.builder(
//             itemCount: coin.length,
//             itemBuilder: (context,index){
//               return ListTile(
//                 leading: Image.network(coin[index].imageUrl),
//                 subtitle: Text(coin[index].symbol),
//                 title: Text(coin[index].name),
//                 onTap: () {
//                   Navigator.of(context).push(MaterialPageRoute(builder: (context) =>CoinPage(coin: coin[index],)));
//                 },
//               );
//             })
//     );
//   }
// }