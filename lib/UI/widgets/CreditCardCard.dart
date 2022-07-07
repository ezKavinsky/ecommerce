import 'package:ecommerce/model/objects/CreditCard.dart';
import 'package:flutter/material.dart';


class CreditCardCard extends StatelessWidget {
  final CreditCard creditCard;


  CreditCardCard({Key key, this.creditCard}) : super(key: key);

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
              creditCard.number.toString(),
              style: TextStyle(
                fontSize: 40,
                color: Theme.of(context).primaryColor,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
                creditCard.expirationMonth.toString() + "/" + creditCard.expirationYear.toString(),
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
                textAlign: TextAlign.right,
            ),
          ],
        ),
      ),
    );
  }
}//CreditCardCard
