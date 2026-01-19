part of 'conflict_interest_bloc.dart';

abstract class ConflictInterestEvent {}

class AddConflictInterestEvent extends ConflictInterestEvent {
  final String conflictId;
  final String value;

  AddConflictInterestEvent({required this.conflictId, required this.value});

  @override
  List<Object?> get props => [conflictId];
}

class FetchConflictInterestEvent extends ConflictInterestEvent {}
