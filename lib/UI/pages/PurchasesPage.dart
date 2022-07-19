import 'package:flutter/material.dart';

import '../../model/objects/Purchase.dart';
import '../widgets/PurchaseCard.dart';
import 'PurchasePage.dart';

class PurchasesPage extends StatefulWidget{
  PurchasesPage({Key key, this.purchases}) : super (key : key);
  final List<Purchase> purchases;

  @override
  _PurchasesPageState createState() => _PurchasesPageState();

}

class _PurchasesPageState extends State<PurchasesPage> {

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
                          "Purchases",
                          style: TextStyle(
                            fontSize: 50,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.fromLTRB(0, 10, 10, 0),
                          child: SizedBox.shrink(
                            child: Container(
                              child: ListView.builder(
                                itemCount: widget.purchases.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    child: PurchaseCard(
                                      purchase: widget.purchases[index],
                                    ),
                                    onTap: () => _getPurchase(widget.purchases[index]),
                                  );
                                },
                              ),
                            ),
                          )
                      )
                    ]
                )
            )
        )
    );
  }

  void _getPurchase(Purchase purchase){
    setState((){
      Navigator.push(context, new MaterialPageRoute(builder: (context) => new PurchasePage(purchase: purchase)));
    });

  }




}