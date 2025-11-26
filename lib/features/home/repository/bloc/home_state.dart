part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();
  
  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}



// Loading state
class HomePageLoading extends HomeState {}

//  home info
class HomePageInfoState extends HomeState {
  final Map<String, dynamic> response;

  const HomePageInfoState({required this.response});

  @override
  List<Object> get props => [response];
}

class HomePageError extends HomeState {
  final String message;

  const HomePageError({required this.message});

  @override
  List<Object> get props => [message];
}