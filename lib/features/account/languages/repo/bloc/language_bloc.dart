import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghorx_mobile_app_new/features/account/languages/repo/language_repo.dart';
import 'package:ghorx_mobile_app_new/features/account/languages/repo/model/language_model.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  final LanguageRepo repository;
  LanguageBloc({required this.repository}) : super(LanguageInitial()) {
    on<FetchLanguage>(_onFetchLanguage);
    on<AddLanguage>(_onAddLanguage);
    on<EditLanguageEvent>(_onEditLanguage);
  }

  //language get
  Future<void> _onFetchLanguage(
    FetchLanguage event,
    Emitter<LanguageState> emit,
  ) async {
    emit(LanguageLoading());

    try {
      final language = await repository.fetchLanguageInfo();
      emit(Language(languageModel: language));
    } catch (e) {
      emit(LangError(message: e.toString()));
    }
  }
  // add Language

  Future<void> _onAddLanguage(
    AddLanguage event,
    Emitter<LanguageState> emit,
  ) async {
    emit(LanguageaddLoading());
    try {
      final languageResponse = await repository.addLanguage(
        language: event.language,
      );
      emit(LangSuccess(message: languageResponse["Data"][0][0]["msg"]));
    } catch (e) {
      emit(LangError(message: e.toString()));
    }
  }

  //edit
  // Language
  Future<void> _onEditLanguage(
    EditLanguageEvent editevent,
    Emitter<LanguageState> emit,
  ) async {
    emit(LanguageLoading());

    try {
      final languageResponse = await repository.editLanguage(
        language: editevent.language,

        id: editevent.id,
      );

      if (languageResponse["Status"] == 1) {
        final message =
            languageResponse["Info"]?.toString() ??
            "Language updated successfully";

        emit(LangSuccess(message: message));
      } else {
        final error =
            languageResponse["Error"]?.toString() ??
            "Failed to update language";

        emit(LangError(message: error));
      }
    } catch (e) {
      emit(LangError(message: e.toString()));
    }
  }
}
