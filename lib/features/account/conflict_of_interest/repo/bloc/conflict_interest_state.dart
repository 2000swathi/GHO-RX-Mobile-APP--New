part of 'conflict_interest_bloc.dart';

abstract class ConflictInterestState extends Equatable {
  const ConflictInterestState();

  @override
  List<Object> get props => [];
}

class ConflictInterestInitial extends ConflictInterestState {}

class ConflictInterestLoading extends ConflictInterestState {
  final String conflictId;
  const ConflictInterestLoading(this.conflictId);

  @override
  List<Object> get props => [conflictId];
}

class ConflictInterestSuccess extends ConflictInterestState {
  final Map<String, dynamic> data;

  const ConflictInterestSuccess(this.data);

  @override
  List<Object> get props => [data];
}

class ConflictInterestError extends ConflictInterestState {
  final String message;
  final String conflictId;

  const ConflictInterestError({
    required this.message,
    required this.conflictId
    });

  @override
  List<Object> get props => [message, conflictId];
}
