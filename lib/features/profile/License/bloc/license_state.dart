part of 'license_bloc.dart';

sealed class LicenseState extends Equatable {
  const LicenseState();

  @override
  List<Object> get props => [];
}

final class LicenseLoading extends LicenseState {}

final class LicenseInitial extends LicenseState {}

//   license list
class License extends LicenseState {
  final LicenseModel licenseModel;

  const License({required this.licenseModel});

  @override
  List<Object> get props => [LicenseModel];
}

class LicenseError extends LicenseState {
  final String message;

  const LicenseError({required this.message});

  @override
  List<Object> get props => [message];
}
