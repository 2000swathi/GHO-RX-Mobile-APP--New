import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ghorx_mobile_app_new/features/account/experience/repo/experience_repo.dart';
import 'package:ghorx_mobile_app_new/features/account/experience/repo/model/experience_model.dart';

part 'professinal_experince_event.dart';
part 'professinal_experince_state.dart';

class ProfessinalExperinceBloc
    extends Bloc<ProfessinalExperinceEvent, ProfessinalExperinceState> {
  final ProfessionalExperienceRepo repository;
  ProfessinalExperinceBloc({required this.repository})
    : super(ProfessinalExperinceInitial()) {
    on<FetchExperience>(fetchExperience);
    on<AddExperience>(addExperience);
    on<EditExperience>(editExperience);
  }

  //fetch experience
  Future<void> fetchExperience(
    FetchExperience event,
    Emitter<ProfessinalExperinceState> emit,
  ) async {
    emit(ProfessinalExperinceLoading());

    try {
      final experience = await repository.fetchExperience();
      emit(ProfessinalExperinceListState(experienceResponse: experience));
    } catch (e) {
      emit(ExpError(message: e.toString()));
    }
  }

  //add experience
  Future<void> addExperience(
    AddExperience event,
    Emitter<ProfessinalExperinceState> emit,
  ) async {
    emit(ProfessinalExperinceAddLoading());

    try {
      final response = await repository.addExperience(
        institution: event.institution,
        designation: event.designation,
        fromMonth: event.fromMonth,
        fromYear: event.fromYear,
        toMonth: event.toMonth,
        toYear: event.toYear,
        comments: event.comments,
      );
      if (response["Status"] == 1) {
        String message = "Suucessfully added experience";

        final data = response["Data"];
        if (data is List && data.isNotEmpty) {
          final firstItem = data[0];
          if (firstItem is List && firstItem.isNotEmpty) {
            final firstElement = firstItem[0];
            if (firstElement is Map && firstElement["msg"] != null) {
              message = firstElement["msg"].toString();
            }
          }
        }
        emit(ExpSuccess(message: message));
      } else {
        final error =
            response["Error"]?.toString() ?? "Failed to add experience";
        emit(ExpError(message: error));
      }
    } catch (e) {
      emit(ExpError(message: e.toString()));
    }
  }

  //edit experience
  Future<void> editExperience(
    EditExperience event,
    Emitter<ProfessinalExperinceState> emit,
  ) async {
    emit(ProfessinalExperinceEditLoading());

    try {
      final response = await repository.editExperience(
        id: event.id,
        institution: event.institution,
        designation: event.designation,
        fromMonth: event.fromMonth,
        fromYear: event.fromYear,
        toMonth: event.toMonth,
        toYear: event.toYear,
        comments: event.comments,
      );

      if (response["Status"] == 1) {
        String message = "Suucessfully edited experience";

        final data = response["Data"];
        if (data is List && data.isNotEmpty) {
          final firstItem = data[0];
          if (firstItem is List && firstItem.isNotEmpty) {
            final firstElement = firstItem[0];
            if (firstElement is Map && firstElement["msg"] != null) {
              message = firstElement["msg"].toString();
            }
          }
        }
        emit(ExpSuccess(message: message));
      } else {
        final error =
            response["Error"]?.toString() ?? "Failed to update experience";
        emit(ExpError(message: error));
      }
    } catch (e) {}
  }
}
