part of 'language_bloc.dart';

sealed class LanguageEvent extends Equatable {
  const LanguageEvent();

  @override
  List<Object> get props => [];
}

//get
class FetchLanguage extends LanguageEvent {}

//add
class AddLanguage extends LanguageEvent {
  final String language;
  
  const AddLanguage({required this.language,});
  @override
  List<Object> get props => [language];
}
//edit
class EditLanguageEvent extends LanguageEvent {
  final String language;
  final String id;

  const EditLanguageEvent({
    required this.language,
    required this.id,
  });

  @override
  List<Object> get props => [language, id];
}
