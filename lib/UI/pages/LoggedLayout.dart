import 'package:ecommerce/model/objects/Cart.dart';
import 'package:ecommerce/model/support/extensions/StringCapitalization.dart';
import 'package:ecommerce/UI/behaviors/AppLocalizations.dart';
import 'package:ecommerce/UI/pages/Home.dart';
import 'package:ecommerce/UI/pages/Search.dart';
import 'package:ecommerce/UI/pages/Promoting.dart';
import 'package:ecommerce/UI/pages/UserRegistration.dart';
import 'package:flutter/material.dart';

import '../../model/objects/User.dart';
import 'Account.dart';
import 'CartPage.dart';


class LoggedLayout extends StatefulWidget {
  final String title;
  final User user;


  LoggedLayout({Key key, this.title, this.user}) : super(key: key);

  @override
  _LoggedLayoutState createState() => _LoggedLayoutState(title, user);
}

class _LoggedLayoutState extends State<LoggedLayout> {
  String title;
  User user;


  _LoggedLayoutState(String title, User user) {
    this.title = title;
    this.user = user;
  }


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          title: Text(title),
          bottom: TabBar(
            tabs: [
              Tab(text: AppLocalizations.of(context).translate("user").capitalize, icon: Icon(Icons.person_rounded)),
              Tab(text: AppLocalizations.of(context).translate("search").capitalize, icon: Icon(Icons.search_rounded)),
              Tab(text: "Promo", icon: Icon(Icons.newspaper)),
              Tab(text: "Cart", icon: Icon(Icons.shopping_cart))
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Account(user: user),
            Search(user: user),
            Promoting(user: user),
            CartPage(cart: user.cart, user: user),
          ],
        ),
      ),
    );
  }


}
