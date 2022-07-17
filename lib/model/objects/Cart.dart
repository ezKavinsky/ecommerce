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
    return Cart(
      id: json['id'],
      buyer: json['buyer'],
      products: json['products'],
      productsInPromo: json['productsInPromo'],
      total: json['total']
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'buyer': buyer,
    'products': products,
    'productsInPromo': productsInPromo,
    'total': total
  };

}//Cart