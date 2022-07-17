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
        purchase: json['purchase'],
        quantity: json['quantity'],
        finalPrice: json['finalPrice'],
        productInPromo: json['productInPromo']
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'purchase': purchase,
    'quantity': quantity,
    'productInPromo': productInPromo
  };

  @override
  String toString() {
    return productInPromo.toString();
  }
}//Product