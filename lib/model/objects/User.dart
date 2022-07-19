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
  DateTime birthDate;
  DateTime registrationDate;
  List<Purchase> purchases;
  List<Review> reviews;
  List<CreditCard> creditCards;
  Cart cart;

  User({this.id, this.code, this.firstName, this.lastName, this.telephoneNumber, this.email, this.address, this.birthDate, this.registrationDate, this.purchases,
        this.reviews, this.creditCards, this.cart});

  factory User.fromJson(Map<String, dynamic> json) {
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
      purchases: json['purchases'],
      reviews:json['reviews'],
      creditCards: json['creditCards'],
      cart : json['cart']
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
    'purchases': purchases,
    'reviews': reviews,
    'creditCards': creditCards,
    'cart': cart
  };

  @override
  String toString() {
    return firstName + " " + lastName;
  }


}