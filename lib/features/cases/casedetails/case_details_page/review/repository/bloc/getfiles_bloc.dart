import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'getfiles_event.dart';
part 'getfiles_state.dart';

class GetfilesBloc extends Bloc<GetfilesEvent, GetfilesState> {
  GetfilesBloc() : super(GetfilesInitial()) {
    on<GetfilesEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
