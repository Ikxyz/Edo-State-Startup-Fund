import 'package:eds_funds/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:eds_funds/classes/classes.dart';
import './register.dart';
import 'package:eds_funds/classes/auth.dart';
import 'package:eds_funds/models/app.dart';
import 'package:eds_funds/trigger/event.dart';

class LoginRoute extends StatefulWidget {
  const LoginRoute({Key key}) : super(key: key);
  @override
  _LoginRouteState createState() => _LoginRouteState();
}

class _LoginRouteState extends State<LoginRoute>
    with SingleTickerProviderStateMixin {
  String email, pwd;
  final _loginKey = GlobalKey<FormState>();
  final _scafoldState = GlobalKey<ScaffoldState>();
  bool _isWorking = false;
  $AppAuthState _appAuthState;

  @override
  void initState() {
    super.initState();
    _appAuthState = $AppAuthState(context);
  }

  _isWorkingFun(bool e) {
    setState(() {
      _isWorking = e;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onLogin() async {
    _isWorkingFun(true);
    if (!_loginKey.currentState.validate()) {
     _isWorkingFun(false);
      return;
    }
    ;
    _loginKey.currentState.save();
    final _user = await Auth()
        .auth
        .signInWithEmailAndPassword(email: email, password: pwd)
        .catchError((err) {
      print(err);
      _isWorkingFun(false);
      showSnackBar(_scafoldState, err.message.toString());
    });
    if (_user != null) {
      _appAuthState.dispatch(isAutheticated.listen);
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
    }
    _isWorkingFun(false);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Scaffold(
      key: _scafoldState,
      body: Container(
        child: Center(
            child: ListView(
          padding: EdgeInsets.only(
            left: 30,
          ),
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
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
                      'Suf',
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
              'Welcome',
              style: TextStyle(
                color: Colors.black,
                fontSize: 50,
              ),
            ),
            Text(
              'sign in to continue',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 40,
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.7,
              child: Form(
                key: _loginKey,
                child: ListView(
                  children: <Widget>[
                    TextFormField(
                      style: TextStyle(fontSize: 20),
                      textInputAction: TextInputAction.done,
                      maxLines: 1,
                      obscureText: false,
                      validator: isEmail,
                      onSaved: (val) {
                        email = val;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: 'Email',
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                      style: loginFormTextStyle,
                      obscureText: true,
                      textInputAction: TextInputAction.done,
                      maxLines: 1,
                      validator: isPassword,
                      onSaved: (val) {
                        pwd = val;
                      },
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(hintText: 'Password'),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    Container(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: RaisedButton(
                            onPressed: () {
                              _onLogin();
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
                                    'Get Started',
                                    style: loginFormTextStyle,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(Icons.arrow_forward)
                                ],
                              ),
                            )),
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
                            Text('Don\' have an account yet. '),
                            InkWell(
                              onTap: () {
                                navigate(context, RegistrationRoute());
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    right: 8.0, top: 8.0, bottom: 8.0),
                                child: Text(
                                  'Register here',
                                  style: TextStyle(
                                      color: Theme.of(context).indicatorColor),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
