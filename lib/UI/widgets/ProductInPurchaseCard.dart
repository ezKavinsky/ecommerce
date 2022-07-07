import 'package:ecommerce/model/objects/ProductInPurchase.dart';
import 'package:flutter/material.dart';


class ProductInPurchaseCard extends StatelessWidget {
  final ProductInPurchase productInPurchase;


  ProductInPurchaseCard({Key key, this.productInPurchase}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Text(
              productInPurchase.product.name,
              style: TextStyle(
                fontSize: 40,
                color: Theme.of(context).primaryColor,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.left,
            ),
            Text(
                productInPurchase.quantity.toString(),
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              textAlign: TextAlign.left,
            ),
            Text(
              productInPurchase.finalPrice.toString(),
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }
}//ProductCard