import 'package:flutter/material.dart';

class PAYMENT {
  String paymentId,
      agentUid,
      clientUid,
      amount,
      status,
      requestPayment,
      makePayment,
      confirmPayment,
      hasPaid,
      time,
      startTime,
      endTime;

  PAYMENT(
      {@required this.paymentId,
      @required this.agentUid,
      @required this.clientUid,
      @required this.amount,
      @required this.status,
      @required this.requestPayment,
      @required this.makePayment,
      @required this.confirmPayment,
      @required this.hasPaid,
      @required this.time,
      @required this.startTime,
      @required this.endTime});

  factory PAYMENT.object(Map map) {
    return PAYMENT(
        paymentId: map['paymentId'],
        agentUid: map['agentUid'],
        clientUid: map['clientUid'],
        amount: map['amount'],
        status: map['status'],
        requestPayment: map['requestPayment'],
        makePayment: map['makePayment'],
        confirmPayment: map['confirmPayment'],
        hasPaid: map['hasPaid'],
        time: map['time'],
        startTime: map['startTime'],
        endTime: map['endTime']);
  }
}
