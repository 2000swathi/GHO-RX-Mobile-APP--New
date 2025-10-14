import 'package:equatable/equatable.dart';
import 'package:ghorx_mobile_app_new/features/profile/viewProfile/repository/model/accreditation_model.dart';
import 'package:ghorx_mobile_app_new/features/profile/viewProfile/repository/model/insurance_model.dart';
import 'package:ghorx_mobile_app_new/features/profile/viewProfile/repository/model/language_model.dart';
import 'package:ghorx_mobile_app_new/features/profile/viewProfile/repository/model/license_model.dart';
import 'package:ghorx_mobile_app_new/features/profile/viewProfile/repository/model/personalinfo_model.dart';
import 'package:ghorx_mobile_app_new/features/profile/viewProfile/repository/model/specialty_model.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

// Initial state
class ProfileInitial extends ProfileState {}

// Loading state
class ProfileLoading extends ProfileState {}

//  personal info
class PersonalInfoState extends ProfileState {
  final PersonalInfoModel personalInfomodel;

  const PersonalInfoState({required this.personalInfomodel});

  @override
  List<Object?> get props => [personalInfomodel];
}

//   specialty list
class SpecialtyState extends ProfileState {
  final SpecialtyModel specialtyModel;

  const SpecialtyState({required this.specialtyModel});

  @override
  List<Object?> get props => [specialtyModel];
}

//   insurance list
class InsuranceState extends ProfileState {
  final InsuranceModel insuranceModel;

  const InsuranceState({required this.insuranceModel});

  @override
  List<Object?> get props => [InsuranceModel];
}

//   license list
class LicenseState extends ProfileState {
  final LicenseModel licenseModel;

  const LicenseState({required this.licenseModel});

  @override
  List<Object?> get props => [LicenseModel];
}

//     language list
class LanguageState extends ProfileState {
  final LanguageModel languageModel;

  const LanguageState({required this.languageModel});

  @override
  List<Object?> get props => [LicenseModel];
}

//Acreditation
class AccreditationState extends ProfileState {
  final AccreditationModel accreditationModel;

  const AccreditationState({required this.accreditationModel});

  @override
  List<Object?> get props => [AccreditationModel];
}


// Error state
class ProfileError extends ProfileState {
  final String message;

  const ProfileError({required this.message});

  @override
  List<Object?> get props => [message];
}

