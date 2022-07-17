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
        promo: json['promo'],
        product: json['product'],
        productsInPromoPurchase: json['productsInPromoPurchase'],
        productInPromoInCarts: json['productInPromoInCarts'],
        discountPrice: json['discountPrice']
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'promo': promo,
    'product': product,
    'productsInPromoPurchase': productsInPromoPurchase,
    'productsInPromoInCarts': productInPromoInCarts,
    'discountPrice': discountPrice
  };

  @override
  String toString() {
    return product.toString();
  }
}//Product