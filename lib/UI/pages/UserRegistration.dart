import 'package:ecommerce/UI/behaviors/AppLocalizations.dart';
import 'package:ecommerce/UI/pages/Account.dart';
import 'package:ecommerce/UI/pages/LoggedLayout.dart';
import 'package:ecommerce/UI/widgets/CircularIconButton.dart';
import 'package:ecommerce/UI/widgets/InputField.dart';
import 'package:ecommerce/model/Model.dart';
import 'package:ecommerce/model/objects/User.dart';
import 'package:ecommerce/model/support/extensions/StringCapitalization.dart';
import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';

import '../../model/support/Constants.dart';


class UserRegistration extends StatefulWidget {
  UserRegistration({Key key}) : super(key: key);


  @override
  _UserRegistrationState createState() => _UserRegistrationState();
}

class _UserRegistrationState extends State<UserRegistration> {
  User _user;
  DateTime date;

  TextEditingController _emailLoginFiledController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
                  Text(
                    "Login",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 50
                    ),
                  ),
                  InputField(
                    labelText: "Email",
                    controller: _emailLoginFiledController,
                  ),
                  CircularIconButton(
                    icon: Icons.login,
                    onPressed: () {
                      _login(_emailLoginFiledController.text);
                    },
                  ),
                ],
              ),
            )
    );
  }

  void _login(String email){
    Model.sharedInstance.getByEmail(email).then((result) {
      _user = result;
      setState((){
        Navigator.push(context, new MaterialPageRoute(builder: (context) => new LoggedLayout(title: Constants.APP_NAME, user: _user)));
      });
    });
  }

}
