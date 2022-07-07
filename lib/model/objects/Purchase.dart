import 'User.dart';
import 'ProductInPurchase.dart';
import 'CreditCard.dart';
import 'ProductInPromoPurchase.dart';

class Purchase {
  int id;
  DateTime purchaseTime;
  User buyer;
  CreditCard creditCard;
  List<ProductInPurchase> productsInPurchase;
  List<ProductInPromoPurchase> productsInPromoPurchase;
  double total;
  bool shipped;

  Purchase({this.id, this.purchaseTime, this.buyer, this.creditCard, this.productsInPurchase, this.productsInPromoPurchase, this.total, this.shipped});

  factory Purchase.fromJson(Map<String, dynamic> json) {
    return Purchase(
        id: json['id'],
        purchaseTime: json['purchaseTime'],
        buyer: json['buyer'],
        creditCard: json['creditCard'],
        productsInPromoPurchase: json['productsInPromoPurchase'],
        productsInPurchase: json['productsInPurchase']
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'purchaseTime': purchaseTime,
    'buyer': buyer,
    'creditCard': creditCard,
    'productsInPurchase': productsInPurchase,
    'productsInPromoPurchase' : productsInPromoPurchase
  };

  @override
  String toString() {
    return buyer.toString() + ", " + purchaseTime.toString();
  }
}//Product