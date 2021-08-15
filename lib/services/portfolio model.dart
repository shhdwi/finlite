class Portfolio{
  double Cash;
  //this.holdings=["BTC":["amount":double,"average traded price":double,transactions:nested list[amount,transaction price]],]
  //
  Map<String,dynamic> holdings;
  Portfolio({required this.Cash,required this.holdings});

  factory Portfolio.fromMap(Map<String,dynamic> map){
    return Portfolio(
      Cash: map["Cash"] as double,
      holdings:map["holdings"] as Map<String,dynamic>
    );
  }

  void Buy(String crypto_name,double paisa,double current_price){
    if(paisa>Cash){
      print("gareeb khareedne aa gaya");
    }
    else{
      if(this.holdings[crypto_name]["average traded price"]==null){
        this.holdings[crypto_name]["average traded price"]=current_price;
        this.holdings[crypto_name]["amount"]=paisa/current_price;
        this.Cash-=paisa;


      }
      else{
        double ogamount=this.holdings[crypto_name]["amount"];
        double ogavg=this.holdings[crypto_name]["average traded price"];
        this.holdings[crypto_name]["amount"]=ogamount+(paisa/current_price);
        double newamount=this.holdings[crypto_name]["amount"];
        this.holdings[crypto_name]["average traded price"]=(ogamount*ogavg+paisa)/newamount;
        this.Cash-=paisa;



      }
    }
  }

}