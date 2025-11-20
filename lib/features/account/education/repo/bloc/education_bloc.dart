import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ghorx_mobile_app_new/features/account/education/repo/education_repo.dart';
import 'package:ghorx_mobile_app_new/features/account/education/repo/model/educationmodel.dart';

part 'education_event.dart';
part 'education_state.dart';

class EducationBloc extends Bloc<EducationEvent, EducationState> {
  final EducationRepo repository;
  EducationBloc({required this.repository}) 
    : super(EducationInitial()) {
    on<FetchEducation>(fetchEducationInfo);
  }

  Future<void> fetchEducationInfo(
    FetchEducation event,
    Emitter<EducationState> emit,
  ) async {
    emit(EducationLoading());

    try {
      final education = await repository.fetchEducationInfo();
      emit(EducationListState(educationResponse: education));
    } catch (e) {
      emit(EducationError(message: e.toString()));
  }
}
}
