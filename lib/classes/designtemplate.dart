import 'dart:io';
import 'dart:math';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:eco_connect/classes/classes.dart';
import 'package:eco_connect/model/data.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:random_string/random_string.dart' as random;
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DesignTemplate extends Clasess {
  BuildContext context;
  ThemeData theme;

  static final GlobalKey<FormState> _profileUpdateFormKey =
      GlobalKey<FormState>();
  DesignTemplate(this.context) {
    theme = Theme.of(context);
  }
Padd
//#region textBox

  TextFormField mTextFormField(context,
      {@required onSaved,
      @required validator,
      @required hintText,
      @required labelText,
      textCapitalization: TextCapitalization.words,
      autovalidate: false,
      autocorrect: true,
      textInputAction: TextInputAction.done,
      obscureText: false,
      key,
      maxLines: 1,
      prefix,
      errorColor: Colors.red,
      keyboardType: TextInputType.text,
      errorText: 'Can\'t be left empty',
      suffix,
      helperText: "",
      prefixIcon,
      controller}) {
    return TextFormField(
      controller: controller,
      autofocus: false,
      style: TextStyle(color: Theme.of(context).primaryColor),
      decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
          prefix: prefix,
          suffix: suffix,
          helperText: helperText,
          prefixIcon: prefixIcon,
          errorText: errorText,
          hintStyle: TextStyle(color: Theme.of(context).primaryColor),
          suffixStyle: TextStyle(color: Theme.of(context).primaryColor),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
          ),
          helperStyle: TextStyle(color: Theme.of(context).primaryColor),
          labelStyle: TextStyle(color: Theme.of(context).primaryColor),
          prefixStyle: TextStyle(color: Theme.of(context).primaryColor),
          fillColor: Theme.of(context).primaryColor,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
          ),
          counterStyle: TextStyle(color: Theme.of(context).primaryColor),
          errorStyle: TextStyle(color: errorColor),
          hasFloatingPlaceholder: true),
      textCapitalization: textCapitalization,
      autovalidate: autovalidate,
      validator: validator,
      onSaved: onSaved,
      autocorrect: true,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      obscureText: obscureText,
      key: key,
      maxLines: maxLines,
    );
  }

//#endregion

}
