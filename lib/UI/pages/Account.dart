import 'package:ecommerce/model/support/extensions/StringCapitalization.dart';
import 'package:flutter/material.dart';
import '../../model/objects/User.dart';
import '../behaviors/AppLocalizations.dart';

class Account extends StatefulWidget {
  Account({Key key, this.user}) : super(key: key);
  final User user;

  @override
  _AccountState createState() => _AccountState();


}

class _AccountState extends State<Account> {

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
                widget.user.firstName,
                style: TextStyle(
                  fontSize: 30,
                  color: Theme.of(context).primaryColor,
                  fontStyle: FontStyle.italic,
                ),
              ),
              Text(
                widget.user.lastName,
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
              widget.user.code,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          Row(
            children: [
              Text(
                widget.user.telephoneNumber,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Text(
                widget.user.email,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Text(
                widget.user.birthDate.toString(),
                style: TextStyle(
                  color: Theme.of(context).primaryColor
                ),
              ),
              FlatButton(
                  onPressed:
                  child: Text(
                    AppLocalizations.of(context).translate("purchases").capitalize
                  )),
            ],
          )
        ],
      ),
    );
  }

  User getLoggedUser(){
    return widget.user;
  }

}