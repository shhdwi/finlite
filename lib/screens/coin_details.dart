import 'package:finlite/models/coindata_models.dart';
import 'package:flutter/material.dart';

class CoinPage extends StatelessWidget {
  final Coin coin;

  const CoinPage({required this.coin})
      : assert(coin != null);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Text(coin.name),
        ),
      ),
    );
  }
}
