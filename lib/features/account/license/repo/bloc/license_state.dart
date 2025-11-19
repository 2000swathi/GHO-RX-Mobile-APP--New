part of 'license_bloc.dart';

sealed class LicenseState extends Equatable {
  const LicenseState();

  @override
  List<Object> get props => [];
}

final class LicenseLoading extends LicenseState {}
final class LicenseeditLoading extends LicenseState {}
final class LicenseaddLoading extends LicenseState {}

final class LicenseInitial extends LicenseState {}

//   license list
class Licensegetsuccess extends LicenseState {
  final LicenseModel licenseModel;

  const Licensegetsuccess({required this.licenseModel});

  @override
  List<Object> get props => [LicenseModel];
}

//edit add
final class LicSuccess extends LicenseState {
  final String message;

  const LicSuccess({required this.message});

  @override
  List<Object> get props => [message];
}
//error
class LicenseError extends LicenseState {
  final String message;

  const LicenseError({required this.message});

  @override
  List<Object> get props => [message];
}
