import 'Cart.dart';
import 'Product.dart';

class ProductInCart {
  int id;
  Cart cart;
  Product product;
  int quantity;

  ProductInCart({this.id, this.cart, this.product, this.quantity});

  factory ProductInCart.fromJson(Map<String, dynamic> json){
    return ProductInCart(
        id: json['id'],
        cart: Cart.fromJson(json['cart']),
        product: Product.fromJson(json['product']),
        quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'cart': cart.toJson(),
    'product': product.toJson(),
    'quantity': quantity
  };

}//ProductInCart