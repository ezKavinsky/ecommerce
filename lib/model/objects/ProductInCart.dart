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
        cart: json['cart'],
        product: json['product'],
        quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'cart': cart,
    'product': product,
    'quantity': quantity
  };

}//ProductInCart