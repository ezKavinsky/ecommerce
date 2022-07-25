import 'Cart.dart';
import 'Purchase.dart';
import 'CreditCard.dart';
import 'Review.dart';

class User {
  int id;
  String code;
  String firstName;
  String lastName;
  String telephoneNumber;
  String email;
  String address;
  String birthDate;
  String registrationDate;
  List<Purchase> purchases;
  List<Review> reviews;
  List<CreditCard> creditCards;
  Cart cart;

  User({this.id, this.code, this.firstName, this.lastName, this.telephoneNumber, this.email, this.address, this.birthDate, this.registrationDate, this.purchases,
        this.reviews, this.creditCards, this.cart});

  factory User.fromJson(Map<String, dynamic> json) {
    List<Purchase> purchases = List();
    for(Map<String, dynamic> rawPurchase in json['purchases']){
      purchases.add(Purchase.fromJson(rawPurchase));
    }
    List<Review> reviews = List();
    for(Map<String, dynamic> rawReview in json['reviews']){
      reviews.add(Review.fromJson(rawReview));
    }
    List<CreditCard> creditCards = List();
    for(Map<String, dynamic> rawCreditCard in json['creditCards']){
      creditCards.add(CreditCard.fromJson(rawCreditCard));
    }
    return User(
      id: json['id'],
      code: json['code'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      telephoneNumber: json['telephoneNumber'],
      email: json['email'],
      address: json['address'],
      birthDate: json['birthDate'],
      registrationDate: json['registrationDate'],
      purchases: purchases,
      reviews: reviews,
      creditCards: creditCards,
      cart : Cart.fromJson(json['cart'])
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'code': code,
    'firstName': firstName,
    'lastName': lastName,
    'telephoneNumber': telephoneNumber,
    'email': email,
    'address': address,
    'birthDate' : birthDate,
    'registrationDate': registrationDate,
    'purchases': purchases.map((e) => e.toJson()).toList(),
    'reviews': reviews.map((e) => e.toJson()).toList(),
    'creditCards': creditCards.map((e) => e.toJson()).toList(),
    'cart': cart.toJson()
  };

  @override
  String toString() {
    return firstName + " " + lastName;
  }


}