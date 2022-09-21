import 'User.dart';

class CreditCard {
  int id;
  String number;
  int expirationMonth;
  int expirationYear;
  User owner;

  CreditCard({this.id, this.number, this.expirationMonth, this.expirationYear, this.owner});

  factory CreditCard.fromJson(Map<String, dynamic> json) {
    return CreditCard(
        id: json['id'],
        number: json['number'],
        expirationMonth: json['expirationMonth'],
        expirationYear: json['expirationYear'],
        owner: User.fromJson(json['owner'])
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'number': number,
    'expirationMonth': expirationMonth,
    'expirationYear': expirationYear,
    'owner': owner.toJson(),
  };

  @override
  String toString() {
    return number;
  }

}//CreditCard