part of 'license_bloc.dart';

sealed class LicenseEvent extends Equatable {
  const LicenseEvent();

  @override
  List<Object> get props => [];
}

class FetchLicense extends LicenseEvent {}
