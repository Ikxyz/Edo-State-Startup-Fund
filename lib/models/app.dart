import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:eds_funds/trigger/event.dart' as event$;
import 'package:eds_funds/classes/user_profile_class.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:eds_funds/classes/start_up.dart';

class $AppAuthState extends Bloc<event$.isAutheticated, dynamic> {
  @override
  dynamic get initialState => false;
  final BuildContext context;
  FirebaseUser _user;
  final _auth = FirebaseAuth.instance;
  $AppAuthState(this.context);
  @override
  Stream<dynamic> mapEventToState(event$.isAutheticated event) async* {
    _user = await FirebaseAuth.instance.currentUser();
    print('Trigger: $event; USER $_user');
    // if (_user == null) {
    //   Navigator.of(context)
    //       .pushNamedAndRemoveUntil('login', (Route<dynamic> route) => false);
    // }

    ///Listen for auth state (sign in and out event)
    if (event == event$.isAutheticated.listen) {
      if (_user == null) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
      }
      yield* _authState();
    }

    //Lsten for user sign out
    if (event == event$.isAutheticated.signOut) {
      yield* _authSignOut();
    }

    /// fetch User Data
    if (event == event$.isAutheticated.userData) {
      yield* _userData(_user);
    }
  }

  Stream<UsersProfile> _userData(user) async* {
    if (user != null) {
      final data =
          await Firestore().collection('user').document(user.uid).get();
      yield UsersProfile.toObject(data.data);
    }
  }

  Stream<FirebaseUser> _authState() async* {
    _user = await FirebaseAuth.instance.currentUser();

    yield _user;
  }

  Stream<FirebaseUser> _authSignOut() async* {
    await _auth.signOut();
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
  }
}

class StartupState$ extends Bloc<event$.startUp, dynamic> {
  @override
  get initialState => null;
  FirebaseUser _user;
  final _auth = FirebaseAuth.instance;
  get _startup => Startup();
  final db = Firestore.instance;
  @override
  Stream mapEventToState(event$.startUp event) {
    return null;
  }

  Stream<List<Startup>> list() async* {}

  Stream<List<Startup>> myList() async* {}
}
