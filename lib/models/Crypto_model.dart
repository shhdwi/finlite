class Crypto {
 late String symbol;
  late String name;
 late String image;
  late int currentPrice;
 late int marketCap;
  late int marketCapRank;
 late  int fullyDilutedValuation;
  late int totalVolume;
 late  int high24h;
  late int low24h;
  late double priceChange24h;
  late double priceChangePercentage24h;

  Crypto(
      {required this.symbol,
        required this.name,
        required this.image,
        required this.currentPrice,
        required this.marketCap,
        required this.marketCapRank,
        required this.fullyDilutedValuation,
        required this.totalVolume,
        required this.high24h,
        required this.low24h,
        required this.priceChange24h,
        required this.priceChangePercentage24h});

  Crypto.fromJson(Map<String, dynamic> json) {
    symbol = json['symbol'];
    name = json['name'];
    image = json['image'];
    currentPrice = json['current_price'];
    marketCap = json['market_cap'];
    marketCapRank = json['market_cap_rank'];
    fullyDilutedValuation = json['fully_diluted_valuation'];
    totalVolume = json['total_volume'];
    high24h = json['high_24h'];
    low24h = json['low_24h'];
    priceChange24h = json['price_change_24h'];
    priceChangePercentage24h = json['price_change_percentage_24h'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['symbol'] = this.symbol;
    data['name'] = this.name;
    data['image'] = this.image;
    data['current_price'] = this.currentPrice;
    data['market_cap'] = this.marketCap;
    data['market_cap_rank'] = this.marketCapRank;
    data['fully_diluted_valuation'] = this.fullyDilutedValuation;
    data['total_volume'] = this.totalVolume;
    data['high_24h'] = this.high24h;
    data['low_24h'] = this.low24h;
    data['price_change_24h'] = this.priceChange24h;
    data['price_change_percentage_24h'] = this.priceChangePercentage24h;
    return data;
  }
}
