import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'package:ecommerce/UI/pages/ProductPage.dart';
import 'package:ecommerce/model/managers/RestManager.dart';
import 'package:ecommerce/model/objects/AuthenticationData.dart';
import 'package:ecommerce/model/objects/Product.dart';
import 'package:ecommerce/model/objects/Promo.dart';
import 'package:ecommerce/model/objects/User.dart';
import 'package:ecommerce/model/support/Constants.dart';
import 'package:ecommerce/model/support/LogInResult.dart';
import 'package:flutter/material.dart';

import 'objects/Cart.dart';
import 'objects/ProductInPromo.dart';
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
      return List<Product>.from(json.decode(await _restManager.makeGetRequest(Constants.ADDRESS_STORE_SERVER, Constants.REQUEST_SEARCH_PRODUCTS, params)).map((i) => Product.fromJson(i)).toList());
    }
    catch (e) {
      return null; // not the best solution
    }
  }

  Future<Cart> addProductToCart(String id, String idC, int quantity) async {
    try{
      return Cart.fromJson(json.decode(await _restManager.makePostRequest(Constants.ADDRESS_STORE_SERVER, Constants.REQUEST_PRODUCT + id + Constants.ADD_PRODUCT_IN_CART, {idC, quantity} )));
    } catch(e){
      return null;
    }
  }

  Future<List<Review>> getReviews(String id) async {
    try{
      return List<Review>.from(json.decode(await _restManager.makeGetRequest(Constants.ADDRESS_STORE_SERVER, Constants.REQUEST_PRODUCT + id + Constants.REQUEST_REVIEWS)).map((i) => Review.fromJson(i)).toList());
    }catch(e){
      return null;
    }
  }

  Future<Review> getReview(String id1, String id2) async {
    try{
      return Review.fromJson(json.decode(await _restManager.makeGetRequest(Constants.ADDRESS_STORE_SERVER, Constants.REQUEST_PRODUCT + id1 + Constants.REQUEST_REVIEWS + id2)))
    }catch(e){
      return null;
    }
  }



  Future<List<Promo>> showPromos() async{
    try{
      return List<Promo>.from(json.decode(await _restManager.makeGetRequest(Constants.ADDRESS_STORE_SERVER, Constants.REQUEST_PROMOS)).map((i) => Promo.fromJson(i)).toList());
    }catch(e){
      return null;
    }
  }

  Future<Product> getProduct(String id) async{
    try {
      return Product.fromJson(json.decode(await _restManager.makeGetRequest(Constants.ADDRESS_STORE_SERVER, Constants.REQUEST_PRODUCT + id)));
      }catch(e){
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

  Future<User> addUser(User user) async {
    try {
      String rawResult = await _restManager.makePostRequest(Constants.ADDRESS_STORE_SERVER, Constants.REQUEST_ADD_USER, user);
      if ( rawResult.contains(Constants.RESPONSE_ERROR_MAIL_USER_ALREADY_EXISTS) ) {
        return null; // not the best solution
      }
      else {
        return User.fromJson(jsonDecode(rawResult));
      }
    }
    catch (e) {
      return null; // not the best solution
    }
  }

  Future<Purchase> addPurchase(String id1) async{
    try{
      return Purchase.fromJson(json.decode(await _restManager.makePostRequest(Constants.ADDRESS_STORE_SERVER, Constants.REQUEST_ADD_USER + id1 + Constants.REQUEST_ADD_PRODUCT_IN_CART, null)));
    }catch(e){
      return null;
    }
  }

  Future<Cart> clearCart(String id1) async {
    try{
      return Cart.fromJson(json.decode(await _restManager.makePutRequest(Constants.ADDRESS_STORE_SERVER, Constants.REQUEST_ADD_USER + id1 + Constants.REQUEST_CLEAR_CART, value)))
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
      return Review.fromJson(json.decode(await _restManager.makePutRequest(Constants.ADDRESS_STORE_SERVER, Constants.REQUEST_PRODUCT + id2 + Constants.REQUEST_REVIEWS + id1, comment)));
    }catch(e){
      return null;
    }
  }

}
