import 'Product.dart';
import 'User.dart';

class Review {
  int id;
  String title;
  String comment;
  double stars;
  Product product;
  User buyer;

  Review({this.id, this.title, this.comment, this.stars, this.product, this.buyer});

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
        id: json['id'],
        title: json['title'],
        comment: json['comment'],
        stars: json['stars'],
        product: json['product'],
        buyer: json['buyer']
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'comment': comment,
    'stars': stars,
    'product': product,
    'buyer': buyer,
  };

  @override
  String toString() {
    return title;
  }
}//Product