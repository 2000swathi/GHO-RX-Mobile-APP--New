import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ghorx_mobile_app_new/features/account/documents/repo/doct_file_repo.dart';

part 'doctfile_event.dart';
part 'doctfile_state.dart';

class DoctfileBloc extends Bloc<DoctfileEvent, DoctfileState> {
  final DoctFileRepo repository;
  DoctfileBloc({required this.repository}) : super(DoctfileInitial()) {
    on<UploadDocFileEvent>((event, emit) async {
      emit(DoctfileLoading());
      try {
        final response = await repository.fetchDoctFile();
        if (response["Status"] != 1) {
          emit(
            DoctfileFailure(
              error: response["Info"] ?? "Failed to upload document file",
            ),
          );
          return;
        }
        emit(DoctfileSuccess(response: response));
      } catch (e) {
        emit(DoctfileFailure(error: e.toString()));
      }
    });
  }
}
