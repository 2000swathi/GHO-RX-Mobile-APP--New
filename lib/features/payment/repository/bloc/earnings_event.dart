part of 'earnings_bloc.dart';

sealed class EarningsEvent extends Equatable {
  const EarningsEvent();

  @override
  List<Object> get props => [];
}
class FetchEarningsInfo extends EarningsEvent {
  String dateValue;
  FetchEarningsInfo({required this.dateValue});
}