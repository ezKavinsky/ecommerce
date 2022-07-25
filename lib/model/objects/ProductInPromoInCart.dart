import 'ProductInPromo.dart';

class ProductInPromoInCart {
  int id;
  ProductInPromo productInPromo;
  int quantity;

  ProductInPromoInCart({this.id, this.productInPromo, this.quantity});

  factory ProductInPromoInCart.fromJson(Map<String, dynamic> json){
    return ProductInPromoInCart(
      id: json['id'],
      productInPromo: ProductInPromo.fromJson(json['productInPromo']),
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'productInPromo': productInPromo.toJson(),
    'quantity': quantity
  };

}//ProductInCart