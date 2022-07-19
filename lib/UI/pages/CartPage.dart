import 'package:ecommerce/UI/widgets/CircularIconButton.dart';
import 'package:ecommerce/model/Model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../model/objects/Cart.dart';
import '../../model/objects/Product.dart';
import '../../model/objects/ProductInCart.dart';
import '../../model/objects/ProductInPromo.dart';
import '../../model/objects/ProductInPromoInCart.dart';
import '../widgets/ProductInCartCard.dart';
import '../widgets/ProductInPromoInCartCard.dart';
import 'ProductPage.dart';

class CartPage extends StatefulWidget{
  CartPage({Key key, this.cart}) : super (key : key);
  final Cart cart;

  @override
  _CartPageState createState() => _CartPageState();

}

class _CartPageState extends State<CartPage>{
  List<ProductInCart> _products;
  List<ProductInPromoInCart> _productsInPromo;


  @override
  Widget build(BuildContext context){
    return Scaffold(
        body: Padding(
          padding: EdgeInsets.fromLTRB(0, 10, 10, 0),
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
                  "Cart",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 50,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Column(
                  children: [
                    Text(
                      "Products",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 30,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    Expanded(
                        child: Container(
                          child: ListView.builder(
                            itemCount: _products.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                child: ProductInCartCard(
                                  productInCart: _products[index],
                                ),
                                onTap: () => _getProduct(_products[index].product),
                              );
                            },
                          ),
                        )
                    ),
                    Text(
                      "Products in promo",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 30,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    Expanded(
                        child: Container(
                          child: ListView.builder(
                            itemCount: _productsInPromo.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                child: ProductInPromoInCartCard(
                                  productInPromoInCart: _productsInPromo[index],
                                ),
                                onTap: () => _getProductInPromo(_productsInPromo[index].productInPromo),
                              );
                            },
                          ),
                        )
                    )
                  ],
                )
              ]
          ),
        )
    );
  }

  void _getProduct(Product product) {
    setState(() {
      Navigator.push(context, new MaterialPageRoute(builder: (context) => new ProductPage(product: product)));
    });
  }

  void _getProductInPromo(ProductInPromo productInPromo) {
    setState(() {
      Navigator.push(context, new MaterialPageRoute(builder: (context) => new ProductInPromoPage(productInPromo : productInPromo)));
    });
  }
}