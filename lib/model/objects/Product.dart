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
    List<ProductInPurchase> productsInPurchase = List();
    for(Map<String, dynamic> rawProductInPurchase in json['productsInPurchase']){
      productsInPurchase.add(ProductInPurchase.fromJson(rawProductInPurchase));
    }
    List<ProductInCart> productsInCart = List();
    for(Map<String, dynamic> rawProductInCart in json['productsInCart']){
      productsInCart.add(ProductInCart.fromJson(rawProductInCart));
    }
    List<Review> reviews = List();
    for(Map<String, dynamic> rawReview in json['reviews']){
      reviews.add(Review.fromJson(rawReview));
    }
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
      productsInPurchase: productsInPurchase,
      productsInCarts: productsInCart,
      reviews: reviews
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
    'productsInPurchase': productsInPurchase.map((e) => e.toJson()).toList(),
    'productsInCarts': productsInCarts.map((e) => e.toJson()).toList(),
    'reviews': reviews.map((e) => e.toJson()).toList()
  };

  @override
  String toString() {
    return name;
  }

}//Product