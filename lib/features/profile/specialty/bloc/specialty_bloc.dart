import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'specialty_event.dart';
part 'specialty_state.dart';

class SpecialtyBloc extends Bloc<SpecialtyEvent, SpecialtyState> {
  SpecialtyBloc() : super(SpecialtyInitial()) {
    on<SpecialtyEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
