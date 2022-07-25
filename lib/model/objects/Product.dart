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

  Product({this.id, this.name, this.brand, this.barCode, this.description, this.price, this.quantity,this.productionYear,this.freeShipping, this.shippingPrice, this.score});

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
    'score': score
  };

  @override
  String toString() {
    return name;
  }

}//Product