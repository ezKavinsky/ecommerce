import 'package:ecommerce/UI/widgets/CircularIconButton.dart';
import 'package:ecommerce/UI/widgets/InputField.dart';
import 'package:ecommerce/model/Model.dart';
import 'package:ecommerce/model/objects/Purchase.dart';
import 'package:flutter/material.dart';
import '../../model/objects/Cart.dart';
import '../../model/objects/Product.dart';
import '../../model/objects/ProductInPromo.dart';
import '../widgets/ProductInCartCard.dart';
import '../widgets/ProductInPromoInCartCard.dart';
import 'ProductInPromoPage.dart';
import 'ProductPage.dart';
import 'PurchasePage.dart';

class CartPage extends StatefulWidget{
  CartPage({Key key, this.cart}) : super (key : key);
  final Cart cart;

  @override
  _CartPageState createState() => _CartPageState();

}

class _CartPageState extends State<CartPage>{
  Purchase _purchase = null;
  TextEditingController _quantityProductController = TextEditingController();
  TextEditingController _quantityProductInPromoController = TextEditingController();

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
                        child: widget.cart.products.length <= 0 ? Text("Empty") : Container(
                          child: ListView.builder(
                            itemCount: widget.cart.products.length,
                            itemBuilder: (context, index) {
                              return Column(
                                  children: [
                                    GestureDetector(
                                      child: ProductInCartCard(
                                        productInCart: widget.cart.products[index],
                                      ),
                                      onTap: () => _getProduct(widget.cart.products[index].product),
                                    ),
                                    Row(
                                      children: [
                                        CircularIconButton(
                                          icon: Icons.remove_shopping_cart_outlined,
                                          onPressed: () {
                                            _removeProduct(widget.cart.id.toString(), widget.cart.products[index].id.toString());
                                          },
                                        ),
                                        Row(
                                          children: [
                                            CircularIconButton(
                                              icon: Icons.add,
                                              onPressed: () {
                                                int quantity = int.parse(_quantityProductController.text);
                                                _updateQuantityProduct(widget.cart.id.toString(), widget.cart.products[index].id.toString(), quantity);
                                              },
                                            ),
                                            InputField(
                                              labelText: "Quantity",
                                              controller: _quantityProductController,
                                            ),
                                            CircularIconButton(
                                              icon: Icons.remove,
                                              onPressed: () {
                                                int quantity = -int.parse(_quantityProductController.text);
                                                _updateQuantityProduct(widget.cart.id.toString(), widget.cart.products[index].id.toString(), quantity);
                                              },
                                            ),
                                          ],
                                        )
                                      ],
                                    )
                                  ]
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
                        child: widget.cart.productsInPromo.length <= 0 ? Text("Empty") : Container(
                          child: ListView.builder(
                            itemCount: widget.cart.productsInPromo.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                              GestureDetector(
                              child: ProductInPromoInCartCard(
                              productInPromoInCart: widget.cart.productsInPromo[index],
                              ),
                              onTap: () => _getProductInPromo(widget.cart.productsInPromo[index].productInPromo),
                              ),
                                  Row(
                                    children: [
                                      CircularIconButton(
                                        icon: Icons.remove_shopping_cart_outlined,
                                        onPressed: () {
                                          _removeProductInPromo(widget.cart.id.toString(), widget.cart.productsInPromo[index].id.toString());
                                        },
                                      ),
                                      Row(
                                        children: [
                                          CircularIconButton(
                                            icon: Icons.add,
                                            onPressed: () {
                                              int quantity = int.parse(_quantityProductInPromoController.text);
                                              _updateQuantityProductInPromo(widget.cart.id.toString(), widget.cart.productsInPromo[index].id.toString(), quantity);
                                            },
                                          ),
                                          InputField(
                                            labelText: "Quantity",
                                            controller: _quantityProductInPromoController,
                                          ),
                                          CircularIconButton(
                                            icon: Icons.remove,
                                            onPressed: () {
                                              int quantity = -int.parse(_quantityProductInPromoController.text);
                                              _updateQuantityProduct(widget.cart.id.toString(), widget.cart.productsInPromo[index].id.toString(), quantity);
                                            },
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                                ]
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
      setState((){
        Navigator.push(context, new MaterialPageRoute(builder: (context) => new PurchasePage(purchase : _purchase)));
      });
    });
  }

  void _clear(String id1){
    Model.sharedInstance.clearCart(id1).then((result) {
      setState((){});
    });
  }

  void _removeProductInPromo(String id1, String id2) {
    Model.sharedInstance.removeProductInPromo(id1, id2).then((result) {
      setState(() {});
    });
  }
    void _removeProduct(String id1, String id2) {
      Model.sharedInstance.removeProduct(id1, id2).then((result) {
        setState(() {});
      });
    }

    void _updateQuantityProduct(String id1, String id2, int quantity){
    Model.sharedInstance.updateProductQuantity(id1, id2, quantity).then((result) {
      setState((){});
    });
    }

  void _updateQuantityProductInPromo(String id1, String id2, int quantity){
    Model.sharedInstance.updateProductInPromoQuantity(id1, id2, quantity).then((result) {
      setState((){});
    });
  }

  }