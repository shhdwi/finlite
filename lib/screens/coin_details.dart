import 'package:finlite/Constants.dart';
import 'package:finlite/database_coin/database.dart';
import 'package:finlite/database_coin/sharedprefs.dart';
import 'package:finlite/models/coindata_models.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CoinPage extends StatelessWidget {
  final Coin coin;
  final _formKey = GlobalKey<FormState>();
  final myController = TextEditingController();
  final myController1 = TextEditingController();

  CoinPage({required this.coin}) : assert(coin != null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(2, 2),
                            blurRadius: 4,
                            spreadRadius: 1,
                          ),
                          BoxShadow(
                            color: Colors.white,
                            offset: Offset(-2, -2),
                            blurRadius: 4,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      height: 60,
                      width: 60,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.network(coin.imageUrl),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(25),
                    child: Text(
                      coin.name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                          color: Colors.lightBlueAccent[300]),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: TextFormField(
                  controller: myController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: 'Enter Amount in USD',
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 32.0),
                          borderRadius: BorderRadius.circular(5.0)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 1.0),
                          borderRadius: BorderRadius.circular(5.0))),
                ),
              ),
              GestureDetector(
                child: TextButton(
                    onPressed: () async {
                      await SharedPreferenceHelper().getUserinfo().then((snap) {
                        double Moneyused = double.parse(myController.text);
                        double amtbought = Moneyused/coin.price;
                        if (portfolio < Moneyused) {
                          Fluttertoast.showToast(
                              msg: "Not Enough Money!",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 3,
                              backgroundColor: Colors.blueGrey,
                              textColor: Colors.white,
                              fontSize: 16.0
                          );
                          print("not enough money");
                        } else {
                          Fluttertoast.showToast(
                              msg: "you just bought ${amtbought} ${coin.name}",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 3,
                              backgroundColor: Colors.blueGrey,
                              textColor: Colors.white,
                              fontSize: 16.0
                          );
                          holdings[coin.symbol]!["AvgPrice"] =
                              (holdings[coin.symbol]!["AvgPrice"] *
                                          holdings[coin.symbol]!["Amount"] +
                                      Moneyused) /
                                  (holdings[coin.symbol]!["Amount"] +
                                      (Moneyused / coin.price));
                          holdings[coin.symbol]!["Amount"] =
                              (holdings[coin.symbol]!["Amount"] +
                                  (Moneyused / coin.price));
                          portfolio -= Moneyused;
                          Map<String, dynamic> messageInfoMap = {
                            "coin": holdings
                          };
                          print(holdings);
                          DatabaseMethods()
                              .addCoin(snap["email"], messageInfoMap);
                          Map<String, dynamic> userInfoMap = {
                            "email": snap["email"],
                            "portfolio": portfolio
                          };
                          DatabaseMethods().addUser(snap["email"], userInfoMap);
                          Navigator.pop(context);
                        }
                      });
                    },
                    child: Text("Buy",
                        style: TextStyle(color: Colors.lightGreen))),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: TextFormField(
                  controller: myController1,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: 'Enter Amount of ${coin.name}',
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 32.0),
                          borderRadius: BorderRadius.circular(5.0)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 1.0),
                          borderRadius: BorderRadius.circular(5.0))),
                ),
              ),
              GestureDetector(
                child: TextButton(
                  child: Text(
                    "Sell",
                    style: TextStyle(color: Colors.redAccent),
                  ),
                  onPressed: () async {
                    await SharedPreferenceHelper().getUserinfo().then((snap) {
                      double amount = double.parse(myController1.text);

                      if (amount > holdings[coin.symbol]!["Amount"]) {
                        Fluttertoast.showToast(
                            msg: "Insufficient amount of ${coin.symbol} to sell",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 3,
                            backgroundColor: Colors.blueGrey,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                        print("insufficient amount to sell");
                      } else {
                        Fluttertoast.showToast(
                            msg: "you just sold ${amount} ${coin.name}",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 3,
                            backgroundColor: Colors.blueGrey,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );



                        holdings[coin.symbol]!["Amount"] =
                            (holdings[coin.symbol]!["Amount"] - (amount));
                        portfolio += amount * coin.price;
                        if (holdings[coin.symbol]!["Amount"] == 0.00) {
                          holdings[coin.symbol]!["AvgPrice"] = 0.0;
                        }
                        Navigator.pop(context);

                      }

                      Map<String, dynamic> messageInfoMap = {"coin": holdings};
                      print(holdings);

                      DatabaseMethods().addCoin(snap["email"], messageInfoMap);
                      Map<String, dynamic> userInfoMap = {
                        "email": snap["email"],
                        "portfolio": portfolio
                      };
                      DatabaseMethods().addUser(snap["email"], userInfoMap);
                    });
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class InputWithIcon extends StatefulWidget {
  final IconData icon;
  final String hint;
  InputWithIcon({required this.icon, required this.hint});

  @override
  _InputWithIconState createState() => _InputWithIconState();
}

class _InputWithIconState extends State<InputWithIcon> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Color(0xFFBC7C7C7), width: 2),
          borderRadius: BorderRadius.circular(50)),
      child: Row(
        children: <Widget>[
          Container(
              width: 60,
              child: Icon(
                widget.icon,
                size: 20,
                color: Color(0xFFBB9B9B9),
              )),
          Expanded(
            child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 20),
                  border: InputBorder.none,
                  hintText: widget.hint),
            ),
          )
        ],
      ),
    );
  }
}

class OutlineBtn extends StatefulWidget {
  final String btnText;
  OutlineBtn({required this.btnText});

  @override
  _OutlineBtnState createState() => _OutlineBtnState();
}

class _OutlineBtnState extends State<OutlineBtn> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Color(0xFFB40284A), width: 2),
          borderRadius: BorderRadius.circular(50)),
      padding: EdgeInsets.all(20),
      child: Center(
        child: Text(
          widget.btnText,
          style: TextStyle(color: Color(0xFFB40284A), fontSize: 16),
        ),
      ),
    );
  }
}

double ProfitandLoss(List<Coin> coinlist) {
  double total = 0.0;
  for (int i = 0; i < holdings.length; i++) {
    total += holdings[coinlist[i].symbol]!["Amount"] *
        (coinlist[i].price - holdings[coinlist[i].symbol]!["AvgPrice"]);
  }
  return total;
}
