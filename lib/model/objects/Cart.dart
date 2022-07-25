import 'User.dart';
import 'ProductInCart.dart';
import 'ProductInPromoInCart.dart';

class Cart {
  int id;
  User buyer;
  List<ProductInCart> products;
  List<ProductInPromoInCart> productsInPromo;
  double total;

  Cart({this.id, this.buyer, this.products, this.productsInPromo, this.total});

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
      buyer: User.fromJson(json['buyer']),
      products: products,
      productsInPromo: productsInPromo,
      total: json['total']
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'buyer': buyer.toJson(),
    'products': products.map((e) => e.toJson()).toList(),
    'productsInPromo': productsInPromo.map((e) => e.toJson()).toList(),
    'total': total
  };

}//Cart