import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghorx_mobile_app_new/features/profile/editProfile/repository/list_repository.dart';
import 'package:ghorx_mobile_app_new/features/profile/editProfile/repository/model/country_response_model.dart';
import 'package:ghorx_mobile_app_new/features/profile/editProfile/repository/model/specialty_response_model.dart';

part 'list_event.dart';
part 'list_state.dart';

class ListBloc extends Bloc<ListEvent, ListState> {
  final ListRepository repository;

  ListBloc({required this.repository}) : super(ListInitial()) {
    on<FetchCountryList>(_onFetchCountry);
    on<FetchSpecialtyList>(_onFetchSpecialty);
  }

  //country list
  Future<void> _onFetchCountry(
  FetchCountryList event,
  Emitter<ListState> emit,
) async {
  emit(ListLoading());

  try {
    final countryResponse = await repository.fetchCountryList();
    emit(CountryState(countryResponse: countryResponse));
  } catch (e) {
    emit(ListFailure(error: e.toString()));
  }
}
  //specialty list
  Future<void> _onFetchSpecialty(
  FetchSpecialtyList event,
  Emitter<ListState> emit,
) async {
  emit(ListLoading());

  try {
    final countryResponse = await repository.fetchSpecialtyList();
    emit(SpecialtyListState(specialtyResponse: countryResponse));
  } catch (e) {
    emit(ListFailure(error: e.toString()));
  }
}

}
