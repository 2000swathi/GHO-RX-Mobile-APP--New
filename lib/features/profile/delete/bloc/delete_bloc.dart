import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghorx_mobile_app_new/features/profile/delete/repository/delete_repository.dart';
part 'delete_event.dart';
part 'delete_state.dart';

class DeleteBloc extends Bloc<DeleteEvent, DeleteState> {
  final DeleteProfileRepository repository;

  DeleteBloc({required this.repository}) : super(DeleteInitial()) {
    on<DeleteProfileItem>(_onDeleteProfileItem);
  }
  Future<void> _onDeleteProfileItem(
    DeleteProfileItem event,
    Emitter<DeleteState> emit,
  ) async {
    emit(DeleteLoading());  

    try{
      final response = await repository.deleteInfo(
        id: event.id,
        action: event.action,
        isLang: event.isLang,
      );

      if (response["Status"] == 1) {
        final message = response["Data"][0][0]["msg"] ?? "Deleted Successfully";
        emit(DeleteSuccess(message: message));
      }else {
        emit(DeleteFailure(error: "Failed to delete"));
      }
    } catch (e) {
      emit(DeleteFailure(error: e.toString()));
    }
  }
}
