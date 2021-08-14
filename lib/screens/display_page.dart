import 'package:finlite/services/coin_service.dart';
import 'package:finlite/services/model_coin.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class DisplayCoin extends StatelessWidget {

  final CoinService coinService = CoinService();

  @override
  Widget build(BuildContext context) {
    return FutureProvider(
      create: (BuildContext context) => coinService.fetchCoins(),
      catchError: (context,error){
        print(error.toString());
      }, initialData: [],
      child: CatalogList(),

    );
  }
}

class CatalogList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Coin> coins = Provider.of<List<Coin>>(context);
    return ListView.builder(
      shrinkWrap: true,
      itemCount: coins.length,
      itemBuilder: (context, index) {
        final catalog = coins;
        return CatalogItem(index,catalog);
      },
    );
  }
}

class CatalogItem extends StatelessWidget {
  late final List<Coin> coin;
  final int index;

  CatalogItem(this.index,this.coin);

  @override
  Widget build(BuildContext context) {

    return VxBox(
      child: Row(
        children: [
          CatalogImage(
            image: coin[index].imageUrl,
          ),
          Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  coin[index].name.text.lg.color(Colors.orange).bold.make(),
                  coin[index].symbol.text.make(),
                  10.heightBox,
                  ButtonBar(
                    alignment: MainAxisAlignment.spaceBetween,
                    buttonPadding: EdgeInsets.zero,
                    children: [
                      "\$${coin[index].price}".text.bold.xl.make(),
                      ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              Colors.white,
                            ),
                            shape: MaterialStateProperty.all(
                              StadiumBorder(),
                            )),
                        child: coin[index].change.text.make(),
                      )
                    ],
                  ).pOnly(right: 8.0)
                ],
              ))
        ],
      ),
    ).white.rounded.square(150).make().py16();
  }
}

class CatalogImage extends StatelessWidget {
  final String image;

  const CatalogImage({required this.image}) ;
  @override
  Widget build(BuildContext context) {
    return Image.network(
      image,
    ).box.rounded.p8.color(Vx.amber50).make().p16().w40(context);
  }
}



