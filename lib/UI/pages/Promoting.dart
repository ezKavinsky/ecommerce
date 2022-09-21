import 'package:ecommerce/UI/widgets/CircularIconButton.dart';
import 'package:ecommerce/model/objects/User.dart';
import 'package:flutter/material.dart';
import '../../model/Model.dart';
import '../../model/objects/Promo.dart';
import '../widgets/PromoCard.dart';
import 'PromoPage.dart';

class Promoting extends StatefulWidget {
  Promoting({Key key, this.user}) : super(key: key);
  final User user;
  @override
  _PromotingState createState() => _PromotingState();
}

class _PromotingState extends State<Promoting> {
  List<Promo> _promos = null;

  @override
  void initState() {
    super.initState();
    Model.sharedInstance.showPromos().then((result) {
      setState((){
       _promos = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
              Expanded(
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
          ]
    )
      )
    );
  }

  void _getPromo(Promo promo){
    setState((){
      Navigator.push(context, new MaterialPageRoute(builder: (context) => new PromoPage(promo: promo, user: widget.user)));
    });
  }

}