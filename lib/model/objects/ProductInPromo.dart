import 'Product.dart';
import 'Promo.dart';

class ProductInPromo {
  int id;
  Promo promo;
  Product product;
  double discountPrice;

  ProductInPromo({this.id, this.promo, this.product, this.discountPrice});

  factory ProductInPromo.fromJson(Map<String, dynamic> json) {
    return ProductInPromo(
        id: json['id'],
        promo: Promo.fromJson(json['promo']),
        product: Product.fromJson(json['product']),
        discountPrice: json['discountPrice']
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'promo' : promo.toJson(),
    'product': product.toJson(),
    'discountPrice': discountPrice
  };

  @override
  String toString() {
    return product.toString();
  }
}//Product