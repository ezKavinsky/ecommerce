import '../../model/objects/ProductInPromoInCart.dart';
import 'package:flutter/material.dart';

class ProductInPromoInCartCard extends StatelessWidget {
  final ProductInPromoInCart productInPromoInCart;


  ProductInPromoInCartCard({Key key, this.productInPromoInCart}) : super(key: key);

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
              productInPromoInCart.productInPromo.product.name,
              style: TextStyle(
                fontSize: 40,
                color: Theme.of(context).primaryColor,
                fontStyle: FontStyle.italic,
              ),
            ),
            Text(
                "price: " + productInPromoInCart.productInPromo.product.price.toString(),
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                )
            ),
            Text(
              "quantity: " + productInPromoInCart.productInPromo.product.quantity.toString(),
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}//ProductInPromoInCartCard