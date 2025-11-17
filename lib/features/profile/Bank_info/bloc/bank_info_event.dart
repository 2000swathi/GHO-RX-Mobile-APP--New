part of 'bank_info_bloc.dart';

sealed class BankInfoEvent extends Equatable {
  const BankInfoEvent();

  @override
  List<Object> get props => [];
}

class FetchBankInfo extends BankInfoEvent {}
