import 'package:eds_funds/classes/classes.dart';
import 'package:eds_funds/routes/login/login.dart';
import 'package:eds_funds/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:eds_funds/classes/auth.dart';
import 'package:eds_funds/classes/user_profile_class.dart';

class RegistrationRoute extends StatefulWidget {
  @override
  _RegistrationRouteState createState() => _RegistrationRouteState();
}

class _RegistrationRouteState extends State<RegistrationRoute> {
  final _auth = Auth();
  final _userProfile =
      UsersProfile(firstName: null, lastName: null, tel: null, address: null);
  final _regKey = GlobalKey<FormState>();
  final _scaffoldState = GlobalKey<ScaffoldState>();

  bool _isWorking = false;
  void _register() async {
    _isWorkingFun(true);
    if (!_regKey.currentState.validate()) {
      _isWorkingFun(false);
      return showSnackBar(_scaffoldState, 'Fill in your details to continue');
    }
    _regKey.currentState.save();

    if (_userProfile.pwd != _userProfile.retypePwd) {
      _isWorkingFun(false);
      return showSnackBar(_scaffoldState, 'Password don\'t macth');
    }

    Map<String, dynamic> _data = Map.from(jsonUserProfile(
        address: _userProfile.address,
        email: _userProfile.email,
        firstName: _userProfile.firstName,
        lastName: _userProfile.lastName,
        pwd: _userProfile.pwd));

    var result = await _auth.createAccount(_data);
    if (result['success']) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);

      return showSnackBar(_scaffoldState, result['message']);
    }
    _isWorkingFun(false);
  }

  _isWorkingFun(bool e) {
    setState(() {
      _isWorking = e;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      body: Container(
        child: Center(
            child: Form(
          key: _regKey,
          child: ListView(
            padding: EdgeInsets.only(
              left: 30,
            ),
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Container(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: <Widget>[
                      Text(
                        'ED',
                        style: TextStyle(color: Colors.teal, fontSize: 40),
                      ),
                      Text(
                        'SUF',
                        style: TextStyle(
                            color: Colors.amber,
                            fontSize: 35,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Register',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                ),
              ),
              Text(
                'fill in your correct details to continue',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                style: registerFormTextStyle,
                textInputAction: TextInputAction.next,
                maxLines: 1,
                validator: isNotNull,
                onSaved: (val) {
                  _userProfile.firstName = val;
                },
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    hintText: 'First Name', labelText: 'First Name'),
              ),
              TextFormField(
                style: registerFormTextStyle,
                textInputAction: TextInputAction.next,
                maxLines: 1,
                keyboardType: TextInputType.text,
                validator: isNotNull,
                onSaved: (val) {
                  _userProfile.lastName = val;
                },
                decoration: InputDecoration(
                    hintText: 'Last Name', labelText: 'Last Name'),
              ),
              TextFormField(
                style: registerFormTextStyle,
                textInputAction: TextInputAction.next,
                maxLines: 1,
                keyboardType: TextInputType.emailAddress,
                validator: isEmail,
                onSaved: (val) {
                  _userProfile.email = val;
                },
                decoration: InputDecoration(
                  hintText: 'Email',
                  labelText: 'Email Addresss',
                ),
              ),
              TextFormField(
                style: registerFormTextStyle,
                textInputAction: TextInputAction.next,
                maxLines: 1,
                validator: isNotNull,
                onSaved: (val) {
                  _userProfile.address = val;
                },
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    hintText: 'Address', labelText: 'Home Address'),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                style: registerFormTextStyle,
                obscureText: true,
                textInputAction: TextInputAction.done,
                maxLines: 1,
                validator: isPassword,
                onSaved: (val) {
                  _userProfile.pwd = val;
                },
                keyboardType: TextInputType.text,
                decoration: InputDecoration(hintText: 'Password'),
              ),
              TextFormField(
                style: registerFormTextStyle,
                obscureText: true,
                textInputAction: TextInputAction.done,
                maxLines: 1,
                validator: isPassword,
                onSaved: (val) {
                  _userProfile.retypePwd = val;
                },
                keyboardType: TextInputType.text,
                decoration: InputDecoration(hintText: 'Re-Type Password'),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: RaisedButton(
                    onPressed: () {
                      _register();
                    },
                    elevation: 0,
                    color: Colors.grey.shade200,
                    padding: EdgeInsets.all(20),
                    child: Visibility(
                      child: SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation(
                                Theme.of(context).indicatorColor,
                              ))),
                      visible: _isWorking,
                      replacement: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            'Register',
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(Icons.arrow_forward)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text('I Already have an account. '),
                      InkWell(
                        onTap: () {
                          navigate(context, LoginRoute());
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: 8.0, top: 8.0, bottom: 8.0),
                          child: Text(
                            'Login here',
                            style: TextStyle(
                                color: Theme.of(context).indicatorColor),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        )),
      ),
    );
  }
}
