import 'ProductInCart.dart';
import 'ProductInPromoInCart.dart';

class Cart {
  int id;
  double total;

  Cart({this.id, this.total});

  factory Cart.fromJson(Map<String, dynamic> json){
    return Cart(
      id: json['id'],
      total: json['total']
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'total': total
  };

}//Cart