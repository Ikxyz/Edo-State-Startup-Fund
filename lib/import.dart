export 'package:eds_funds/classes/auth.dart';
export 'package:eds_funds/classes/category.dart';
export 'package:eds_funds/classes/classes.dart';
export 'package:eds_funds/classes/custom-clip.dart';
export 'package:eds_funds/classes/message_class.dart';
export 'package:eds_funds/classes/notification_class.dart';
export 'package:eds_funds/classes/payment_class.dart';
export 'package:eds_funds/classes/start_up.dart';
export 'package:eds_funds/classes/user_contact_class.dart';
export 'package:eds_funds/classes/user_profile_class.dart';
export 'package:eds_funds/trigger/event.dart';
export 'package:eds_funds/models/app.dart';
export 'package:eds_funds/styles/styles.dart';

export 'dart:convert';

export 'package:eds_funds/classes/user_profile_class.dart';
export 'package:firebase_auth/firebase_auth.dart';
export 'package:flutter/material.dart';
export 'package:flutter/services.dart';
export 'package:google_sign_in/google_sign_in.dart';
export 'package:cloud_firestore/cloud_firestore.dart';
export 'package:bloc/bloc.dart';
export 'package:flutter_bloc/flutter_bloc.dart';
export 'package:cached_network_image/cached_network_image.dart';
export 'classes/start_up.dart'; 

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final auth = FirebaseAuth.instance;
final db = Firestore.instance;
FirebaseUser firebaseUser;
final never = auth.onAuthStateChanged.listen((x) {
  firebaseUser = x;
});
FirebaseUser get userAuth => firebaseUser;
 