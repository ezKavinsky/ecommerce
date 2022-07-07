import 'ProductInPromo.dart';

class Promo {
  int id;
  String name;
  int discount;
  DateTime startDate;
  DateTime endDate;
  List<ProductInPromo> productsInPromo;

  Promo({this.id, this.name, this.discount, this.startDate, this.endDate, this.productsInPromo});

  factory Promo.fromJson(Map<String, dynamic> json) {
    return Promo(
        id: json['id'],
        name: json['name'],
        discount: json['discount'],
        startDate: json['startDate'],
        endDate: json['endDate'],
        productsInPromo: json['productsInPromo']
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'discount': discount,
    'startDate': startDate,
    'endDate': endDate,
    'productsInPromo': productsInPromo
  };

  @override
  String toString() {
    return name;
  }
}//Product