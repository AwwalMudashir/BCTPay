// To parse this JSON data, do
//
//     final paymentLinkReqModel = paymentLinkReqModelFromJson(jsonString);

import 'dart:convert';

PaymentLinkReqModel paymentLinkReqModelFromJson(String str) =>
    PaymentLinkReqModel.fromJson(json.decode(str));

String paymentLinkReqModelToJson(PaymentLinkReqModel data) =>
    json.encode(data.toJson());

class PaymentLinkReqModel {
  final String? institutionName;
  final String? transactionNote;
  final dynamic transactionRefNumber;
  final String? amount;
  final String? currency;
  final String? liveMode;
  final String? eventId;
  final String? eventRefNumber;
  final Payerdata? payerdata;
  final List<TicketData>? ticketdata;
  final String? phoneCode;
  final String? phoneNumber;
  final String? accountType;

  PaymentLinkReqModel({
    this.institutionName,
    this.transactionNote,
    this.transactionRefNumber,
    this.amount,
    this.currency,
    this.liveMode,
    this.eventId,
    this.eventRefNumber,
    this.payerdata,
    this.ticketdata,
    this.phoneCode,
    this.phoneNumber,
    this.accountType,
  });

  factory PaymentLinkReqModel.fromJson(Map<String, dynamic> json) =>
      PaymentLinkReqModel(
        institutionName: json["institution_name"],
        transactionNote: json["transaction_note"],
        transactionRefNumber: json["transaction_ref_number"],
        amount: json["amount"],
        currency: json["currency"],
        liveMode: json["live_mode"],
        eventId: json["event_id"],
        eventRefNumber: json["event_ref_number"],
        payerdata: json["payerdata"] == null
            ? null
            : Payerdata.fromJson(json["payerdata"]),
        ticketdata: json["ticketdata"] == null
            ? []
            : List<TicketData>.from(
                json["ticketdata"]!.map((x) => TicketData.fromJson(x))),
        phoneCode: json["phone_code"],
        phoneNumber: json["phone_number"],
        accountType: json["account_type"],
      );

  Map<String, dynamic> toJson() => {
        "institution_name": institutionName,
        "transaction_note": transactionNote,
        "transaction_ref_number": transactionRefNumber,
        "amount": amount,
        "currency": currency,
        "live_mode": liveMode,
        "event_id": eventId,
        "event_ref_number": eventRefNumber,
        "payerdata": payerdata?.toJson(),
        "ticketdata": ticketdata == null
            ? []
            : List<dynamic>.from(ticketdata!.map((x) => x.toJson())),
        "phone_code": phoneCode,
        "phone_number": phoneNumber,
        "account_type": accountType,
      };
}

class Payerdata {
  final String? email;
  final String? userFullName;
  final String? phoneNumber;
  final String? organisationName;

  Payerdata({
    this.email,
    this.userFullName,
    this.phoneNumber,
    this.organisationName,
  });

  factory Payerdata.fromJson(Map<String, dynamic> json) => Payerdata(
        email: json["email"],
        userFullName: json["user_full_name"],
        phoneNumber: json["phone_number"],
        organisationName: json["organisation_name"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "user_full_name": userFullName,
        "phone_number": phoneNumber,
        "organisation_name": organisationName,
      };
}

class TicketData {
  final String? slotId;
  final String? totalTicket;
  final String? totalTicketVerified;
  final String? totalTicketPrice;
  final List<Payerdata>? attendees;
  final List? ticketVerificationHistory;

  TicketData({
    this.slotId,
    this.totalTicket,
    this.totalTicketVerified,
    this.totalTicketPrice,
    this.attendees,
    this.ticketVerificationHistory,
  });

  factory TicketData.fromJson(Map<String, dynamic> json) => TicketData(
      slotId: json["slot_id"],
      totalTicket: json["total_ticket"],
      totalTicketVerified: json["total_ticket_verified"],
      totalTicketPrice: json["total_ticket_price"],
      attendees: json["attendees"] == null
          ? []
          : List<Payerdata>.from(
              json["attendees"]!.map((x) => Payerdata.fromJson(x))),
      ticketVerificationHistory: json["ticket_verification_history"]);

  Map<String, dynamic> toJson() => {
        "slot_id": slotId,
        "total_ticket": totalTicket,
        "total_ticket_verified": totalTicketVerified,
        "total_ticket_price": totalTicketPrice,
        "attendees": attendees == null
            ? []
            : List<dynamic>.from(attendees!.map((x) => x.toJson())),
        "ticket_verification_history": ticketVerificationHistory
      };
}
