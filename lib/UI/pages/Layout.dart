import 'package:ecommerce/model/support/extensions/StringCapitalization.dart';
import 'package:ecommerce/UI/behaviors/AppLocalizations.dart';
import 'package:ecommerce/UI/pages/Home.dart';
import 'package:ecommerce/UI/pages/Search.dart';
import 'package:ecommerce/UI/pages/Promoting.dart';
import 'package:ecommerce/UI/pages/UserRegistration.dart';
import 'package:flutter/material.dart';

import '../../model/objects/User.dart';


class Layout extends StatefulWidget {
  final String title;


  Layout({Key key, this.title}) : super(key: key);

  @override
  _LayoutState createState() => _LayoutState(title);
}

class _LayoutState extends State<Layout> {
  String title;
  User user = null;


  _LayoutState(String title) {
    this.title = title;
  }


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
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
            ],
          ),
        ),
        body: TabBarView(
          children: [
            UserRegistration(),
            Search(user: user),
            Promoting(user: user),
          ],
        ),
      ),
    );
  }


}
