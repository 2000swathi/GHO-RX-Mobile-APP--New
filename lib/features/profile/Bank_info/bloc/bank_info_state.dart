part of 'bank_info_bloc.dart';

sealed class BankInfoState extends Equatable {
  const BankInfoState();

  @override
  List<Object> get props => [];
}

final class BankInfoInitial extends BankInfoState {}

// Loading state
class BankInfoLoading extends BankInfoState {}

// bankinfo list
class BankInfo extends BankInfoState {
  final BankInfoResponseModel bankListModel;

  const BankInfo({required this.bankListModel});

  @override
  List<Object> get props => [bankListModel];
}

// Error state
class BankInfoError extends BankInfoState {
  final String message;

  const BankInfoError({required this.message});

  @override
  List<Object> get props => [message];
}
