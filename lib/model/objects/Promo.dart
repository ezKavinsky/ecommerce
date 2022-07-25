import 'ProductInPromo.dart';

class Promo {
  int id;
  String name;
  int discount;
  String startDate;
  String endDate;
  List<ProductInPromo> productsInPromo;

  Promo({this.id, this.name, this.discount, this.startDate, this.endDate, this.productsInPromo});

  factory Promo.fromJson(Map<String, dynamic> json) {
    List<ProductInPromo> productsInPromo = List();
    for(Map<String, dynamic> rawProductInPromo in json['productsInPromo']){
      productsInPromo.add(ProductInPromo.fromJson(rawProductInPromo));
    }
    return Promo(
        id: json['id'],
        name: json['name'],
        discount: json['discount'],
        startDate: json['startDate'],
        endDate: json['endDate'],
        productsInPromo: productsInPromo
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'discount': discount,
    'startDate': startDate,
    'endDate': endDate,
    'productsInPromo': productsInPromo.map((e) => e.toJson()).toList()
  };

  @override
  String toString() {
    return name;
  }

}//Product