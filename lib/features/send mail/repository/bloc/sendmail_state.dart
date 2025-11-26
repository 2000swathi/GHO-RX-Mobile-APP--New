part of 'sendmail_bloc.dart';

sealed class SendmailState extends Equatable {
  const SendmailState();

  @override
  List<Object> get props => [];
}

final class SendmailInitial extends SendmailState {}

final class SendmailLoading extends SendmailState {}

final class SendmailSuccess extends SendmailState {
  final String message;

  const SendmailSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

final class SendmailFailure extends SendmailState {
  final String error;

  const SendmailFailure({required this.error});

  @override
  List<Object> get props => [error];
}
