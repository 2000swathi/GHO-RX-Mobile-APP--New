import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ghorx_mobile_app_new/features/profile/edit/repository/edit_repository.dart';

part 'edit_event.dart';
part 'edit_state.dart';

class EditBloc extends Bloc<EditEvent, EditState> {
  final EditprofileRepository repository;

  EditBloc({required this.repository}) : super(EditInitial()) {
    on<EditInfoEvent>(_onEditInfo);
    on<EditSpecialtyEvent>(_editSpecialty);
    on<EditAcreditationEvent>(_editAccreditation);
    on<EditInsuranceEvent>(_editInsurance);
  }

  //personal info
  Future<void> _onEditInfo(EditInfoEvent event, Emitter<EditState> emit) async {
    emit(EditLoading());
    try {
      final response = await repository.editPersonalInfo(event.data);

      final message = response['Info'] ?? "Profile updated successfully";
      emit(EditSuccess(message: message));
    } catch (e) {
      emit(EditFailure(error: e.toString()));
    }
  }

  //Specialty
  Future<void> _editSpecialty(
    EditSpecialtyEvent event,
    Emitter<EditState> emit,
  ) async {
    emit(EditLoading());

    try {
      final response = await repository.editSpecialty(
        specialtyId: event.specialtyId,
        specialty: event.specialty,
        certifiedBoard: event.certifiedBoard,
        specialtyType: event.specialtyType,
      );

      if (response["Status"] == 1) {
        final message = response["Data"][0][0]["msg"] ?? "Updated Successfully";
        emit(EditSuccess(message: message));
      } else {
        final error = response["Error"] ?? "Failed to update specialty";
        emit(EditFailure(error: error));
      }
    } catch (e) {
      emit(EditFailure(error: e.toString()));
    }
  }

  //Accreditaion
  Future<void> _editAccreditation(
    EditAcreditationEvent event,
    Emitter<EditState> emit,
  ) async {
    emit(EditLoading());

    try {
      final response = await repository.editAccreditation(
        accreditationId: event.accreditationId,
        accreditationtype: event.accreditationtype,
        accreditationbody: event.accreditationbody,
        accreditationnumber: event.accreditationnumber,
      );

      if (response["Status"] == 1) {
        final message = response["Data"][0][0]["msg"] ?? "Updated Successfully";
        emit(EditSuccess(message: message));
      } else {
        final error = response["Error"] ?? "Failed to update accreditation";
        emit(EditFailure(error: error));
      }
    } catch (e) {
      emit(EditFailure(error: e.toString()));
    }
  }

  //Insurance
  Future<void> _editInsurance(
    EditInsuranceEvent event,
    Emitter<EditState> emit,
  ) async {
    emit(EditLoading());

    try {
      final response = await repository.editInsurance(
        insuranceId: event.insuranceId,
        providerID: event.providerID,
        providerName: event.providerName,
        issueDate: event.issueDate,
        expiryDate: event.expiryDate,
      );
      if (response["Status"] == 1) {
        final message =
            response["Data"][0][0]["message"] ?? "Updated Successfully";
        emit(EditSuccess(message: message));
      } else {
        final error = response["Error"] ?? "Failed to update insurance";
        emit(EditFailure(error: error));
      }
    } catch (e) {
      emit(EditFailure(error: e.toString()));
    }
  }
}
