import 'Product.dart';
import 'User.dart';

class Review {
  int id;
  String title;
  String comment;
  double stars;
  User buyer;
  Product product;

  Review({this.id, this.title, this.comment, this.stars, this.buyer, this.product});

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
        id: json['id'],
        title: json['title'],
        comment: json['comment'],
        stars: json['stars'],
        buyer: User.fromJson(json['buyer']),
        product: Product.fromJson(json['product'])
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'comment': comment,
    'stars' : stars,
    'buyer' : buyer,
    'product' : product
  };

  @override
  String toString() {
    return title;
  }
}//Product