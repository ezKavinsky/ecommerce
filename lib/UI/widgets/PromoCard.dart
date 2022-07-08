import 'package:ecommerce/model/objects/Promo.dart';
import 'package:flutter/material.dart';


class PromoCard extends StatelessWidget {
  final Promo promo;


  PromoCard({Key key, this.promo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Text(
          promo.name,
          style: TextStyle(
            fontSize: 40,
            color: Theme.of(context).primaryColor,
          ),
          textAlign: TextAlign.left,
        ),
      ),
    );
  }
}//PurchaseCard