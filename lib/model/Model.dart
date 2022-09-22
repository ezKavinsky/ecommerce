import 'dart:async';
import 'dart:convert';
import 'package:ecommerce/model/managers/RestManager.dart';
import 'package:ecommerce/model/objects/AuthenticationData.dart';
import 'package:ecommerce/model/objects/Product.dart';
import 'package:ecommerce/model/objects/ProductInPurchase.dart';
import 'package:ecommerce/model/objects/Promo.dart';
import 'package:ecommerce/model/objects/User.dart';
import 'package:ecommerce/model/support/Constants.dart';
import 'package:ecommerce/model/support/LogInResult.dart';
import 'objects/Cart.dart';
import 'objects/ProductInCart.dart';
import 'objects/ProductInPromo.dart';
import 'objects/ProductInPromoInCart.dart';
import 'objects/Purchase.dart';
import 'objects/Review.dart';


class Model {
  static Model sharedInstance = Model();

  RestManager _restManager = RestManager();
  AuthenticationData _authenticationData;


  Future<LogInResult> logIn(String email, String password) async {
    try{
      Map<String, String> params = Map();
      params["grant_type"] = "password";
      params["client_id"] = Constants.CLIENT_ID;
      params["username"] = email;
      params["password"] = password;
      String result = await _restManager.makePostRequest(Constants.ADDRESS_AUTHENTICATION_SERVER, Constants.REQUEST_LOGIN, params, type: TypeHeader.urlencoded);
      _authenticationData = AuthenticationData.fromJson(jsonDecode(result));
      if ( _authenticationData.hasError() ) {
        if ( _authenticationData.error == "Invalid user credentials" ) {
          return LogInResult.error_wrong_credentials;
        }
        else if ( _authenticationData.error == "Account is not fully set up" ) {
          return LogInResult.error_not_fully_setupped;
        }
        else {
          return LogInResult.error_unknown;
        }
      }
      _restManager.token = _authenticationData.accessToken;
      Timer.periodic(Duration(seconds: (_authenticationData.expiresIn - 50)), (Timer t) {
        _refreshToken();
      });
      return LogInResult.logged;
    }
    catch (e) {
      return LogInResult.error_unknown;
    }
  }

  Future<bool> _refreshToken() async {
    try {
      Map<String, String> params = Map();
      params["grant_type"] = "refresh_token";
      params["client_id"] = Constants.CLIENT_ID;
      params["refresh_token"] = _authenticationData.refreshToken;
      String result = await _restManager.makePostRequest(Constants.ADDRESS_AUTHENTICATION_SERVER, Constants.REQUEST_LOGIN, params, type: TypeHeader.urlencoded);
      _authenticationData = AuthenticationData.fromJson(jsonDecode(result));
      if ( _authenticationData.hasError() ) {
        return false;
      }
      _restManager.token = _authenticationData.accessToken;
      return true;
    }
    catch (e) {
      return false;
    }
  }

  Future<bool> logOut() async {
    try{
      Map<String, String> params = Map();
      _restManager.token = null;
      params["client_id"] = Constants.CLIENT_ID;
      params["refresh_token"] = _authenticationData.refreshToken;
      await _restManager.makePostRequest(Constants.ADDRESS_AUTHENTICATION_SERVER, Constants.REQUEST_LOGOUT, params, type: TypeHeader.urlencoded);
      return true;
    }
    catch (e) {
      return false;
    }
  }

  Future<List<Product>> searchProduct(String name) async {
    Map<String, String> params = Map();
    params["name"] = name;
    try {
      var response = await _restManager.makeGetRequestParam(Constants.ADDRESS_STORE_SERVER, Constants.REQUEST_SEARCH_PRODUCTS, params);
      print(response);
      return List<Product>.from(json.decode(await _restManager.makeGetRequestParam(Constants.ADDRESS_STORE_SERVER, Constants.REQUEST_SEARCH_PRODUCTS, params)).map((i) => Product.fromJson(i)).toList()) ;
    }
    catch (e) {
      return null; // not the best solution
    }
  }

