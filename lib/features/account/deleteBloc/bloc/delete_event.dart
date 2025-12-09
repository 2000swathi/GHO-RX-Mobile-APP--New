part of 'delete_bloc.dart';

sealed class DeleteEvent extends Equatable {
  const DeleteEvent();

  @override
  List<Object> get props => [];
}

final class DeleteProfileItem extends DeleteEvent {
  final String id;
  final String action;
  final bool isLang;

  const DeleteProfileItem({
    required this.id,
    required this.action,
    this.isLang = false,
  });

  @override
  List<Object> get props => [id, action, isLang];
}

class FetchDeleteAccount extends DeleteEvent {}
