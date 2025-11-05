part of 'getfiles_bloc.dart';

sealed class GetfilesState extends Equatable {
  const GetfilesState();
  
  @override
  List<Object> get props => [];
}

final class GetfilesInitial extends GetfilesState {}
