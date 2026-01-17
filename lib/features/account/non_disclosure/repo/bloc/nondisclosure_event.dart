part of 'nondisclosure_bloc.dart';

abstract class NonDisclosureEvent {}

class AddNonDisclosureEvent extends NonDisclosureEvent {
  final String id;
  final String value;

  AddNonDisclosureEvent({
    required this.id,
    required this.value
  });

  @override
  List<Object> get props => [id];
}

class FetchNonDisclosureEvent extends NonDisclosureEvent {}
