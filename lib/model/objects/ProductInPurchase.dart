import 'Product.dart';
import 'Purchase.dart';

class ProductInPurchase {
  int id;
  Purchase purchase;
  int quantity;
  double finalPrice;
  Product product;

  ProductInPurchase({this.id, this.purchase, this.quantity, this.finalPrice, this.product});

  factory ProductInPurchase.fromJson(Map<String, dynamic> json) {
    return ProductInPurchase(
        id: json['id'],
        purchase: Purchase.fromJson(json['purchase']),
        quantity: json['quantity'],
        finalPrice: json['finalPrice'],
        product: Product.fromJson(json['product'])
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'purchase': purchase.toJson(),
    'quantity': quantity,
    'product': product.toJson()
  };

  @override
  String toString() {
    return product.toString();
  }
}//Product