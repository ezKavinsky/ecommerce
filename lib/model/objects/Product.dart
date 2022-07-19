import 'ProductInCart.dart';
import 'ProductInPurchase.dart';
import 'Review.dart';

class Product {
  int id;
  String name;
  String brand;
  String barCode;
  String description;
  double price;
  int quantity;
  int productionYear;
  bool freeShipping;
  double shippingPrice;
  double score;
  List<ProductInPurchase> productsInPurchase;
  List<ProductInCart> productsInCarts;
  List<Review> reviews;

  Product({this.id, this.name, this.brand, this.barCode, this.description, this.price, this.quantity,this.productionYear,this.freeShipping, this.shippingPrice, this.score, this.productsInPurchase, this.productsInCarts, this.reviews});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      brand: json['brand'],
      barCode: json['barCode'],
      description: json['description'],
      price: json['price'],
      quantity: json['quantity'],
      productionYear: json['productionYear'],
      freeShipping: json['freeShipping'],
      shippingPrice: json['shippingPrice'],
      score: json['score'],
      productsInPurchase: json['productsInPurchase'],
      productsInCarts: json['productsInCarts'],
      reviews: json['reviews']
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'barCode': barCode,
    'description': description,
    'price': price,
    'quantity': quantity,
    'freeShipping': freeShipping,
    'shippingPrice': shippingPrice,
    'score': score,
    'productsInPurchase': productsInPurchase,
    'productsInCarts': productsInCarts,
    'reviews': reviews
  };

  @override
  String toString() {
    return name;
  }

}//Product