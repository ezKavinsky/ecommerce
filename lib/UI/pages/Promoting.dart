import 'package:ecommerce/UI/widgets/CircularIconButton.dart';
import 'package:flutter/material.dart';
import '../../model/Model.dart';
import '../../model/objects/Promo.dart';
import '../widgets/PromoCard.dart';
import 'PromoPage.dart';

class Promoting extends StatefulWidget {
  Promoting({Key key}) : super(key: key);


  @override
  _PromotingState createState() => _PromotingState();
}

class _PromotingState extends State<Promoting> {
  List<Promo> _promos;
  bool _loading = true;

  bool _getPromos() {
    setState(() {
      _promos = null;
    });
    Model.sharedInstance.showPromos().then((result) {
      setState((){
       _promos = result;
       _loading = false;
      });
    });
    return _loading;
  }

  Widget _showPromos(){
    _loading = _getPromos();
    if(!_loading){
      return Padding(
          padding: EdgeInsets.fromLTRB(0, 10, 10, 0),
          child: SizedBox.shrink(
            child: Container(
              child: ListView.builder(
                itemCount: _promos.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    child: PromoCard(
                      promo: _promos[index],
                    ),
                    onTap: () => _getPromo(_promos[index]),
                  );
                },
              ),
            ),
          )
      );
    }
    return CircularIconButton(
      icon: Icons.home_rounded,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
            child : Column(
                children: [
                  Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Text(
                    "Promos",
                    style: TextStyle(
                    fontSize: 50,
                    color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                  _showPromos()
          ]
    )
    )
    )
      );
  }

  void _getPromo(Promo promo){
    setState((){
      Navigator.push(context, new MaterialPageRoute(builder: (context) => new PromoPage(promo: promo)));
    });
  }

}