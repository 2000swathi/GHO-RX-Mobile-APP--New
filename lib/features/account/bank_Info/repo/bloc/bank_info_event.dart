part of 'bank_info_bloc.dart';

sealed class BankInfoEvent extends Equatable {
  const BankInfoEvent();

  @override
  List<Object> get props => [];
}

class FetchBankInfo extends BankInfoEvent {}

class AddBankInfo extends BankInfoEvent {
  final String accountType;
  final String routingNumber;
  final String accountNumber;
  final String holderName;
  final String bankName;

  const AddBankInfo({
    required this.accountNumber,
    required this.accountType,
    required this.holderName,
    required this.routingNumber,
    required this.bankName,
  });
  @override
  List<Object> get props => [
    accountNumber,
    accountType,
    holderName,
    routingNumber,
    bankName,
  ];
}

//Edit Bank Event
class EditBankInfoEvent extends BankInfoEvent {
  final String accountType;
  final String routingNumber;
  final String id;
  final String accountNumber;
  final String holderName;
  final String bankName;

  const EditBankInfoEvent({
    required this.accountType,
    required this.id,
    required this.routingNumber,
    required this.accountNumber,
    required this.holderName,
    required this.bankName,
  });

  @override
  List<Object> get props => [
    accountType,
    id,
    routingNumber,
    accountNumber,
    holderName,
    bankName,
  ];
}
