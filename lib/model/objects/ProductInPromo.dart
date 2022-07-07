import 'Promo.dart';
import 'Product.dart';

class ProductInPromo {
  int id;
  Promo promo;
  Product product;
  double discountPrice;

  ProductInPromo({this.id, this.promo, this.product, this.discountPrice});

  factory ProductInPromo.fromJson(Map<String, dynamic> json) {
    return ProductInPromo(
        id: json['id'],
        promo: json['promo'],
        product: json['product'],
        discountPrice: json['discountPrice']
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'promo': promo,
    'product': product,
    'discountPrice': discountPrice
  };

  @override
  String toString() {
    return product.toString();
  }
}//Product