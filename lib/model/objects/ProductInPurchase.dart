import 'Product.dart';

class ProductInPurchase {
  int id;
  int quantity;
  double finalPrice;
  Product product;

  ProductInPurchase({this.id, this.quantity, this.finalPrice, this.product});

  factory ProductInPurchase.fromJson(Map<String, dynamic> json) {
    return ProductInPurchase(
        id: json['id'],
        quantity: json['quantity'],
        finalPrice: json['finalPrice'],
        product: Product.fromJson(json['product'])
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'quantity': quantity,
    'product': product.toJson()
  };

  @override
  String toString() {
    return product.toString();
  }
}//Product