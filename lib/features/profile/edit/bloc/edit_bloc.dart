import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghorx_mobile_app_new/features/profile/edit/repository/edit_repository.dart';
part 'edit_event.dart';
part 'edit_state.dart';

class EditBloc extends Bloc<EditEvent, EditState> {
  final EditprofileRepository repository;

  EditBloc({required this.repository}) : super(EditInitial()) {
    // on<EditInfoEvent>(_onEditInfo);
    // on<EditLicenseEvent>(_onEditLicense);
    // on<EditLanguageEvent>(_onEditLanguage);
    on<EditBankInfoEvent>(_onEditBankInfo);
    on<EditSpecialtyEvent>(_editSpecialty);
    // on<EditAcreditationEvent>(_editAccreditation);
    // on<EditInsuranceEvent>(_editInsurance);
  }

  //profile Bloc
  // Future<void> _onEditInfo(EditInfoEvent event, Emitter<EditState> emit) async {
  //   emit(EditLoading());

  //   try {
  //     final response = await repository.editPersonalInfo(event.data);

  //     if (response["Status"] == 1) {
  //       String message = "Profile updated successfully";

  //       // Safely extract nested message
  //       final data = response["Data"];
  //       if (data is List && data.isNotEmpty) {
  //         final inner = data[0];
  //         if (inner is List && inner.isNotEmpty) {
  //           final msgObject = inner[0];
  //           if (msgObject is Map && msgObject["msg"] != null) {
  //             message = msgObject["msg"].toString();
  //           }
  //         }
  //       }

  //       emit(EditSuccess(message: message));
  //     } else {
  //       emit(
  //         EditFailure(
  //           error: response["Info"]?.toString() ?? "Something went wrong",
  //         ),
  //       );
  //     }
  //   } catch (e) {
  //     emit(EditFailure(error: e.toString()));
  //   }
  // }

  //Specialty
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
        emit(EditSuccess(message: message));
      } else {
        final error =
            response["Error"]?.toString() ?? "Failed to update specialty";
        emit(EditFailure(error: error));
      }
    } catch (e) {
      emit(EditFailure(error: e.toString()));
    }
  }

  // // Accreditation
  // Future<void> _editAccreditation(
  //   EditAcreditationEvent event,
  //   Emitter<EditState> emit,
  // ) async {
  //   emit(EditLoading());

  //   try {
  //     final response = await repository.editAccreditation(
  //       accreditationId: event.accreditationId,
  //       accreditationtype: event.accreditationtype,
  //       accreditationbody: event.accreditationbody,
  //       accreditationnumber: event.accreditationnumber,
  //     );

  //     if (response["Status"] == 1) {
  //       String message = "Updated Successfully";
  //       final data = response["Data"];
  //       if (data is List && data.isNotEmpty) {
  //         final level1 = data[0];
  //         if (level1 is List && level1.isNotEmpty) {
  //           final msgObj = level1[0];
  //           if (msgObj is Map && msgObj["msg"] != null) {
  //             message = msgObj["msg"].toString();
  //           }
  //         }
  //       }
  //       emit(EditSuccess(message: message));
  //     } else {
  //       final error =
  //           response["Error"]?.toString() ?? "Failed to update accreditation";
  //       emit(EditFailure(error: error));
  //     }
  //   } catch (e) {
  //     emit(EditFailure(error: e.toString()));
  //   }
  // }

  // //Insurance
  // Future<void> _editInsurance(
  //   EditInsuranceEvent event,
  //   Emitter<EditState> emit,
  // ) async {
  //   emit(EditLoading());

  //   try {
  //     final response = await repository.editInsurance(
  //       insuranceId: event.insuranceId,
  //       providerID: event.providerID,
  //       providerName: event.providerName,
  //       issueDate: event.issueDate,
  //       expiryDate: event.expiryDate,
  //     );
  //     if (response["Status"] == 1) {
  //       final message =
  //           response["Data"][0][0]["message"] ?? "Updated Successfully";
  //       emit(EditSuccess(message: message));
  //     } else {
  //       final error = response["Error"] ?? "Failed to update insurance";
  //       emit(EditFailure(error: error));
  //     }
  //   } catch (e) {
  //     emit(EditFailure(error: e.toString()));
  //   }
  // }

  //Edit license
  // Edit license
  // Future<void> _onEditLicense(
  //   EditLicenseEvent editevent,
  //   Emitter<EditState> emit,
  // ) async {
  //   emit(EditLoading());

  //   try {
  //     final licenseresponse = await repository.editLicense(
  //       licenseNumber: editevent.licenseNumber,
  //       licenseType: editevent.licenseType.toString(),
  //       issueDate: editevent.issueDate,
  //       expiryDate: editevent.expiryDate,
  //       id: editevent.id,
  //       issuingAuthority: editevent.issuingAuthority,
  //     );

  //     if (licenseresponse["Status"] == 1) {
  //       String message = "License updated successfully";

  //       final data = licenseresponse["Data"];
  //       if (data is List && data.isNotEmpty) {
  //         final level1 = data[0];
  //         if (level1 is List && level1.isNotEmpty) {
  //           final msgObj = level1[0];
  //           if (msgObj is Map && msgObj["msg"] != null) {
  //             message = msgObj["msg"].toString();
  //           }
  //         }
  //       }

  //       emit(EditSuccess(message: message));
  //     } else {
  //       final error =
  //           licenseresponse["Error"]?.toString() ?? "Failed to update license";
  //       emit(EditFailure(error: error));
  //     }
  //   } catch (e) {
  //     emit(EditFailure(error: e.toString()));
  //   }
  // }

  // // Language
  // Future<void> _onEditLanguage(
  //   EditLanguageEvent editevent,
  //   Emitter<EditState> emit,
  // ) async {
  //   emit(EditLoading());

  //   try {
  //     final languageResponse = await repository.editLanguage(
  //       language: editevent.language,
  //       proficiency: editevent.proficiency,
  //       id: editevent.id,
  //     );

  //     if (languageResponse["Status"] == 1) {
  //       final message =
  //           languageResponse["Info"]?.toString() ??
  //           "Language updated successfully";

  //       emit(EditSuccess(message: message));
  //     } else {
  //       final error =
  //           languageResponse["Error"]?.toString() ??
  //           "Failed to update language";

  //       emit(EditFailure(error: error));
  //     }
  //   } catch (e) {
  //     emit(EditFailure(error: e.toString()));
  //   }
  // }

  // Bank Info
  Future<void> _onEditBankInfo(
    EditBankInfoEvent event,
    Emitter<EditState> emit,
  ) async {
    emit(EditLoading());

    try {
      final response = await repository.editBankInfo(
        accountType: event.accountType,
        routingNumber: event.routingNumber,
        accountNumber: event.accountNumber,
        holderName: event.holderName,
        id: event.id,
      );

      if (response["Status"] == 1) {
        String message = "Bank info updated successfully";

        final data = response["Data"];
        if (data is List && data.isNotEmpty) {
          final level1 = data[0];
          if (level1 is List && level1.isNotEmpty) {
            final msgObj = level1[0];
            if (msgObj is Map && msgObj["msg"] != null) {
              message = msgObj["msg"].toString();
            }
          }
        }
        emit(EditSuccess(message: message));
      } else {
        final error =
            response["Info"]?.toString() ?? "Failed to update bank information";

        emit(EditFailure(error: error));
      }
    } catch (e) {
      emit(EditFailure(error: e.toString()));
    }
  }
}
