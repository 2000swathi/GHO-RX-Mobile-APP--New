import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ghorx_mobile_app_new/features/account/specialty/repo/specialty_repo.dart';
import 'package:ghorx_mobile_app_new/features/account/specialty/repo/model/specialty_model.dart';
part 'specialty_event.dart';
part 'specialty_state.dart';

class SpecialtyBloc extends Bloc<SpecialtyEvent, SpecialtyState> {
  final SpecialtyRepo repository;

  SpecialtyBloc({required this.repository}) : super(SpecialtyInitial()) {
    on<FetchSpecialty>(_onFetchSpecialty);
    on<AddSpecialty>(_onAddSpecialty);
    on<EditSpecialtyEvent>(_editSpecialty);
  }
  //specialty
  Future<void> _onFetchSpecialty(
    FetchSpecialty event,
    Emitter<SpecialtyState> emit,
  ) async {
    emit(SpecialityLoading());

    try {
      final specialties = await repository.fetchSpecialtyInfo();
      emit(SpecialtyGetState(specialtyModel: specialties));
    } catch (e) {
      emit(SpecialtyError(message: e.toString()));
    }
  }

  //specialty
  Future<void> _onAddSpecialty(
    AddSpecialty event,
    Emitter<SpecialtyState> emit,
  ) async {
    emit(SpecialityAddLoading());

    try {
      final response = await repository.addSpecialty(
        specialtyID: event.specialty,
        certifiedBoardId: event.certifiedBoard,
        specialtyTypeID: event.specialtyType,
      );
      if (response["Status"] == 1) {
        String message = "Added Successfully";
        final data = response["Data"];
        if (data is List && data.isNotEmpty) {
          final firstLevel = data[0];
          if (firstLevel is List && firstLevel.isNotEmpty) {
            final msgObject = firstLevel[0];
            if (msgObject is Map && msgObject["msg"] != null) {
              message = msgObject["msg"].toString();
            }
          }
        }
        emit(SpecialtySuccess(message: message));
      }
    } catch (e) {
      emit(SpecialtyError(message: "An error occurred: ${e.toString()}"));
    }
  }

  //Specialty
  Future<void> _editSpecialty(
    EditSpecialtyEvent event,
    Emitter<SpecialtyState> emit,
  ) async {
    emit(SpecialityEditLoading());

    try {
      final response = await repository.editSpecialty(
        specialtyId: event.specialtyId,
        id: event.id,
        certifiedBoardName: event.certifiedBoard,
        specialtyTypeId: event.specialtyType,
      );

      if (response["Status"] == 1) {
        String message = "Updated Successfully";
        final data = response["Data"];
        if (data is List && data.isNotEmpty) {
          final firstLevel = data[0];
          if (firstLevel is List && firstLevel.isNotEmpty) {
            final msgObject = firstLevel[0];
            if (msgObject is Map && msgObject["msg"] != null) {
              message = msgObject["msg"].toString();
            }
          }
        }
        emit(SpecialtySuccess(message: message));
      } else {
        final error =
            response["Error"]?.toString() ?? "Failed to update specialty";
        emit(SpecialtyError(message: error));
      }
    } catch (e) {
      emit(SpecialtyError(message: e.toString()));
    }
  }
}
