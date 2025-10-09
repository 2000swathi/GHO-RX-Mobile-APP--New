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
  final HomePageModel homePageModel;

  const HomePageInfoState({required this.homePageModel});

  @override
  List<Object> get props => [homePageModel];
}

class HomePageError extends HomeState {
  final String message;

  const HomePageError({required this.message});

  @override
  List<Object> get props => [message];
}