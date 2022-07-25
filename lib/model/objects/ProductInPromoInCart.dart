import 'ProductInPromo.dart';
import 'Cart.dart';


class ProductInPromoInCart {
  int id;
  Cart cart;
  ProductInPromo productInPromo;
  int quantity;

  ProductInPromoInCart({this.id, this.cart, this.productInPromo, this.quantity});

  factory ProductInPromoInCart.fromJson(Map<String, dynamic> json){
    return ProductInPromoInCart(
      id: json['id'],
      cart: Cart.fromJson(json['cart']),
      productInPromo: ProductInPromo.fromJson(json['productInPromo']),
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'cart': cart.toJson(),
    'productInPromo': productInPromo.toJson(),
    'quantity': quantity
  };

}//ProductInCart