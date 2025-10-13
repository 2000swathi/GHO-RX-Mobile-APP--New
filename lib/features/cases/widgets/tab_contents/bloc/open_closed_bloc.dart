import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'open_closed_event.dart';
part 'open_closed_state.dart';

class OpenClosedBloc extends Bloc<OpenClosedEvent, OpenClosedState> {
  OpenClosedBloc() : super(OpenClosedInitial()) {
    on<OpenClosedEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
