import 'package:flutter/material.dart';
import '../../model/Model.dart';
import '../../model/objects/Promo.dart';
import '../widgets/PromoCard.dart';

class Promoting extends StatefulWidget {
  Promoting({Key key}) : super(key: key);


  @override
  _PromotingState createState() => _PromotingState();
}

class _PromotingState extends State<Promoting> {
  List<Promo> _promos;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _getPromos(),
      ),
    );
  }

  Widget _getPromos() {
    _get();
    return Expanded(
      child: Container(
        child: ListView.builder(
          itemCount: _promos.length,
          itemBuilder: (context, index) {
            return PromoCard(
              promo: _promos[index],
            );
          },
        ),
      ),
    );
  }

  void _get() {
    Model.sharedInstance.showPromos().then((result) {
      setState(() {
        _promos = result;
      });
    });
  }

}