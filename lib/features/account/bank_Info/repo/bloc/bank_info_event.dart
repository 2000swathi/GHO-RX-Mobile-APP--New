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

  AddBankInfo({
    required this.accountNumber,
    required this.accountType,
    required this.holderName,
    required this.routingNumber,
  });
}
//Edit Bank Event
class EditBankInfoEvent extends BankInfoEvent {
  final String accountType;
  final String routingNumber;
  final String id;
  final String accountNumber;
  final String holderName;

  const EditBankInfoEvent({
    required this.accountType,
    required this.id,
    required this.routingNumber,
    required this.accountNumber,
    required this.holderName,
  });

  @override
  List<Object> get props => [
    accountType,
    routingNumber,
    id,
    accountNumber,
    holderName,
  ];
}