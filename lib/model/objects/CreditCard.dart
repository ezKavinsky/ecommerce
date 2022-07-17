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
    return CreditCard(
        id: json['id'],
        number: json['number'],
        expirationMonth: json['expirationMonth'],
        expirationYear: json['expirationYear'],
        owner: json['owner'],
        purchases: json['purchases']
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'number': number,
    'expirationMonth': expirationMonth,
    'expirationYear': expirationYear,
    'owner': owner,
    'purchases': purchases
  };

  @override
  String toString() {
    return number;
  }

}//CreditCard