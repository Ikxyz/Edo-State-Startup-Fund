import 'package:flutter/material.dart';

class UsersProfile {
  String firstName,
      lastName,
      email,
      tel,
      address,
      city,
      state,
      country,
      zip,
      passport,
      identification,
      utilityBill,
      uid;
  int time;
  double latitude, longitude;
  bool isAdmin, isAgent, isMember, isDev, isVerified, isOrg;
  dynamic online;
  UsersProfile(
      {@required this.firstName,
      @required this.lastName,
      @required this.address,
      @required this.tel,
      this.state,
      this.email,
      this.isAdmin,
      this.isAgent,
      this.isOrg,
      this.isDev,
      this.isMember,
      this.city,
      this.country,
      this.zip,
      this.passport,
      this.identification,
      this.utilityBill,
      this.uid,
      this.time,
      this.online,
      this.isVerified,
      this.latitude,
      this.longitude});

  factory UsersProfile.object(Map map) {
    if (map == null) return null;
    return UsersProfile(
        firstName: map['firstName'],
        lastName: map['lastName'],
        email: map['email'],
        tel: map['tel'],
        state: map['state'],
        address: map['address'],
        isAdmin: map['isAdmin'],
        isAgent: map['isAgent'],
        isDev: map['isDev'],
        isOrg: map['isOrg'],
        isMember: map['isMember'],
        city: map['city'],
        country: map['country'],
        zip: map['zip'],
        passport: map['passport'],
        identification: map['identification'],
        utilityBill: map['utility_bill'],
        uid: map['uid'],
        time: map['time'],
        latitude: map['latitude'],
        longitude: map['longitude'],
        isVerified: map['isVerified'],
        online: map['online']);
  }
}
