import 'package:ecommerce/model/objects/ProductInPromoPurchase.dart';
import 'package:flutter/material.dart';


class ProductInPromoPurchaseCard extends StatelessWidget {
  final ProductInPromoPurchase productInPromoPurchase;


  ProductInPromoPurchaseCard({Key key, this.productInPromoPurchase}) : super(key: key);

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
              productInPromoPurchase.productInPromo.product.name,
              style: TextStyle(
                fontSize: 40,
                color: Theme.of(context).primaryColor,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.left,
            ),
            Text(
                productInPromoPurchase.quantity.toString(),
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              textAlign: TextAlign.left,
            ),
            Text(
              productInPromoPurchase.finalPrice.toString(),
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
}//ProductInPromoPurchaseCard