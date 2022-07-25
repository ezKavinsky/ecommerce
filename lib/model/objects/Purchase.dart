import 'User.dart';
import 'ProductInPurchase.dart';
import 'CreditCard.dart';
import 'ProductInPromoPurchase.dart';

class Purchase {
  int id;
  String purchaseTime;
  User buyer;
  CreditCard creditCard;
  List<ProductInPurchase> productsInPurchase;
  List<ProductInPromoPurchase> productsInPromoPurchase;
  double total;
  bool shipped;

  Purchase({this.id, this.purchaseTime, this.buyer, this.creditCard, this.productsInPurchase, this.productsInPromoPurchase, this.total, this.shipped});

  factory Purchase.fromJson(Map<String, dynamic> json) {
    List<ProductInPurchase> productsInPurchase = List();
    for(Map<String, dynamic> rawProductInPurchase in json['productsInPurchase']){
      productsInPurchase.add(ProductInPurchase.fromJson(rawProductInPurchase));
    }
    List<ProductInPromoPurchase> productsInPromoPurchase = List();
    for(Map<String, dynamic> rawProductInPromoPurchase in json['productsInPromoPurchase']){
      productsInPromoPurchase.add(ProductInPromoPurchase.fromJson(rawProductInPromoPurchase));
    }
    return Purchase(
        id: json['id'],
        purchaseTime: json['purchaseTime'],
        buyer: User.fromJson(json['buyer']),
        creditCard: CreditCard.fromJson(json['creditCard']),
        productsInPurchase: productsInPurchase,
        productsInPromoPurchase: productsInPromoPurchase,
        total: json['total'],
        shipped: json['shipped']
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'purchaseTime': purchaseTime,
    'buyer': buyer.toJson(),
    'creditCard': creditCard.toJson(),
    'productsInPurchase': productsInPurchase.map((e) => e.toJson()).toList(),
    'productsInPromoPurchase' : productsInPromoPurchase.map((e) => e.toJson()).toList(),
    'total' : total,
    'shipped' : shipped
  };

  @override
  String toString() {
    return buyer.toString() + ", " + purchaseTime;
  }
}//Product