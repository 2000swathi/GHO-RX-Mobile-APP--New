part of 'language_bloc.dart';

sealed class LanguageState extends Equatable {
  const LanguageState();

  @override
  List<Object> get props => [];
}

final class LanguageInitial extends LanguageState {}

class LanguageLoading extends LanguageState {}

//     language list
class Language extends LanguageState {
  final LanguageModel languageModel;

  const Language({required this.languageModel});

  @override
  List<Object> get props => [LicenseModel];
}

class LangugageError extends LanguageState {
  final String message;

  const LangugageError({required this.message});

  @override
  List<Object> get props => [message];
}
