import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ghorx_mobile_app_new/features/account/insurance/repo/insurance_repo.dart';
import 'package:ghorx_mobile_app_new/features/account/insurance/repo/model/insurance_model.dart';
part 'insurance_event.dart';
part 'insurance_state.dart';

class InsuranceBloc extends Bloc<InsuranceEvent, InsuranceState> {
  final InsuranceRepo repository;

  InsuranceBloc({required this.repository}) : super(InsuranceInitial()) {
    on<FetchInsurance>(_onFetchInsurance);
    on<EditInsuranceEvent>(_editInsurance);
  }
  Future<void> _onFetchInsurance(
    FetchInsurance event,
    Emitter<InsuranceState> emit,
  ) async {
    emit(InsuranceLoading());

    try {
      final insurance = await repository.fetchInsuranceInfo();
      emit(InsuranceGetState(insuranceModel: insurance));
    } catch (e) {
      emit(InsuranceError(message: e.toString()));
    }
  }

  //add insurance
  Future<void> addInsurance(
    AddInsurance event,
    Emitter<InsuranceState> emit,
  ) async {
    emit(InsuranceAddLoading());

    try {
      final response = await repository.addInsurance(
        providerID: event.providerID,
        providerName: event.providerName,
        issueDate: event.issueDate,
        expiryDate: event.expiryDate,
      );
      if (response["Status"] == 1) {
        String message = "Insurance added successfully";

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

        emit(InsuranceSuccess(message: message));
      } else {
        final error =
            response["Error"]?.toString() ?? "Failed to add insurance";
        emit(InsuranceError(message: error));
      }
    } catch (e) {
      emit(InsuranceSuccess(message: "An error occurred: ${e.toString()}"));
    }
  }

  //Insurance
  Future<void> _editInsurance(
    EditInsuranceEvent event,
    Emitter<InsuranceState> emit,
  ) async {
    emit(InsuranceEditLoading());

    try {
      final response = await repository.editInsurance(
        insuranceId: event.insuranceId,
        providerID: event.providerID,
        providerName: event.providerName,
        issueDate: event.issueDate,
        expiryDate: event.expiryDate,
      );
      if (response["Status"] == 1) {
        String message = "Insurance updated successfully";

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

        emit(InsuranceSuccess(message: message));
      } else {
        final error =
            response["Error"]?.toString() ?? "Failed to update license";
        emit(InsuranceError(message: error));
      }
    } catch (e) {
      emit(InsuranceError(message: e.toString()));
    }
  }
}
