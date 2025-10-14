part of 'edit_bloc.dart';

sealed class EditEvent extends Equatable {
  const EditEvent();

  @override
  List<Object> get props => [];
}

class EditInfoEvent extends EditEvent {
  final Map<String, dynamic> data;

  const EditInfoEvent({required this.data});

  @override
  List<Object> get props => [data];
}
