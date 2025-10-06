// personal_info_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ghorx_mobile_app_new/features/profile/repository/country_repository.dart';

part 'personal_info_event.dart';
part 'personal_info_state.dart';

class PersonalInfoBloc extends Bloc<PersonalInfoEvent, PersonalInfoState> {
  final CountryRepository repository;

  PersonalInfoBloc({required this.repository}) : super(PersonalInfoInitial()) {
    on<FetchCountries>(_onFetchCountries);
  }

  Future<void> _onFetchCountries(
      FetchCountries event, Emitter<PersonalInfoState> emit) async {
    emit(PersonalInfoLoading());
    try {
      final countries = await repository.getCountries();
      emit(PersonalInfoLoaded(countries: countries));
    } catch (e) {
      emit(PersonalInfoError(e.toString()));
    }
  }
}
