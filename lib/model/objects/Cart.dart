import 'ProductInCart.dart';
import 'ProductInPromoInCart.dart';

class Cart {
  int id;
  List<ProductInCart> products;
  List<ProductInPromoInCart> productsInPromo;
  double total;

  Cart({this.id, this.products, this.productsInPromo, this.total});

  factory Cart.fromJson(Map<String, dynamic> json){
    List<ProductInPromoInCart> productsInPromo = List();
    for(Map<String, dynamic> rawProductInPromo in json['productsInPromo']){
      productsInPromo.add(ProductInPromoInCart.fromJson(rawProductInPromo));
    }
    List<ProductInCart> products = List();
    for(Map<String, dynamic> rawProduct in json['products']){
      products.add(ProductInCart.fromJson(rawProduct));
    }
    return Cart(
      id: json['id'],
      products: products,
      productsInPromo: productsInPromo,
      total: json['total']
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'products': products.map((e) => e.toJson()).toList(),
    'productsInPromo': productsInPromo.map((e) => e.toJson()).toList(),
    'total': total
  };

}//Cart