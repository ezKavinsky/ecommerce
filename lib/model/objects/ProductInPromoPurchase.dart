import 'ProductInPromo.dart';

class ProductInPromoPurchase {
  int id;
  int quantity;
  double finalPrice;
  ProductInPromo productInPromo;

  ProductInPromoPurchase({this.id, this.quantity, this.finalPrice, this.productInPromo});

  factory ProductInPromoPurchase.fromJson(Map<String, dynamic> json) {
    return ProductInPromoPurchase(
        id: json['id'],
        quantity: json['quantity'],
        finalPrice: json['finalPrice'],
        productInPromo: ProductInPromo.fromJson(json['productInPromo'])
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'quantity': quantity,
    'productInPromo': productInPromo.toJson()
  };

  @override
  String toString() {
    return productInPromo.toString();
  }
}//Product