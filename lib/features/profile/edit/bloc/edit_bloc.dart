import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'edit_event.dart';
part 'edit_state.dart';

class EditBloc extends Bloc<EditEvent, EditState> {
  EditBloc() : super(EditInitial()) {
    on<EditEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