  Future<Cart> addProductToCart(String id, String idC, String quantity) async {
    try{
      return Cart.fromJson(json.decode(await _restManager.makePostRequest(Constants.ADDRESS_STORE_SERVER, Constants.REQUEST_PRODUCT + id + Constants.REQUEST_ADD_PRODUCT_IN_CART, {"id" : idC, "quantity" : quantity})));
    } catch(e){
      return null;
    }
  }

  Future<Cart> addProductInPromoToCart(String id1, String id2, String idC, String quantity) async {
    try{
      return Cart.fromJson(json.decode(await _restManager.makePostRequest(Constants.ADDRESS_STORE_SERVER, Constants.REQUEST_PROMOS + id2 + Constants.REQUEST_PRODUCTS_IN_PROMO + id1 + Constants.REQUEST_ADD_PRODUCT_IN_CART, {"id" : idC, "quantity" : quantity} )));
    } catch(e){
      return null;
    }
  }

  Future<Cart> updateProductQuantity(String id, String idC, String quantity) async {
    try{
      return Cart.fromJson(json.decode(await _restManager.makePutRequest(Constants.ADDRESS_STORE_SERVER, Constants.REQUEST_PRODUCT + idC + Constants.REQUEST_PRODUCT, {"id" : id, "quantity" : quantity})));
    } catch(e){
      return null;
    }
  }

  Future<Cart> updateProductInPromoQuantity(String id, String idC, String quantity) async {
    try{
      return Cart.fromJson(json.decode(await _restManager.makePutRequest(Constants.ADDRESS_STORE_SERVER, Constants.REQUEST_PRODUCT + idC + Constants.REQUEST_PRODUCTS_IN_PROMO, {"id" : id, "quantity" : quantity} )));
    } catch(e){
      return null;
    }
  }

  Future<List<Review>> getReviews(String id) async {
    try{
      var response = await _restManager.makeGetRequest(Constants.ADDRESS_STORE_SERVER, Constants.REQUEST_PRODUCT + id + Constants.REQUEST_REVIEWS);
      print(response);
      return List<Review>.from(json.decode(await _restManager.makeGetRequest(Constants.ADDRESS_STORE_SERVER, Constants.REQUEST_PRODUCT + id + Constants.REQUEST_REVIEWS)).map((i) => Review.fromJson(i)).toList());
    }catch(e){
      print("---QUI3--\n");
      print(e);
      print("-----\n");
      return null;
    }
  }

  Future<Review> getReview(String id1, String id2) async {
    try{
      return Review.fromJson(json.decode(await _restManager.makeGetRequest(Constants.ADDRESS_STORE_SERVER, Constants.REQUEST_PRODUCT + id1 + Constants.REQUEST_REVIEWS + id2)));
    }catch(e){
      return null;
    }
  }



  Future<List<Promo>> showPromos() async{
    try{
      var response = await _restManager.makeGetRequest(Constants.ADDRESS_STORE_SERVER, Constants.REQUEST_PROMOS);
      print(response);
      return List<Promo>.from(json.decode(await _restManager.makeGetRequest(Constants.ADDRESS_STORE_SERVER, Constants.REQUEST_PROMOS)).map((i) => Promo.fromJson(i)).toList());
    }catch(e){
      print("---QUI--\n");
      print(e);
      print("-----\n");
      return null;
    }
  }

  Future<List<Purchase>> getPurchases(String id) async{
    try{
      var response = await _restManager.makeGetRequest(Constants.ADDRESS_STORE_SERVER, Constants.REQUEST_ADD_USER + id + Constants.REQUEST_PURCHASES);
      print("risposta" + response);
      return List<Purchase>.from(json.decode(await _restManager.makeGetRequest(Constants.ADDRESS_STORE_SERVER, Constants.REQUEST_ADD_USER + id + Constants.REQUEST_PURCHASES)).map((i) => Purchase.fromJson(i)).toList());
    }catch(e){
      print("NUOVO\n");
      print(e);
      return null;
    }
  }

