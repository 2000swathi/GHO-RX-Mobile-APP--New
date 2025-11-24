part of 'profile_info_bloc.dart';

sealed class ProfileInfoEvent extends Equatable {
  const ProfileInfoEvent();

  @override
  List<Object> get props => [];
}
class FetchPersonalInfo extends ProfileInfoEvent {}

class EditInfoEvent extends ProfileInfoEvent {
  final Map<String, dynamic> data;

  const EditInfoEvent({required this.data});

  @override
  List<Object> get props => [data];
}
