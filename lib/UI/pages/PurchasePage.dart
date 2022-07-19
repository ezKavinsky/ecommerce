import 'package:ecommerce/UI/widgets/ProductInPurchaseCard.dart';
import 'package:flutter/material.dart';
import '../../model/objects/Product.dart';
import '../../model/objects/ProductInPromo.dart';
import '../../model/objects/Purchase.dart';
import '../widgets/CircularIconButton.dart';
import '../widgets/ProductInPromoPurchaseCard.dart';
import 'ProductPage.dart';

class PurchasePage extends StatefulWidget{
  PurchasePage({Key key, this.purchase}) : super (key : key);
  final Purchase purchase;

  @override
  _PurchasePageState createState() => _PurchasePageState();

}

class _PurchasePageState extends State<PurchasePage> {

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
                child:  CircularIconButton(
                  icon: Icons.arrow_back,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Text(
                widget.purchase.id.toString(),
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontStyle: FontStyle.italic,
                    fontSize: 50
                ),
                textAlign: TextAlign.center,
              ),
              Row(
                children: [
                  Text(
                    widget.purchase.shipped ? "Yes" : "No",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 30
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    widget.purchase.purchaseTime.toString(),
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 30
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    widget.purchase.total.toString(),
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 30
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    widget.purchase.creditCard.toString(),
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 30
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Text(
                "Products purchased",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 30,
                ),
              ),
              Expanded(
                child: Container(
                  child: ListView.builder(
                    itemCount: widget.purchase.productsInPurchase.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        child: ProductInPurchaseCard(
                          productInPurchase: widget.purchase.productsInPurchase[index],
                        ),
                        onTap: () => _getProduct(widget.purchase.productsInPurchase[index].product),
                      );
                    },
                  ),
                ),
              ),
              Text(
                "Products in promo purchased",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 30,
                ),
              ),
              Expanded(
                child: Container(
                  child: ListView.builder(
                    itemCount: widget.purchase.productsInPurchase.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        child: ProductInPromoPurchaseCard(
                          productInPromoPurchase: widget.purchase.productsInPromoPurchase[index],
                        ),
                        onTap: () => _getProductInPromo(widget.purchase.productsInPromoPurchase[index].productInPromo),
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

  void _getProduct(Product product) {
    setState(() {
      Navigator.push(context, new MaterialPageRoute(builder: (context) => new ProductPage(product: product)));
    });
  }

  void _getProductInPromo(ProductInPromo productInPromo) {
    setState(() {
      Navigator.push(context, new MaterialPageRoute(builder: (context) => new ProductInPromoPage(productInPromo : productInPromo)));
    });
  }

}