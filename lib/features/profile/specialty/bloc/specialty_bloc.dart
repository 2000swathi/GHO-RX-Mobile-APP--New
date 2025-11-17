import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ghorx_mobile_app_new/features/profile/specialty/specialty_repo.dart';
import 'package:ghorx_mobile_app_new/features/profile/specialty/model/specialty_model.dart';
part 'specialty_event.dart';
part 'specialty_state.dart';

class SpecialtyBloc extends Bloc<SpecialtyEvent, SpecialtyState> {
  final SpecialtyRepo repository;

  SpecialtyBloc({required this.repository}) : super(SpecialtyInitial()) {
    on<FetchSpecialty>(_onFetchSpecialty);
  }
  //specialty
  Future<void> _onFetchSpecialty(
    FetchSpecialty event,
    Emitter<SpecialtyState> emit,
  ) async {
    emit(SpecialityLoading());

    try {
      final specialties = await repository.fetchSpecialtyInfo();
      emit(Specialty(specialtyModel: specialties));
    } catch (e) {
      emit(SpecialityError(message: e.toString()));
    }
  }
}
