import 'package:ecommerce/UI/widgets/CircularIconButton.dart';
import 'package:ecommerce/UI/widgets/InputField.dart';
import 'package:ecommerce/UI/widgets/ReviewCard.dart';
import 'package:ecommerce/model/Model.dart';
import 'package:ecommerce/model/objects/User.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../model/objects/Cart.dart';
import '../../model/objects/Product.dart';
import '../../model/objects/Review.dart';
import 'Account.dart';
import 'CartPage.dart';
import 'ReviewPage.dart';

class ProductPage extends StatefulWidget{
  ProductPage({Key key, this.product, this.user}) : super (key : key);
  final Product product;
  final User user;

  @override
  _ProductPageState createState() => _ProductPageState();

}

class _ProductPageState extends State<ProductPage>{
  TextEditingController _quantityController = TextEditingController();
  List<Review> _reviews = null;
  Review _review = null;

  @override
  void initState(){
    super.initState();
    Model.sharedInstance.getReviews(widget.product.id.toString()).then((result){
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
                widget.product.brand,
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 30
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                widget.product.name,
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontStyle: FontStyle.italic,
                    fontSize: 50
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                widget.product.barCode,
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 30
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                widget.product.price.toString() + "€",
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 30
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                "Quantity = " + widget.product.quantity.toString(),
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 15
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                "Shipping = " + widget.product.shippingPrice.toString() + "€",
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 15
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                widget.product.productionYear.toString(),
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 15
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                widget.product.description,
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 15
                ),
                textAlign: TextAlign.center,
              ),
              Expanded(child: Column(
                      children: [
                        Flexible(
                            child: InputField(
                              labelText: "Quantity to buy",
                              controller: _quantityController,
                            ),
                        ),
                        CircularIconButton(
                          icon: Icons.add_shopping_cart,
                          onPressed: () {
                            widget.user == null ?
                            Text(
                              "Devi prima effettuare il login!",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 15
                              ),
                            ) :
                            _addToCart(widget.product.id.toString(), _quantityController.text);
                          }
                        )
                      ],
                    )
                    ),

              Align(
                alignment: Alignment.center,
                    child: SizedBox(
                      height: 40,
                      child: RatingBarIndicator(
                        rating: widget.product.score,
                        itemBuilder: (context,index) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        itemCount: 5,
                        itemSize: 50.0,
                        direction: Axis.horizontal,
                      ),
                    )

                ),
              Expanded(child: Column(
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
                           onTap: () => _getReview(widget.product.id.toString(), _reviews[index].id.toString()),
                         );
                       },
                     ),
                   ),
                 ),
               ],
             )
              )
              ],
          ),
        ),
      ),
      );
  }

  void _addToCart(String id, String quantity){
    Cart cart = widget.user.cart;
    Model.sharedInstance.addProductToCart(id, cart.id.toString(), quantity.toString()).then((result) {
      setState((){
        cart = result;
        Navigator.push(context, new MaterialPageRoute(builder: (context) => new CartPage(cart : cart, user: widget.user)));
      });
    });

  }

  void _getReview(String id1, String id2){
    Model.sharedInstance.getReview(id1, id2).then((result) {
      _review = result;
      setState((){
        Navigator.push(context, new MaterialPageRoute(builder: (context) => new ReviewPage(review : _review, user: widget.user)));
      });
    });
  }
}