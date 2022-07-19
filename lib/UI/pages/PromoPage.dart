import 'package:flutter/material.dart';
import '../../model/objects/ProductInPromo.dart';
import '../../model/objects/Promo.dart';
import '../widgets/CircularIconButton.dart';
import '../widgets/ProductInPromoCard.dart';

import 'ProductInPromoPage.dart';

class PromoPage extends StatefulWidget{
  PromoPage({Key key, this.promo}) : super (key : key);
  final Promo promo;

  @override
  _PromoPageState createState() => _PromoPageState();

}

class _PromoPageState extends State<PromoPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(0, 10, 10, 0),
        child: Center(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: CircularIconButton(
                    icon: Icons.arrow_back,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Text(
                  widget.promo.name,
                  style: TextStyle(
                      color: Theme
                          .of(context)
                          .primaryColor,
                      fontStyle: FontStyle.italic,
                      fontSize: 50
                  ),
                  textAlign: TextAlign.center,
                ),
                Row(
                  children: [
                    Text(
                      widget.promo.startDate.toString(),
                      style: TextStyle(
                          color: Theme
                              .of(context)
                              .primaryColor,
                          fontSize: 30
                      ),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      widget.promo.endDate.toString(),
                      style: TextStyle(
                          color: Theme
                              .of(context)
                              .primaryColor,
                          fontSize: 30
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      widget.promo.discount.toString() + "%",
                      style: TextStyle(
                          color: Theme
                              .of(context)
                              .primaryColor,
                          fontSize: 30
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
                Text(
                  "Products",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme
                        .of(context)
                        .primaryColor,
                    fontSize: 30,
                  ),
                ),
                Expanded(
                  child: Container(
                    child: ListView.builder(
                      itemCount: widget.promo.productsInPromo.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          child: ProductInPromoCard(
                            productInPromo: widget.promo.productsInPromo[index],
                          ),
                          onTap: () =>
                              _getProductInPromo(
                                  widget.promo.productsInPromo[index]),
                        );
                      },
                    ),
                  ),
                ),
              ],
            )
        ),
      ),
    );
  }

  void _getProductInPromo(ProductInPromo productInPromo) {
    setState(() {
      Navigator.push(context, new MaterialPageRoute(
          builder: (context) => new ProductInPromoPage(
              productInPromo: productInPromo)));
    });
  }

}
