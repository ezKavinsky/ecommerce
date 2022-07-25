import 'package:ecommerce/model/Model.dart';
import 'package:flutter/material.dart';
import '../../model/objects/Cart.dart';
import '../../model/objects/Purchase.dart';
import '../../model/objects/Review.dart';
import '../../model/objects/User.dart';
import 'PurchasesPage.dart';
import 'ReviewsPage.dart';

class Account extends StatefulWidget {
  Account({Key key, this.user}) : super(key: key);
  final User user;

  @override
  _AccountState createState() => _AccountState();

  User getUser(){
    return user;
  }

}

class _AccountState extends State<Account> {
  bool _editable;
  List<Purchase> _purchases = null;
  List<Review> _reviews = null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Align(
              alignment: Alignment.bottomLeft,
              child: ElevatedButton(
                  child: Icon(Icons.edit),
                  onPressed: () {
                    _modify();
                  }
              )
          ),
          Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                  child: Icon(Icons.shopify_sharp),
                  onPressed: () {
                    _getPurchases(widget.user.id.toString());
                  }
              )
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                  child: Icon(Icons.reviews),
                  onPressed: () {
                    _getReviews(widget.user.id.toString());
                  }
              )
          ),
          Row(
            children: [
              TextField(
                enabled: _editable,
                decoration: InputDecoration(
                  labelText: widget.user.firstName,
                ),
                onEditingComplete: () {
                  _updateFirstName(widget.user.id.toString(), widget.user.firstName);
                },
                style: TextStyle(
                  fontSize: 30,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              TextField(
                enabled: _editable,
                decoration: InputDecoration(
                  labelText: widget.user.lastName,
                ),
                onEditingComplete: () {
                  _updateLastName(widget.user.id.toString(), widget.user.lastName);
                },
                style: TextStyle(
                  fontSize: 30,
                  color: Theme.of(context).primaryColor,
                ),
              )
            ],
          ),
          Center(
            child: TextField(
              enabled: _editable,
              decoration: InputDecoration(
                labelText: widget.user.code,
              ),
              onEditingComplete: () {
                _updateCode(widget.user.id.toString(), widget.user.code);
              },
              style: TextStyle(
                fontSize: 30,
                color: Theme.of(context).primaryColor,
              ),
            )
          ),
          Row(
            children: [
              TextField(
                enabled: _editable,
                decoration: InputDecoration(
                  labelText: widget.user.telephoneNumber,
                ),
                onEditingComplete: () {
                  _updateTelephoneNumber(widget.user.id.toString(), widget.user.telephoneNumber);
                },
                style: TextStyle(
                  fontSize: 30,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              TextField(
                enabled: _editable,
                decoration: InputDecoration(
                  labelText: widget.user.email,
                ),
                onEditingComplete: () {
                  _updateEmail(widget.user.id.toString(), widget.user.email);
                },
                style: TextStyle(
                  fontSize: 30,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Text(
                widget.user.birthDate.toString(),
                style: TextStyle(
                  fontSize: 30,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              TextField(
                enabled: _editable,
                decoration: InputDecoration(
                  labelText: widget.user.address,
                ),
                onEditingComplete: () {
                  _updateAddress(widget.user.id.toString(), widget.user.address);
                },
                style: TextStyle(
                  fontSize: 30,
                  color: Theme.of(context).primaryColor,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  User getLoggedUser(){
    return widget.user;
  }

  void _modify(){
    setState((){
      _editable = !_editable;
    });
  }

  void _updateFirstName(String id, String firstName){
    Model.sharedInstance.updateFirstName(id, firstName).then((result){
      setState(() {
        _editable = !_editable;
      });
    });
  }

  void _updateLastName(String id, String lastName){
    Model.sharedInstance.updateLastName(id, lastName).then((result){
      setState(() {
        _editable = !_editable;
      });
    });
  }

  void _updateCode(String id, String code){
    Model.sharedInstance.updateCode(id, code).then((result){
      setState(() {
        _editable = !_editable;
      });
    });
  }

  void _updateTelephoneNumber(String id, String telephoneNumber){
    Model.sharedInstance.updateTelephoneNumber(id, telephoneNumber).then((result){
      setState(() {
        _editable = !_editable;
      });
    });
  }

  void _updateEmail(String id, String email){
    Model.sharedInstance.updateEmail(id, email).then((result){
      setState(() {
        _editable = !_editable;
      });
    });
  }

  void _updateAddress(String id, String address){
    Model.sharedInstance.updateAddress(id, address).then((result){
      setState(() {
        _editable = !_editable;
      });
    });
  }

  void _getPurchases(String id){
    Model.sharedInstance.getPurchases(id).then((result) {
      _purchases = result;
    });
    setState((){
      Navigator.push(context, new MaterialPageRoute(builder: (context) => new PurchasesPage(purchases: _purchases)));
    });
  }

  void _getReviews(String id){
    Model.sharedInstance.getReviewsByUser(id).then((result) {
      _reviews = result;
    });
    setState((){
      Navigator.push(context, new MaterialPageRoute(builder: (context) => new ReviewsPage(reviews: _reviews)));
    });
  }

}