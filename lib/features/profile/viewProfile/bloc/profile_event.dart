import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class FetchPersonalInfo extends ProfileEvent {}

class FetchSpecialty extends ProfileEvent {}

class FetchInsurance extends ProfileEvent {}

class FetchLicence extends ProfileEvent {}
class FetchBankInfo extends ProfileEvent {}

class FetchAccreditation extends ProfileEvent {}

class FetchLanguage extends ProfileEvent {}
