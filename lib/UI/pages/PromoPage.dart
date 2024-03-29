import 'package:flutter/material.dart';
import '../../model/Model.dart';
import '../../model/objects/ProductInPromo.dart';
import '../../model/objects/Promo.dart';
import '../../model/objects/User.dart';
import '../widgets/CircularIconButton.dart';
import '../widgets/ProductInPromoCard.dart';

import 'ProductInPromoPage.dart';

class PromoPage extends StatefulWidget{
  PromoPage({Key key, this.promo, this.user}) : super (key : key);
  final Promo promo;
  final User user;

  @override
  _PromoPageState createState() => _PromoPageState();

}

class _PromoPageState extends State<PromoPage> {
  List<ProductInPromo> _productsInPromo = null;

  @override
  void initState(){
    super.initState();
    Model.sharedInstance.getProductsInPromo(widget.promo.id.toString()).then((result){
      setState((){
        _productsInPromo = result;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
              child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
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
                          Text(
                            "Start date : " + widget.promo.startDate.toString(),
                            style: TextStyle(
                                color: Theme
                                    .of(context)
                                    .primaryColor,
                                fontSize: 30
                            ),
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            "End date : " + widget.promo.endDate.toString(),
                            style: TextStyle(
                                color: Theme
                                    .of(context)
                                    .primaryColor,
                                fontSize: 30
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            "Discount : " + widget.promo.discount.toString() + "%",
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
                      itemCount: _productsInPromo.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          child: ProductInPromoCard(
                            productInPromo: _productsInPromo[index],
                          ),
                          onTap: () =>
                              _getProductInPromo(
                                  _productsInPromo[index]),
                        );
                      },
                    ),
                  ),
                ),
              ],
            )
        ),
    );
  }

  void _getProductInPromo(ProductInPromo productInPromo) {
    setState(() {
      Navigator.push(context, new MaterialPageRoute(
          builder: (context) => new ProductInPromoPage(productInPromo: productInPromo, user: widget.user)));
    });
  }

}
