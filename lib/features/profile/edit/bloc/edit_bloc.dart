import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghorx_mobile_app_new/features/profile/edit/repository/edit_repository.dart';
part 'edit_event.dart';
part 'edit_state.dart';

class EditBloc extends Bloc<EditEvent, EditState> {
  final EditprofileRepository repository;

  EditBloc({required this.repository}) : super(EditInitial()) {
    on<EditInfoEvent>(_onEditInfo);
    on<EditLicenseEvent>(_onEditLicense);
    on<EditLanguageEvent>(_onEditLanguage);
    on<EditBankInfoEvent>(_onEditBankInfo);
    on<EditSpecialtyEvent>(_editSpecialty);
    on<EditAcreditationEvent>(_editAccreditation);
    on<EditInsuranceEvent>(_editInsurance);
  }

  //profile Bloc
  Future<void> _onEditInfo(EditInfoEvent event, Emitter<EditState> emit) async {
    emit(EditLoading());
    try {
      final response = await repository.editPersonalInfo(event.data);

      final message = response["Data"][0][0]["msg"] ?? "profile updated successfully";
      emit(EditSuccess(message: message));
    } catch (e) {
      emit(EditFailure(error: e.toString()));
    }
  }

  //SpecialtyF
  Future<void> _editSpecialty(
    EditSpecialtyEvent event,
    Emitter<EditState> emit,
  ) async {
    emit(EditLoading());

    try {
      final response = await repository.editSpecialty(
        specialtyId: event.specialtyId,
        id: event.id,
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

  //Edit license
  Future<void> _onEditLicense(
    EditLicenseEvent editevent,
    Emitter<EditState> emit,
  ) async {
    emit(EditLoading());
    try {
      final licenseresponse = await repository.editLicense(
        licenseNumber: editevent.licenseNumber,
        // issuingAuthority: editevent.issuingAuthority,
        licenseType: editevent.licenseType.toString(),
        issueDate: editevent.issueDate,
        expiryDate: editevent.expiryDate,
        id: editevent.id,
      );

      final message = licenseresponse['Info'] ?? "License updated successfully";
      emit(EditSuccess(message: message));
    } catch (e) {
      emit(EditFailure(error: e.toString()));
    }
  }

  //language
  Future<void> _onEditLanguage(
    EditLanguageEvent editevent,
    Emitter<EditState> emit,
  ) async {
    emit(EditLoading());
    try {
      final languageRespone = await repository.editLanguage(
        language: editevent.language,
        proficiency: editevent.proficiency,
        id: editevent.id,
      );

      final message =
          languageRespone['Info'] ?? "Language updated successfully";
      emit(EditSuccess(message: message));
    } catch (e) {
      emit(EditFailure(error: e.toString()));
    }
  }

  //Bank Info
  Future<void> _onEditBankInfo(
    EditBankInfoEvent editBankevent,
    Emitter<EditState> emit,
  ) async {
    emit(EditLoading());
    try {
      final bankInforesponse = await repository.editBankInfo(
        accountType: editBankevent.accountType,
        routingNumber: editBankevent.routingNumber,
        accountNumber: editBankevent.accountNumber,
        holderName: editBankevent.holderName,
        id: editBankevent.id,
      );

      final message =
          bankInforesponse['Info'] ?? "Profile updated successfully";
      emit(EditSuccess(message: message));
    } catch (e) {
      emit(EditFailure(error: e.toString()));
    }
  }
}
