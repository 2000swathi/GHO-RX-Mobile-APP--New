import 'package:equatable/equatable.dart';
import 'package:ghorx_mobile_app_new/features/profile/Bank_info/model/bankinfo_model.dart';
import 'package:ghorx_mobile_app_new/features/profile/insurances/model/insurance_model.dart';
import 'package:ghorx_mobile_app_new/features/profile/language/model/language_model.dart';
import 'package:ghorx_mobile_app_new/features/profile/License/model/license_model.dart';
import 'package:ghorx_mobile_app_new/features/profile/profile%20Info/model/personalinfo_model.dart';
import 'package:ghorx_mobile_app_new/features/profile/specialty/model/specialty_model.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

// Initial state
