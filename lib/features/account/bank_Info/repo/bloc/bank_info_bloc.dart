import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ghorx_mobile_app_new/features/account/bank_Info/repo/bankinforepo.dart';
import 'package:ghorx_mobile_app_new/features/account/bank_Info/repo/model/bankinfo_model.dart';
import 'package:ghorx_mobile_app_new/features/account/insurance/repo/bloc/insurance_bloc.dart';

part 'bank_info_event.dart';
part 'bank_info_state.dart';

class BankInfoBloc extends Bloc<BankInfoEvent, BankInfoState> {
  final Bankinforepo repository;

  BankInfoBloc({required this.repository}) : super(BankInfoInitial()) {
    on<FetchBankInfo>(_onFetchBankInfo);
    on<AddBankInfo>(_onAddBankInfo);
    on<EditBankInfoEvent>(_onEditBankInfo);
  }

  //bankinfo
  Future<void> _onFetchBankInfo(
    FetchBankInfo event,
    Emitter<BankInfoState> emit,
  ) async {
    emit(BankInfoLoading());
    try {
      final response = await repository.fetchBankInfo();
      if (response.status == 1) {
        emit(BankInfoGetState(bankListModel: response));
      } else {
        emit(BankInfoError(message: response.info.toString()));
      }
    } catch (e) {
      emit(BankInfoError(message: e.toString()));
    }
  }

  Future<void> _onAddBankInfo(
    AddBankInfo event,
    Emitter<BankInfoState> emit,
  ) async {
    emit(BankInfoLoading());
    try {
      final response = await repository.addBankInfo(
        accountType: event.accountType,
        routingNumber: event.routingNumber,
        accountNumber: event.accountNumber,
        holderName: event.holderName,
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

        emit(BankInfoSuccess(message: message));
      } else {
        final error =
            response["Error"]?.toString() ?? "Failed to add insurance";
        emit(BankInfoError(message: error));
      }
    } catch (e) {
      emit(BankInfoError(message: e.toString()));
    }
  }

  // Bank Info
  Future<void> _onEditBankInfo(
    EditBankInfoEvent event,
    Emitter<BankInfoState> emit,
  ) async {
    emit(BankInfoEditLoading());

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
        emit(BankInfoSuccess(message: message));
      } else {
        final error =
            response["Info"]?.toString() ?? "Failed to update bank information";

        emit(BankInfoError(message: error));
      }
    } catch (e) {
      emit(BankInfoError(message: e.toString()));
    }
  }
}
