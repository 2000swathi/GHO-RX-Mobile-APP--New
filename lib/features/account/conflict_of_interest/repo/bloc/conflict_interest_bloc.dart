import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ghorx_mobile_app_new/features/account/conflict_of_interest/repo/conflict_repo.dart';

part 'conflict_interest_event.dart';
part 'conflict_interest_state.dart';

class ConflictInterestBloc
    extends Bloc<ConflictInterestEvent, ConflictInterestState> {
  final ConflictOfInterestRepo repo;

  ConflictInterestBloc({required this.repo})
    : super(ConflictInterestInitial()) {
    on<FetchConflictInterestEvent>(_onfetchConflictInterest);
    on<AddConflictInterestEvent>(_onaddConflictInterest);
  }

  Future<void> _onfetchConflictInterest(
    FetchConflictInterestEvent event,
    Emitter<ConflictInterestState> emit,
  ) async {
    emit(ConflictInterestLoading("")); // Emit loading for initial fetch

    try {
      final response = await repo.fetchConflictInterest();
        emit(ConflictInterestSuccess(response));
    } catch (e) {
      emit(ConflictInterestError(message: e.toString(), conflictId: ""));
    }
  }

  Future<void> _onaddConflictInterest(
    AddConflictInterestEvent event,
    Emitter<ConflictInterestState> emit,
  ) async {
    emit(ConflictInterestLoading(event.conflictId));

    try {
      final response = await repo.addConflictInterest(
        event.conflictId,
        event.value,
      );
      if (response['Status'] == 1) {
        add(FetchConflictInterestEvent());
      } else {
        emit(
          ConflictInterestError(
            message: response['Info'] ?? "Failed to add",
            conflictId: event.conflictId,
          ),
        );
      }
    } catch (e) {
      emit(
        ConflictInterestError(
          message: e.toString(),
          conflictId: event.conflictId,
        ),
      );
    }
  }
}
