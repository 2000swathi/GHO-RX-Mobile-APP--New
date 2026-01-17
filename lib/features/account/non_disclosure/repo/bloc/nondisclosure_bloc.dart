import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ghorx_mobile_app_new/features/account/non_disclosure/repo/nondisclosure_repo.dart';

part 'nondisclosure_event.dart';
part 'nondisclosure_state.dart';

class NondisclosureBloc extends Bloc<NonDisclosureEvent, NondisclosureState> {
  final NonDisclosureRepo repo;

  NondisclosureBloc({required this.repo}) : super(NondisclosureInitial()) {
    on<FetchNonDisclosureEvent>(onfetchNondisclosure); 
    on<AddNonDisclosureEvent>(onaddNondisclosure);
  }

  Future<void> onfetchNondisclosure(
    FetchNonDisclosureEvent event,
    Emitter<NondisclosureState> emit,
  ) async {
    emit(NondisclosureLoading("")); // Emit loading for initial fetch

    try {
      final response = await repo.fetchNonDisclosure();
        emit(NondisclosureSuccess(response));
    } catch (e) {
      emit(NonDisclosureError(message: e.toString(), conflictId: ""));
    }
  }

  Future<void> onaddNondisclosure(
    AddNonDisclosureEvent event,
    Emitter<NondisclosureState> emit,
  ) async {
    emit(NondisclosureLoading(event.id));

    try {
      final response = await repo.addNonDisclosure(
        event.id,
        event.value,
      );
      if (response['Status'] == 1) {
        add(FetchNonDisclosureEvent());
      } else {
        emit(
          NonDisclosureError(
            message: response['Info'] ?? "Failed to add",
            conflictId: event.id,
          ),
        );
      }
    } catch (e) {
      emit(
        NonDisclosureError(
          message: e.toString(),
          conflictId: event.id,
        ),
      );
    }
  }
}
