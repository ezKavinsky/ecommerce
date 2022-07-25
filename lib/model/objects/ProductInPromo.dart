import 'package:ecommerce/model/objects/ProductInPromoInCart.dart';
import 'package:ecommerce/model/objects/ProductInPromoPurchase.dart';

import 'Promo.dart';
import 'Product.dart';

class ProductInPromo {
  int id;
  Promo promo;
  Product product;
  ProductInPromoPurchase productsInPromoPurchase;
  ProductInPromoInCart productInPromoInCarts;
  double discountPrice;

  ProductInPromo({this.id, this.promo, this.product, this.productsInPromoPurchase, this.productInPromoInCarts, this.discountPrice});

  factory ProductInPromo.fromJson(Map<String, dynamic> json) {
    return ProductInPromo(
        id: json['id'],
        promo: Promo.fromJson(json['promo']),
        product: Product.fromJson(json['product']),
        productsInPromoPurchase: ProductInPromoPurchase.fromJson(json['productInPromoPurchase']),
        productInPromoInCarts: ProductInPromoInCart.fromJson(json['productInPromoInCarts']),
        discountPrice: json['discountPrice']
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'promo': promo.toJson(),
    'product': product.toJson(),
    'productsInPromoPurchase': productsInPromoPurchase.toJson(),
    'productsInPromoInCarts': productInPromoInCarts.toJson(),
    'discountPrice': discountPrice
  };

  @override
  String toString() {
    return product.toString();
  }
}//Product