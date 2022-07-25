import 'Product.dart';

class ProductInCart {
  int id;
  Product product;
  int quantity;

  ProductInCart({this.id, this.product, this.quantity});

  factory ProductInCart.fromJson(Map<String, dynamic> json){
    return ProductInCart(
        id: json['id'],
        product: Product.fromJson(json['product']),
        quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'product': product.toJson(),
    'quantity': quantity
  };

}//ProductInCart