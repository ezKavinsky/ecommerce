import 'package:ecommerce/UI/widgets/CircularIconButton.dart';
import 'package:ecommerce/UI/widgets/InputField.dart';
import 'package:ecommerce/model/Model.dart';
import 'package:ecommerce/model/objects/ProductInCart.dart';
import 'package:ecommerce/model/objects/Purchase.dart';
import 'package:flutter/material.dart';
import '../../model/objects/Cart.dart';
import '../../model/objects/Product.dart';
import '../../model/objects/ProductInPromo.dart';
import '../../model/objects/ProductInPromoInCart.dart';
import '../../model/objects/User.dart';
import '../widgets/ProductInCartCard.dart';
import '../widgets/ProductInPromoInCartCard.dart';
import 'ProductInPromoPage.dart';
import 'ProductPage.dart';
import 'PurchasePage.dart';

class CartPage extends StatefulWidget{
  CartPage({Key key, this.cart, this.user}) : super (key : key);
  final Cart cart;
  final User user;

  @override
  _CartPageState createState() => _CartPageState();

}

class _CartPageState extends State<CartPage>{
  Purchase _purchase = null;
  List<ProductInCart> _products = null;
  List<ProductInPromoInCart> _productsInPromo = null;
  TextEditingController _quantityProductController = TextEditingController();
  TextEditingController _quantityProductInPromoController = TextEditingController();

  @override
  void initState(){
    super.initState();
    Model.sharedInstance.getProducts(widget.cart.id.toString()).then((result) {
      _products = result;
    });
      Model.sharedInstance.getProductsInPromoInCart(widget.cart.id.toString())
          .then((result) {
        setState(() {
          _productsInPromo = result;
        });
      });
    }


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
                Text(
                      "Products",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 30,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                Expanded(
                        child: _products.length <= 0 ?
                        Text(
                            "Nessun prodotto nel carrello",
                          style: TextStyle(
                            fontSize: 10,
                            color: Theme.of(context).primaryColor,
                          ),
                        ) : Container(
                          child: ListView.builder(
                            itemCount: _products.length,
                            itemBuilder: (context, index) {
                              return Column(
                                  children: [
                                    GestureDetector(
                                      child: ProductInCartCard(
                                        productInCart: _products[index],
                                      ),
                                      onTap: () => _getProduct(_products[index].product),
                                    ),
                                        Text(
                                          "Quantity in cart = " + _products[index].quantity.toString(),
                                          style: TextStyle(
                                          fontSize: 15,
                                          color: Theme.of(context).primaryColor,
                              )
                                        ),
                                        CircularIconButton(
                                          icon: Icons.remove_shopping_cart_outlined,
                                          onPressed: () {
                                            _removeProduct(widget.cart.id.toString(), _products[index].id.toString());
                                          },
                                        ),
                                            CircularIconButton(
                                              icon: Icons.add,
                                              onPressed: () {
                                                _updateQuantityProduct(widget.cart.id.toString(), _products[index].id.toString(), _quantityProductController.text);
                                              },
                                            ),
                                            InputField(
                                              labelText: "Quantity",
                                              controller: _quantityProductController,
                                            ),
                                            CircularIconButton(
                                              icon: Icons.remove,
                                              onPressed: () {
                                                _updateQuantityProduct(widget.cart.id.toString(), _products[index].id.toString(), _quantityProductController.text);
                                              },
                                            ),
                                          ],
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
                    child: _productsInPromo.length <= 0 ?
                    Text(
                        "Nessun articolo in promozione nel carrello",
                      style: TextStyle(
                        fontSize: 15,
                        color: Theme.of(context).primaryColor,
                      ),
                    ) : Container(
                      child: ListView.builder(
                        itemCount: _productsInPromo.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              GestureDetector(
                                child: ProductInPromoInCartCard(
                                  productInPromoInCart: _productsInPromo[index],
                                ),
                                onTap: () => _getProductInPromo(_productsInPromo[index].productInPromo),
                              ),
                              Text(
                                  "Quantity in cart = " + _products[index].quantity.toString(),
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Theme.of(context).primaryColor,
                                  )
                              ),
                              CircularIconButton(
                                icon: Icons.remove_shopping_cart_outlined,
                                onPressed: () {
                                  _removeProductInPromo(widget.cart.id.toString(), _productsInPromo[index].id.toString());
                                },
                              ),
                              CircularIconButton(
                                icon: Icons.add,
                                onPressed: () {
                                  _updateQuantityProductInPromo(widget.cart.id.toString(), _productsInPromo[index].id.toString(), _quantityProductInPromoController.text);
                                },
                              ),
                              InputField(
                                labelText: "Quantity",
                                controller: _quantityProductInPromoController,
                              ),
                              CircularIconButton(
                                icon: Icons.remove,
                                onPressed: () {
                                  _updateQuantityProductInPromo(widget.cart.id.toString(), _productsInPromo[index].id.toString(), _quantityProductInPromoController.text);
                                },
                              ),
                            ],
                          );
                        },
                      ),
                    )
                ),
                Row(
                  children: [
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: CircularIconButton(
                          icon: Icons.remove_shopping_cart,
                          onPressed: () {
                            _clear(widget.cart.id.toString());
                          }
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: CircularIconButton(
                          icon: Icons.shopping_cart_checkout,
                          onPressed: () {
                            _makePurchase(widget.cart.id.toString());
                          }
                      ),
                    )
                  ],
                )

              ],
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

  void _makePurchase(String id1){
    Model.sharedInstance.addPurchase(id1).then((result) {
      _purchase = result;
      print(result);
      setState((){
        Navigator.push(context, new MaterialPageRoute(builder: (context) => new PurchasePage(purchase : _purchase)));
      });
    });
  }

  void _clear(String id1){
    Model.sharedInstance.clearCart(id1).then((result) {
      setState((){
        Model.sharedInstance.getProducts(widget.cart.id.toString()).then((result) {
          _products = result;
        });
        Model.sharedInstance.getProductsInPromoInCart(widget.cart.id.toString())
            .then((result) {
            _productsInPromo = result;
        });
      });
    });
  }

  void _removeProductInPromo(String id1, String id2) {
    Model.sharedInstance.removeProductInPromo(id1, id2).then((result) {
      setState(() {
        Model.sharedInstance.getProducts(widget.cart.id.toString()).then((result) {
          _products = result;
        });
      });
    });
  }
    void _removeProduct(String id1, String id2) {
      Model.sharedInstance.removeProduct(id1, id2).then((result) {
        setState(() {
          Model.sharedInstance.getProductsInPromoInCart(widget.cart.id.toString())
              .then((result) {
            _productsInPromo = result;
          });
        });
      });
    }

    void _updateQuantityProduct(String id1, String id2, String quantity){
    Model.sharedInstance.updateProductQuantity(id1, id2, quantity).then((result) {
      setState((){
        Model.sharedInstance.getProducts(widget.cart.id.toString()).then((result) {
          _products = result;
        });
      });
    });
    }

  void _updateQuantityProductInPromo(String id1, String id2, String quantity){
    Model.sharedInstance.updateProductInPromoQuantity(id1, id2, quantity).then((result) {
      setState((){
        Model.sharedInstance.getProductsInPromoInCart(widget.cart.id.toString())
            .then((result) {
          _productsInPromo = result;
        });
      });
    });
  }

  }