import 'package:ecommerce/UI/widgets/CircularIconButton.dart';
import 'package:ecommerce/UI/widgets/InputField.dart';
import 'package:ecommerce/UI/widgets/ReviewCard.dart';
import 'package:ecommerce/model/Model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../model/objects/Cart.dart';
import '../../model/objects/ProductInPromo.dart';
import '../../model/objects/Promo.dart';
import '../../model/objects/Review.dart';
import 'Account.dart';
import 'CartPage.dart';
import 'ReviewPage.dart';

class ProductInPromoPage extends StatefulWidget{
  ProductInPromoPage({Key key, this.productInPromo}) : super (key : key);
  final ProductInPromo productInPromo;

  @override
  _ProductInPromoPageState createState() => _ProductInPromoPageState();

}

class _ProductInPromoPageState extends State<ProductInPromoPage>{
  TextEditingController _quantityController = TextEditingController();
  List<Review> _reviews = null;
  Review _review = null;
  Cart _cart = null;

  @override
  void initState(){
    super.initState();
    Model.sharedInstance.getReviews(widget.productInPromo.product.id.toString()).then((result){
      setState((){
        _reviews = result;
      });
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(0, 10, 10, 0),
        child: Center(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child:  CircularIconButton(
                  icon: Icons.arrow_back,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Text(
                widget.productInPromo.product.brand,
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 30
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                widget.productInPromo.product.name,
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontStyle: FontStyle.italic,
                    fontSize: 50
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                widget.productInPromo.product.barCode,
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 30
                ),
                textAlign: TextAlign.center,
              ),
              Row(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: [
                        Text(
                          widget.productInPromo.discountPrice.toString(),
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 30
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          widget.productInPromo.product.quantity.toString(),
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 15
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Flexible(
                        child: InputField(
                          labelText: "Quantity to buy",
                          controller: _quantityController,
                          onSubmit: () {
                            _addToCart(widget.productInPromo.id.toString(), widget.productInPromo.promo.id.toString(), int.parse(_quantityController.text));
                          },
                        ),
                      ),
                      CircularIconButton(
                          icon: Icons.add_shopping_cart,
                          onPressed: () {
                            _addToCart(widget.productInPromo.id.toString(), widget.productInPromo.promo.id.toString(), int.parse(_quantityController.text));
                          }
                      )
                    ],
                  )
                ],
              ),
              Align(
                alignment: Alignment.center,
                child: Row(
                  children: [
                    Text(
                      widget.productInPromo.product.freeShipping ? "Yes" : Text(
                        widget.productInPromo.product.shippingPrice.toString(),
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 30
                        ),
                        textAlign: TextAlign.center,
                      ),
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 30
                      ),
                      textAlign: TextAlign.center,
                    ),
                    RatingBarIndicator(
                      rating: widget.productInPromo.product.score,
                      itemBuilder: (context,index) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      itemCount: 5,
                      itemSize: 50.0,
                      direction: Axis.horizontal,
                    ),
                  ],
                ),
              ),
              Text(
                widget.productInPromo.product.productionYear.toString(),
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 15
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                widget.productInPromo.product.description,
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 15
                ),
                textAlign: TextAlign.center,
              ),
              Column(
                children: [
                  Text(
                    "Reviews",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 50,
                        fontStyle: FontStyle.italic
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: ListView.builder(
                        itemCount: _reviews.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            child: ReviewCard(
                              review: _reviews[index],
                            ),
                            onTap: () => _getReview(widget.productInPromo.product.id.toString(), _reviews[index].id.toString()),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _addToCart(String id1, String id2, int quantity){
    Account user = Account();
    _cart = user.getUser().cart;
    Model.sharedInstance.addProductInPromoToCart(id1, id2, _cart.id.toString(), quantity).then((result) {
      setState((){
        Navigator.push(context, new MaterialPageRoute(builder: (context) => new CartPage(cart : _cart)));
      });
    });
  }

  void _getReview(String id1, String id2){
    Model.sharedInstance.getReview(id1, id2).then((result) {
      _review = result;
      setState((){
        Navigator.push(context, new MaterialPageRoute(builder: (context) => new ReviewPage(review : _review)));
      });
    });
  }
}