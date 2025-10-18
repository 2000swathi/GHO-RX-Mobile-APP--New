import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/features/profile/add/bloc/add_bloc.dart';

abstract class AddEvent {}

//license
class AddLicense extends AddEvent {
  final String licenseNumber;
  final String licenseType;
  final String issueDate;
  final String expiryDate;
  AddLicense({
    required this.licenseNumber,
    required this.licenseType,
    required this.issueDate,
    required this.expiryDate,
  });
}

//language
class AddLanguage extends AddEvent {
  String language;
  String proficiency;
  AddLanguage(this.language, this.proficiency);
}

//Bank info

class AddBankInfo extends AddEvent {
  final String accountType;
  final String routingNumber;
  final String accountNumber;
  final String holderName;

  AddBankInfo({
    required this.accountNumber,
    required this.accountType,
    required this.holderName,
    required this.routingNumber,
  });
}
