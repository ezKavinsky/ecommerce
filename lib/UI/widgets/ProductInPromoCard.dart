import 'package:ecommerce/model/objects/ProductInPromo.dart';
import 'package:flutter/material.dart';


class ProductInPromoCard extends StatelessWidget {
  final ProductInPromo productInPromo;


  ProductInPromoCard({Key key, this.productInPromo}) : super(key: key);

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
              productInPromo.product.name,
              style: TextStyle(
                fontSize: 40,
                color: Theme.of(context).primaryColor,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.left,
            ),
            Text(
                productInPromo.discountPrice.toString(),
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
}//ProductInPromoCard