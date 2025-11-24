part of 'language_bloc.dart';

sealed class LanguageState extends Equatable {
  const LanguageState();

  @override
  List<Object> get props => [];
}

final class LanguageInitial extends LanguageState {}

class LanguageLoading extends LanguageState {}
class LanguageaddLoading extends LanguageState {}

//     language list
class Language extends LanguageState {
  final LanguageModel languageModel;

  const Language({required this.languageModel});

  @override
  List<Object> get props => [languageModel];
}


//  success
class LangSuccess extends LanguageState {
  final String message;

  const LangSuccess({required this.message});

  @override
  List<Object> get props => [message];
}
//error
class LangError extends LanguageState {
  final String message;

  const LangError({required this.message});

  @override
  List<Object> get props => [message];
}
