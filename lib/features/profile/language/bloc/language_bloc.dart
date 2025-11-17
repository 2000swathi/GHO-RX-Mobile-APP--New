import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ghorx_mobile_app_new/features/profile/License/model/license_model.dart';
import 'package:ghorx_mobile_app_new/features/profile/language/language_repo.dart';
import 'package:ghorx_mobile_app_new/features/profile/language/model/language_model.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  final LanguageRepo repository;
  LanguageBloc({required this.repository}) : super(LanguageInitial()) {
    on<FetchLanguage>(_onFetchLanguage);
  }
  //language
  Future<void> _onFetchLanguage(
    FetchLanguage event,
    Emitter<LanguageState> emit,
  ) async {
    emit(LanguageLoading());

    try {
      final language = await repository.fetchLanguageInfo();
      emit(Language(languageModel: language));
    } catch (e) {
      emit(LangugageError(message: e.toString()));
    }
  }
}
