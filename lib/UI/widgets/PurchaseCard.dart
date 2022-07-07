import 'package:ecommerce/model/objects/Purchase.dart';
import 'package:flutter/material.dart';


class PurchaseCard extends StatelessWidget {
  final Purchase purchase;


  PurchaseCard({Key key, this.purchase}) : super(key: key);

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
              purchase.id.toString(),
              style: TextStyle(
                fontSize: 40,
                color: Theme.of(context).primaryColor,
              ),
              textAlign: TextAlign.left,
            ),
            Text(
                purchase.purchaseTime.toString(),
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              textAlign: TextAlign.left,
            ),
            Text(
              purchase.total.toString(),
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
}//PurchaseCard