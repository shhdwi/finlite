import 'package:finlite/Constants.dart';
import 'package:finlite/database_coin/database.dart';
import 'package:finlite/database_coin/sharedprefs.dart';
import 'package:finlite/models/coindata_models.dart';
import 'package:flutter/material.dart';

class CoinPage extends StatelessWidget {
  final Coin coin;
  final _formKey = GlobalKey<FormState>();
  final myController = TextEditingController();

  CoinPage({required this.coin})
      : assert(coin != null);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(25),
                child: Text(coin.name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 40, color: Colors.lightBlueAccent[300] ),
                ),
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
                      borderSide: BorderSide(color: Colors.grey, width: 32.0),
                      borderRadius: BorderRadius.circular(5.0)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      borderRadius: BorderRadius.circular(5.0)
                  )
              ),
            ),
          ),


              GestureDetector(child: TextButton(onPressed: () async{
                await SharedPreferenceHelper().getUserinfo().then((snap){

                  Map<String,dynamic>  messageInfoMap = {coin.symbol:{"Amount": myController.text,"AvgPrice":coin.price}};
                  holdings[coin.symbol]=messageInfoMap;
                  print(holdings);

                  DatabaseMethods().addCoin( snap["email"], messageInfoMap);});
              },
              child: Text("Buy")),),
              GestureDetector(child: OutlineBtn(btnText: "Sell"), onTap: (){},),


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
          border: Border.all(
              color: Color(0xFFBC7C7C7),
              width: 2
          ),
          borderRadius: BorderRadius.circular(50)
      ),
      child: Row(
        children: <Widget>[
          Container(
              width: 60,
              child: Icon(
                widget.icon,
                size: 20,
                color: Color(0xFFBB9B9B9),
              )
          ),
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
                  hintText: widget.hint
              ),
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
          border: Border.all(
              color: Color(0xFFB40284A),
              width: 2
          ),
          borderRadius: BorderRadius.circular(50)
      ),
      padding: EdgeInsets.all(20),
      child: Center(
        child: Text(
          widget.btnText,
          style: TextStyle(
              color: Color(0xFFB40284A),
              fontSize: 16
          ),
        ),
      ),
    );
  }
}

