import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ghorx_mobile_app_new/features/profile/edit/repository/edit_repository.dart';

part 'edit_event.dart';
part 'edit_state.dart';

class EditBloc extends Bloc<EditEvent, EditState> {
  final EditprofileRepository repository;

  EditBloc({required this.repository}) : super(EditInitial()) {
    on<EditInfoEvent>(_onEditInfo);
  }

  Future<void> _onEditInfo(
    EditInfoEvent event,
    Emitter<EditState> emit,
  ) async {
    emit(EditLoading());
    try {
      
      final response = await repository.editPersonalInfo(event.data);
      
      final message = response['Info'] ?? "Profile updated successfully";
      emit(EditSuccess(message: message));
    } catch (e) {
      emit(EditFailure(error: e.toString()));
    }
  }
}
