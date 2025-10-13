import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghorx_mobile_app_new/features/profile/add/repository/add_profile_repo.dart';

part 'add_event.dart';
part 'add_state.dart';

class AddBloc extends Bloc<AddEvent, AddState> {
    final AddProfileRepository repository;
    
    AddBloc({required this.repository}) : super(AddInitial()) {
   
  }

   Future<void> _onFetchProfile(
    AddInfoEvent event,
    Emitter<AddState> emit,
  ) async {
    emit(AddLoading());

    try {
      final addspecialty = await repository.addSpecialty();
      emit(AddSpecialtyInfoState());
    } catch (e) {
      emit(AddError(message: e.toString()));
    }
  }

}
