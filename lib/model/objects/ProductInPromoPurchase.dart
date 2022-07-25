import 'ProductInPromo.dart';
import 'Purchase.dart';

class ProductInPromoPurchase {
  int id;
  Purchase purchase;
  int quantity;
  double finalPrice;
  ProductInPromo productInPromo;

  ProductInPromoPurchase({this.id, this.purchase, this.quantity, this.finalPrice, this.productInPromo});

  factory ProductInPromoPurchase.fromJson(Map<String, dynamic> json) {
    return ProductInPromoPurchase(
        id: json['id'],
        purchase: Purchase.fromJson(json['purchase']),
        quantity: json['quantity'],
        finalPrice: json['finalPrice'],
        productInPromo: ProductInPromo.fromJson(json['productInPromo'])
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'purchase': purchase.toJson(),
    'quantity': quantity,
    'productInPromo': productInPromo.toJson()
  };

  @override
  String toString() {
    return productInPromo.toString();
  }
}//Product