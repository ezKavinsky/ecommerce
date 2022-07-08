import 'package:ecommerce/model/support/extensions/StringCapitalization.dart';
import 'package:flutter/material.dart';
import '../../model/objects/User.dart';
import '../behaviors/AppLocalizations.dart';
import 'PurchasesList.dart';

class Account extends StatefulWidget {

  Account({Key key}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          FlatButton(onPressed: _modifyUser(),
              child: Text(
                  AppLocalizations.of(context).translate("modify").capitalize
          )),
          Row(
            children: [
              Text(
                user.firstName,
                style: TextStyle(
                  fontSize: 30,
                  color: Theme.of(context).primaryColor,
                  fontStyle: FontStyle.italic,
                ),
              ),
              Text(
                user.lastName,
                style: TextStyle(
                  fontSize: 30,
                  color: Theme.of(context).primaryColor,
                  fontStyle: FontStyle.italic,
                ),
              )
            ],
          ),
          Center(
            child: Text(
              user.code,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          Row(
            children: [
              Text(
                user.telephoneNumber,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Text(
                user.email,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Text(
                user.birthDate.toString(),
                style: TextStyle(
                  color: Theme.of(context).primaryColor
                ),
              ),
              FlatButton(
                  onPressed: PurchasesList(),
                  child: Text(
                    AppLocalizations.of(context).translate("purchases").capitalize
                  )),
            ],
          )
        ],
      ),
    );
  }

}