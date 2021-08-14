import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'model_coin.dart';

class CoinService {
  Future <List<Coin>> fetchCoins() async{
    var response = await http.get(Uri.parse(
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=15&page=1&sparkline=false'));
    if (response.statusCode == 200){
      var jsonResponse = convert.json.decode(response.body) as List;
      return jsonResponse.map((e) => Coin.fromJson(e)).toList();

    }
    else {
      throw Exception('Failed to load coins');
    }

  }

}
