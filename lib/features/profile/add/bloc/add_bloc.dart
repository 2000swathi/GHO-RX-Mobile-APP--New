import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghorx_mobile_app_new/features/profile/add/repository/add_profile_repo.dart';
import 'add_event.dart';
part 'add_state.dart';

class AddBloc extends Bloc<AddEvent, AddState> {
  final AddProfileRepository repository;

  AddBloc({required this.repository}) : super(AddInitial()) {
    // on<AddLicense>(_onAddLicense);
    // on<AddLanguage>(_onAddLanguage);
    on<AddBankInfo>(_onAddBankInfo);
    on<AddSpecialty>(_onAddSpecialty);
    on<AddAccrediation>(addaccrediation);
    on<AddInsurance>(addInsurance);
  }
  // License
  // Future<void> _onAddLicense(AddLicense event, Emitter<AddState> emit) async {
  
  //   try {
  //     final licenseResponse = await repository.addLicense(
  //       licenseNumber: event.licenseNumber,
  //       licenseType: event.licenseType.toString(),
  //       issueDate: event.issueDate,
  //       expiryDate: event.expiryDate,
  //       issuingAuthority: event.issuingAuthority,
  //     );
  //     if (licenseResponse['Status'] == 1) {
  //       emit(AddSuccess(response: licenseResponse));
  //     } else {
  //       emit(AddError(
  //           message: licenseResponse['Error'] ?? "Failed to add license"));
  //     }
  //   } catch (e) {
  //     emit(AddError(message: e.toString()));
  //   }
  // }

  //specialty
  Future<void> _onAddSpecialty(
    AddSpecialty event,
    Emitter<AddState> emit,
  ) async {
    emit(AddLoading());

    try {
      final response = await repository.addSpecialty(
        specialty: event.specialty,
        certifiedBoard: event.certifiedBoard,
        specialtyType: event.specialtyType,
      );
      emit(AddSuccess(response: response));
    } catch (e) {
      emit(AddError(message: "An error occurred: ${e.toString()}"));
    }
  }

// // Language

//   Future<void> _onAddLanguage(AddLanguage event, Emitter<AddState> emit) async {
//     emit(AddLoading());
//     try {
//       final languageResponse = await repository.addLanguage(
//         language: event.language,
//         proficiency: event.proficiency,
//       );
//       emit(AddSuccess(response: languageResponse));
//     } catch (e) {
//       emit(AddError(message: e.toString()));
//     }
//   }

  // Bank Info
  Future<void> _onAddBankInfo(AddBankInfo event, Emitter<AddState> emit) async {
    emit(AddLoading());
    try {
      final bankInfoResponse = await repository.addBankInfo(
        accountType: event.accountType,
        routingNumber: event.routingNumber,
        accountNumber: event.accountNumber,
        holderName: event.holderName,
      );
      emit(AddSuccess(response: bankInfoResponse));
    } catch (e) {
      emit(AddError(message: e.toString()));
    }
  }

  //accreditation
  Future<void> addaccrediation(
    AddAccrediation event,
    Emitter<AddState> emit,
  ) async {
    emit(AddLoading());

    try {
      final response = await repository.addaccrediation(
        accreditationtype: event.accreditationtype,
        accreditationbody: event.accreditationbody,
        accreditationnumber: event.accreditationnumber,
      );
      emit(AddSuccess(response: response));
    } catch (e) {
      emit(AddError(message: "An error occurred: ${e.toString()}"));
    }
  }

  //insurance
  Future<void> addInsurance(AddInsurance event, Emitter<AddState> emit) async {
    print("add insurance");
    emit(AddLoading());

    try {
      final result = await repository.addInsurance(
        providerID: event.providerID,
        providerName: event.providerName,
        issueDate: event.issueDate,
        expiryDate: event.expiryDate,
      );
      if (result['Status'] == 1) {
        emit(AddSuccess(response: result));
      } else {
        emit(AddError(message: result['message'] ?? "Failed to add"));
      }
    } catch (e) {
      emit(AddError(message: "An error occurred: ${e.toString()}"));
    }
  }
}
