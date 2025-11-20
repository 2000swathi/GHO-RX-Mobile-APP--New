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
    on<AddAccrediation>(_addaccrediation);
    on<EditAcreditationEvent>(_editAccreditation);
  }
  //accreditation
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
  Future<void> _addaccrediation(
    AddAccrediation event,
    Emitter<AccreditationState> emit,
  ) async {
    emit(AccrediationAddLoading());

    try {
      final response = await repository.addaccrediation(
        accreditationtype: event.accreditationtype,
        accreditationbody: event.accreditationbody,
        accreditationnumber: event.accreditationnumber,
      );
      if (response["Status"] == 1) {
        String message = "License updated successfully";

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
        emit(AccSuccess(message: message));
      }
    } catch (e) {
      emit(AccrediationError(message: "An error occurred: ${e.toString()}"));
    }
  }

  //edit
  // Accreditation
  Future<void> _editAccreditation(
    EditAcreditationEvent event,
    Emitter<AccreditationState> emit,
  ) async {
    emit(AccrediationeditLoading());

    try {
      final response = await repository.editAccreditation(
        accreditationId: event.accreditationId,
        accreditationtype: event.accreditationtype,
        accreditationbody: event.accreditationbody,
        accreditationnumber: event.accreditationnumber,
      );

      if (response["Status"] == 1) {
        String message = "Updated Successfully";
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
        emit(AccSuccess(message: message));
      } else {
        final error =
            response["Error"]?.toString() ?? "Failed to update accreditation";
        emit(AccrediationError(message: error));
      }
    } catch (e) {
      emit(AccrediationError(message: e.toString()));
    }
  }
}
