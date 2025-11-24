part of 'change_password_bloc.dart';

sealed class ChangePasswordState extends Equatable {
  const ChangePasswordState();

  @override
  List<Object> get props => [];
}

final class ChangePasswordInitial extends ChangePasswordState {}

final class CPLoading extends ChangePasswordState {}

final class CPSuccess extends ChangePasswordState {
  final String message;
  const CPSuccess({required this.message});
  @override
  List<Object> get props => [message];
}

final class CPError extends ChangePasswordState {
  final String message;
  const CPError({required this.message});
  @override
  List<Object> get props => [message];
}
