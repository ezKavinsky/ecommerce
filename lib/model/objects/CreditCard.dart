class CreditCard {
  int id;
  String number;
  int expirationMonth;
  int expirationYear;

  CreditCard({this.id, this.number, this.expirationMonth, this.expirationYear});

  factory CreditCard.fromJson(Map<String, dynamic> json) {
    return CreditCard(
        id: json['id'],
        number: json['number'],
        expirationMonth: json['expirationMonth'],
        expirationYear: json['expirationYear'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'number': number,
    'expirationMonth': expirationMonth,
    'expirationYear': expirationYear,
  };

  @override
  String toString() {
    return number;
  }

}//CreditCard