part of 'profile_info_bloc.dart';

sealed class ProfileInfoState extends Equatable {
  const ProfileInfoState();

  @override
  List<Object> get props => [];
}

final class ProfileInfoInitial extends ProfileInfoState {}

final class ProfileInfoLoading extends ProfileInfoState {}

//  personal info
class PersonalInfoState extends ProfileInfoState {
  final PersonalInfoModel personalInfomodel;

  const PersonalInfoState({required this.personalInfomodel});

  @override
  List<Object> get props => [personalInfomodel];
}

// Error state
class ProfileInfoError extends ProfileInfoState {
  final String message;

  const ProfileInfoError({required this.message});

  @override
  List<Object> get props => [message];
}
