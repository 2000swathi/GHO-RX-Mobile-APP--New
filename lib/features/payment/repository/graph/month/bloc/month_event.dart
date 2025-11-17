part of 'month_bloc.dart';

sealed class MonthEvent extends Equatable {
  const MonthEvent();

  @override
  List<Object> get props => [];
}

class FetchMonthEvent extends MonthEvent {}
