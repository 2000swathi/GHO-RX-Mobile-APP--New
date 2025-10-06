part of 'personal_info_bloc.dart';

sealed class PersonalInfoState extends Equatable {
  const PersonalInfoState();

  @override
  List<Object?> get props => [];
}

final class PersonalInfoInitial extends PersonalInfoState {}

final class PersonalInfoLoading extends PersonalInfoState {}

final class PersonalInfoLoaded extends PersonalInfoState {
  final List<Map<String, dynamic>> countries; 
  final String? selectedCountryID;
  final String? selectedCountryName;
  final String? selectedCountryCode;

  const PersonalInfoLoaded({
    required this.countries,
    this.selectedCountryID,
    this.selectedCountryName,
    this.selectedCountryCode,
  });

  @override
  List<Object?> get props =>
      [countries, selectedCountryID ?? '', selectedCountryName ?? '', selectedCountryCode ?? ''];
}

final class PersonalInfoError extends PersonalInfoState {
  final String message;

  const PersonalInfoError(this.message);

  @override
  List<Object?> get props => [message];
}