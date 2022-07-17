import 'package:ecommerce/UI/behaviors/AppLocalizations.dart';
import 'package:ecommerce/UI/widgets/CircularIconButton.dart';
import 'package:ecommerce/UI/widgets/InputField.dart';
import 'package:ecommerce/model/Model.dart';
import 'package:ecommerce/model/objects/User.dart';
import 'package:ecommerce/model/support/extensions/StringCapitalization.dart';
import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';


class UserRegistration extends StatefulWidget {
  UserRegistration({Key key}) : super(key: key);


  @override
  _UserRegistrationState createState() => _UserRegistrationState();
}

class _UserRegistrationState extends State<UserRegistration> {
  bool _adding = false;
  User _justAddedUser;
  DateTime date;

  TextEditingController _codeFiledController = TextEditingController();
  TextEditingController _firstNameFiledController = TextEditingController();
  TextEditingController _lastNameFiledController = TextEditingController();
  TextEditingController _telephoneNumberFiledController = TextEditingController();
  TextEditingController _emailFiledController = TextEditingController();
  TextEditingController _addressFiledController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Text(
                AppLocalizations.of(context).translate("register").capitalize + "!",
                style: TextStyle(
                  fontSize: 50,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Column(
                children: [
                  InputField(
                    labelText: "Code",
                    controller: _codeFiledController,
                  ),
                  InputField(
                    labelText: AppLocalizations.of(context).translate("firstName").capitalize,
                    controller: _firstNameFiledController,
                  ),
                  InputField(
                    labelText: AppLocalizations.of(context).translate("lastName").capitalize,
                    controller: _lastNameFiledController,
                  ),
                  InputField(
                    labelText: AppLocalizations.of(context).translate("telephoneNumber").capitalize,
                    controller: _telephoneNumberFiledController,
                  ),
                  InputField(
                    labelText: AppLocalizations.of(context).translate("email").capitalize,
                    controller: _emailFiledController,
                  ),
                  InputField(
                    labelText: AppLocalizations.of(context).translate("address").capitalize,
                    controller: _addressFiledController,
                  ),
                  DateTimeFormField(
                    decoration: const InputDecoration(
                      hintStyle: TextStyle(color: Colors.amberAccent),
                      errorStyle: TextStyle(color: Colors.redAccent),
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.event_note),
                      labelText: 'Birth date',
                    ),
                    mode: DateTimeFieldPickerMode.date,
                    autovalidateMode: AutovalidateMode.always,
                    onDateSelected: (DateTime value) {
                      date = value;
                      print(value);
                    },
                  ),
                  CircularIconButton(
                    icon: Icons.person_rounded,
                    onPressed: () {
                      _register();
                    },
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: _adding ?
                      CircularProgressIndicator() :
                      _justAddedUser != null ?
                      Text(
                          AppLocalizations.of(context).translate("just_added") + ":" + _justAddedUser.firstName + " " + _justAddedUser.lastName + "!"
                      ) :
                      SizedBox.shrink(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _register() {
    setState(() {
      _adding = true;
      _justAddedUser = null;
    });
    User user = User(
      code: _codeFiledController.text,
      firstName: _firstNameFiledController.text,
      lastName: _lastNameFiledController.text,
      telephoneNumber: _telephoneNumberFiledController.text,
      email: _emailFiledController.text,
      address: _addressFiledController.text,
      birthDate: date,
    );
    Model.sharedInstance.addUser(user).then((result) {
      setState(() {
        _adding = false;
        _justAddedUser = result;
      });
    });
  }


}
