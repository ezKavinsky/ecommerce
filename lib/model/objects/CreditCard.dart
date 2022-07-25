import 'Purchase.dart';
import 'User.dart';

class CreditCard {
  int id;
  String number;
  int expirationMonth;
  int expirationYear;
  int securityCode;
  User owner;
  List<Purchase> purchases;

  CreditCard({this.id, this.number, this.expirationMonth, this.expirationYear, this.securityCode, this.owner, this.purchases});

  factory CreditCard.fromJson(Map<String, dynamic> json) {
    List<Purchase> purchases = List();
    for(Map<String, dynamic> rawPurchase in json['purchases']){
      purchases.add(Purchase.fromJson(rawPurchase));
    }
    return CreditCard(
        id: json['id'],
        number: json['number'],
        expirationMonth: json['expirationMonth'],
        expirationYear: json['expirationYear'],
        owner: User.fromJson(json['owner']),
        purchases: purchases
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'number': number,
    'expirationMonth': expirationMonth,
    'expirationYear': expirationYear,
    'owner': owner.toJson(),
    'purchases': purchases.map((e) => e.toJson()).toList()
  };

  @override
  String toString() {
    return number;
  }

}//CreditCard