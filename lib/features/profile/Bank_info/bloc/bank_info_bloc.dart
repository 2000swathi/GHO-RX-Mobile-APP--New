import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ghorx_mobile_app_new/features/profile/Bank_info/bankinforepo.dart';
import 'package:ghorx_mobile_app_new/features/profile/Bank_info/model/bankinfo_model.dart';

part 'bank_info_event.dart';
part 'bank_info_state.dart';

class BankInfoBloc extends Bloc<BankInfoEvent, BankInfoState> {
  final Bankinforepo repository;

  BankInfoBloc({required this.repository}) : super(BankInfoInitial()) {
    on<FetchBankInfo>(_onFetchBankInfo);
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
        emit(BankInfo(bankListModel: response));
      } else {
        emit(BankInfoError(message: response.info.toString()));
      }
    } catch (e) {
      emit(BankInfoError(message: e.toString()));
    }
  }
}
