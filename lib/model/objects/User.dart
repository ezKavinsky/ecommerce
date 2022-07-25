import 'Cart.dart';

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
  Cart cart;

  User({this.id, this.code, this.firstName, this.lastName, this.telephoneNumber, this.email, this.address, this.birthDate, this.registrationDate, this.cart});

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
      cart: Cart.fromJson(json['cart'])
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
    'cart' : cart.toJson()
  };

  @override
  String toString() {
    return firstName + " " + lastName;
  }


}