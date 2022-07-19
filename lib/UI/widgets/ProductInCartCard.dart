import '../../model/objects/ProductInCart.dart';
import 'package:flutter/material.dart';

class ProductInCartCard extends StatelessWidget {
  final ProductInCart productInCart;


  ProductInCartCard({Key key, this.productInCart}) : super(key: key);

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
              productInCart.product.name,
              style: TextStyle(
                fontSize: 40,
                color: Theme.of(context).primaryColor,
                fontStyle: FontStyle.italic,
              ),
            ),
            Text(
                "price: " + productInCart.product.price.toString(),
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                )
            ),
            Text(
              "quantity: " + productInCart.product.quantity.toString(),
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}//ProductInCartCard