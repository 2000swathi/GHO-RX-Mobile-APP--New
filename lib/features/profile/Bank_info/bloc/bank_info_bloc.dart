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
      final bankList = await repository.fetchBankInfo();
      emit(BankInfo(bankListModel: bankList));
    } catch (e) {
      emit(BankInfoError(message: e.toString()));
    }
  }
}
