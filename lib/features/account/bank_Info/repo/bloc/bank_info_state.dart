part of 'bank_info_bloc.dart';

sealed class BankInfoState extends Equatable {
  const BankInfoState();

  @override
  List<Object> get props => [];
}

final class BankInfoInitial extends BankInfoState {}

// Loading state
class BankInfoLoading extends BankInfoState {}
class BankInfoAddLoading extends BankInfoState {}
class BankInfoEditLoading extends BankInfoState {}

// bankinfo list
class BankInfoGetState extends BankInfoState {
  final BankInfoResponseModel bankListModel;

  const BankInfoGetState({required this.bankListModel});

  @override
  List<Object> get props => [bankListModel];
}
class BankInfoSuccess extends BankInfoState {
  final String message;

  const BankInfoSuccess({required this.message});

  @override
  List<Object> get props => [message];
}
// Error state
class BankInfoError extends BankInfoState {
  final String message;

  const BankInfoError({required this.message});

  @override
  List<Object> get props => [message];
}