  Future<Product> getProduct(String id) async{
    try {
      var response = await _restManager.makeGetRequest(Constants.ADDRESS_STORE_SERVER, Constants.REQUEST_PRODUCT + id);
      print(response);
      return Product.fromJson(json.decode(await _restManager.makeGetRequest(Constants.ADDRESS_STORE_SERVER, Constants.REQUEST_PRODUCT + id)));
      }catch(e){
      print("---QUI2--\n");
      print(e);
      print("-----\n");
      return null;
    }
  }

  Future<ProductInPromo> getProductInPromo(String id1, String id2) async{
    try {
      return ProductInPromo.fromJson(json.decode(await _restManager.makeGetRequest(Constants.ADDRESS_STORE_SERVER, Constants.REQUEST_PROMOS + id2 + Constants.REQUEST_PRODUCTS_IN_PROMO + id1)));
    }catch(e){
      return null;
    }
  }

  Future<Purchase> addPurchase(String id1) async{
    try{
      var response = Purchase.fromJson(json.decode(await _restManager.makePostRequest(Constants.ADDRESS_STORE_SERVER, Constants.REQUEST_ADD_USER + id1 + Constants.REQUEST_MAKE_PURCHASE, null)));
      print(response);
      return response;
    }catch(e){
      print(e);
      return null;
    }
  }

  Future<Cart> clearCart(String id1) async {
    try{
      return Cart.fromJson(json.decode(await _restManager.makePutRequest(Constants.ADDRESS_STORE_SERVER, Constants.REQUEST_ADD_USER + id1 + Constants.REQUEST_CLEAR_CART, null)));
    }catch(e){
      return null;
    }
  }

  Future removeProduct(String id1, String id2) async{
    try{
      await _restManager.makeDeleteRequest(Constants.ADDRESS_STORE_SERVER, Constants.REQUEST_ADD_USER + id1 + Constants.REQUEST_PRODUCTS_IN_CART + id2);
    }catch(e){
      return null;
    }
  }

  Future removeProductInPromo(String id1, String id2) async{
    try{
      await _restManager.makeDeleteRequest(Constants.ADDRESS_STORE_SERVER, Constants.REQUEST_ADD_USER + id1 + Constants.REQUEST_PRODUCTS_IN_PROMO_IN_CART + id2);
    }catch(e){
      return null;
    }
  }

  Future<Review> updateTitle(String id1, String id2, String title) async{
    try{
      return Review.fromJson(json.decode(await _restManager.makePutRequest(Constants.ADDRESS_STORE_SERVER, Constants.REQUEST_PRODUCT + id2 + Constants.REQUEST_REVIEWS + id1, title)));
    }catch(e){
      return null;
    }
  }

  Future<Review> updateComment(String id1, String id2, String comment) async{
    try{
      return Review.fromJson(json.decode(await _restManager.makePutRequest(Constants.ADDRESS_STORE_SERVER, Constants.REQUEST_PRODUCT + id2 + Constants.REQUEST_REVIEWS + id1 + Constants.REQUEST_UPDATE_COMMENT, comment)));
    }catch(e){
      return null;
    }
  }

  Future<User> getByEmail(String email) async {
    Map<String, String> params = Map();
    params["email"] = email;
    try{
      String rawResult = await _restManager.makeGetRequestParam(Constants.ADDRESS_STORE_SERVER, Constants.REQUEST_USER_BY_EMAIL, params);
      if(rawResult.contains(Constants.RESPONSE_ERROR_USER_NOT_FOUND)){
        print ("Ciao");
        return null;
      }else {
        return User.fromJson(jsonDecode(rawResult));
      }
    }catch(e){
      print ("Ciao2");
      return null;
    }
  }

  Future<User> updateFirstName(String id, String firstName) async{
    try{
      String rawResult = await _restManager.makePutRequest(Constants.ADDRESS_STORE_SERVER, Constants.REQUEST_ADD_USER + id, firstName);
      if(rawResult.contains(Constants.RESPONSE_ERROR_USER_NOT_FOUND)){
        print ("Ciao3");
        return null;
      }else {
        print("Errore2");
        return User.fromJson(jsonDecode(rawResult));
      }
    }catch(e){
      print ("Ciao4");
      return null;
    }
  }

