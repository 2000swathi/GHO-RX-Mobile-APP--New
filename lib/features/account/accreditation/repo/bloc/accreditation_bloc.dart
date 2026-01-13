import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ghorx_mobile_app_new/features/account/accreditation/repo/acc_repo.dart';
import 'package:ghorx_mobile_app_new/features/account/accreditation/repo/model/accreditationsmodel.dart';

part 'accreditation_event.dart';
part 'accreditation_state.dart';

class AccreditationBloc extends Bloc<AccreditationEvent, AccreditationState> {
  final AccRepo repository;
  AccreditationBloc({required this.repository})
    : super(AccreditationInitial()) {
    on<FetchAccreditation>(_onFetchAccreditation);
    // on<AddAccrediation>(_addaccrediation);
    on<SaveAccreditationEvent>(_saveAccreditation);
  }
  //fetch accreditation
  Future<void> _onFetchAccreditation(
    FetchAccreditation event,
    Emitter<AccreditationState> emit,
  ) async {
    emit(AccrediationLoading());

    try {
      final accreditation = await repository.fetchAccreditationInfo();
      emit(AccreditationgetState(accreditationModel: accreditation));
    } catch (e) {
      emit(AccrediationError(message: e.toString()));
    }
  }

  //accreditation
  // Future<void> _addaccrediation(
  //   AddAccrediation event,
  //   Emitter<AccreditationState> emit,
  // ) async {
  //   emit(AccrediationAddLoading());

  //   try {
  //     final response = await repository.addaccrediation(
  //       accreditationtype: event.accreditationtype,
  //       accreditationbody: event.accreditationbody,
  //       accreditationnumber: event.accreditationnumber,
  //     );
  //     if (response["Status"] == 1) {
  //       String message = "License updated successfully";

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
  //       emit(AccSuccess(message: message));
  //     }
  //   } catch (e) {
  //     emit(AccrediationError(message: "An error occurred: ${e.toString()}"));
  //   }
  // }

  // Save Accreditation
  Future<void> _saveAccreditation(
    SaveAccreditationEvent event,
    Emitter<AccreditationState> emit,
  ) async {
    emit(AccrediationSaveLoading());

    try {
      final response = await repository.saveAccreditation(
        accreditationtype: event.accreditationtype,
        accreditationbody: event.accreditationbody,
      );

      if (response["Status"] == 1) {
        String message = "Saved Successfully";
        final data = response["Data"];
        if(data is List &&
          data.isNotEmpty &&
          data[0] is List &&
          data[0].isNotEmpty &&
          data[0][0]['msg'] != null) {
            message = data[0][0]['msg'].toString();
          }
        
        // if (data is List && data.isNotEmpty) {
        //   final level1 = data[0];
        //   if (level1 is List && level1.isNotEmpty) {
        //     final msgObj = level1[0];
        //     if (msgObj is Map && msgObj["msg"] != null) {
        //       message = msgObj["msg"].toString();
        //     }
        //   }
        // }
        emit(AccSuccess(message: message));
      } else {
        final error =
            response["Error"]?.toString() ?? "Failed to save accreditation";
        emit(AccrediationError(message: error));
      }
    } catch (e) {
      emit(AccrediationError(message: e.toString()));
    }
  }
}
