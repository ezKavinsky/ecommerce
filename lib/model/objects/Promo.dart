import 'ProductInPromo.dart';

class Promo {
  int id;
  String name;
  int discount;
  String startDate;
  String endDate;

  Promo({this.id, this.name, this.discount, this.startDate, this.endDate});

  factory Promo.fromJson(Map<String, dynamic> json) {
    return Promo(
        id: json['id'],
        name: json['name'],
        discount: json['discount'],
        startDate: json['startDate'],
        endDate: json['endDate'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'discount': discount,
    'startDate': startDate,
    'endDate': endDate,
  };

  @override
  String toString() {
    return name;
  }

}//Product