  Future<User> updateLastName(String id, String lastName) async{
    try{
      return User.fromJson(json.decode(await _restManager.makePutRequest(Constants.ADDRESS_STORE_SERVER, Constants.REQUEST_ADD_USER + id, lastName)));
    }catch(e){
      return null;
    }
  }

  Future<User> updateCode(String id, String code) async{
    try{
      return User.fromJson(json.decode(await _restManager.makePutRequest(Constants.ADDRESS_STORE_SERVER, Constants.REQUEST_ADD_USER + id, code)));
    }catch(e){
      return null;
    }
  }

  Future<User> updateTelephoneNumber(String id, String telephoneNumber) async{
    try{
      return User.fromJson(json.decode(await _restManager.makePutRequest(Constants.ADDRESS_STORE_SERVER, Constants.REQUEST_ADD_USER + id, telephoneNumber)));
    }catch(e){
      return null;
    }
  }

  Future<User> updateEmail(String id, String email) async{
    try{
      return User.fromJson(json.decode(await _restManager.makePutRequest(Constants.ADDRESS_STORE_SERVER, Constants.REQUEST_ADD_USER + id, email)));
    }catch(e){
      return null;
    }
  }
  Future<User> updateAddress(String id, String address) async{
    try{
      return User.fromJson(json.decode(await _restManager.makePutRequest(Constants.ADDRESS_STORE_SERVER, Constants.REQUEST_ADD_USER + id, address)));
    }catch(e){
      return null;
    }
  }

  Future<List<Review>> getReviewsByUser(String id) async{
    try{
      return List<Review>.from(json.decode(await _restManager.makeGetRequest(Constants.ADDRESS_STORE_SERVER, Constants.REQUEST_ADD_USER + id + Constants.REQUEST_REVIEWS)));
    }catch(e){
      return null;
    }
  }

  Future<List<ProductInCart>> getProducts(String id) async{
    try{
      return List<ProductInCart>.from(json.decode(await _restManager.makeGetRequest(Constants.ADDRESS_STORE_SERVER, Constants.REQUEST_ADD_USER + id + Constants.REQUEST_PRODUCTS_IN_CART)).map((i) => ProductInCart.fromJson(i)).toList());
    }catch(e) {
      return null;
    }
  }

  Future<List<ProductInPromoInCart>> getProductsInPromoInCart(String id) async{
    try{
      return List<ProductInPromoInCart>.from(json.decode(await _restManager.makeGetRequest(Constants.ADDRESS_STORE_SERVER, Constants.REQUEST_ADD_USER + id + Constants.REQUEST_PRODUCTS_IN_PROMO_IN_CART)).map((i) => ProductInPromoInCart.fromJson(i)).toList());
    }catch(e) {
      return null;
    }
  }

  Future<List<ProductInPurchase>> getProductsInPurchase(String id1, String id2) async{
    try{
      return List<ProductInPurchase>.from(json.decode(await _restManager.makeGetRequest(Constants.ADDRESS_STORE_SERVER, Constants.REQUEST_ADD_USER + id1 + Constants.REQUEST_PURCHASES + id2)).map((i) => ProductInPromoInCart.fromJson(i)).toList());
    }catch(e) {
      return null;
    }
  }

  Future<List<ProductInPromo>> getProductsInPromo(String id) async{
    try{
      var response = await _restManager.makeGetRequest(Constants.ADDRESS_STORE_SERVER, Constants.REQUEST_PROMOS + id + Constants.REQUEST_PRODUCT);
      print(response);
      return List<ProductInPromo>.from(json.decode(await _restManager.makeGetRequest(Constants.ADDRESS_STORE_SERVER, Constants.REQUEST_PROMOS + id + Constants.REQUEST_PRODUCT)).map((i) => ProductInPromo.fromJson(i)).toList());
    }catch(e) {
      print("errore");
      print(e);
      return null;
    }
  }

}
