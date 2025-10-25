import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghorx_mobile_app_new/features/profile/editProfile/repository/list_repository.dart';
import 'package:ghorx_mobile_app_new/features/profile/editProfile/repository/model/certified_response_model.dart';
import 'package:ghorx_mobile_app_new/features/profile/editProfile/repository/model/country_response_model.dart';
import 'package:ghorx_mobile_app_new/features/profile/editProfile/repository/model/license_response_model.dart';
import 'package:ghorx_mobile_app_new/features/profile/editProfile/repository/model/specialty%20type_response_model.dart';
import 'package:ghorx_mobile_app_new/features/profile/editProfile/repository/model/specialty_response_model.dart';

part 'list_event.dart';
part 'list_state.dart';

class ListBloc extends Bloc<ListEvent, ListState> {
  final ListRepository repository;

  ListBloc({required this.repository}) : super(ListInitial()) {
    on<FetchCountryList>(_onFetchCountry);
    on<FetchSpecialtyList>(_onFetchSpecialty);
    on<FetchLicenseList>(_onFetchLicense);
    on<FetchCertifiedList>(_onFetchCertified);
    on<FetchSpecialtyTypeList>(_onFetchSpecialtyType);
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
      final specialtyListResponse = await repository.fetchSpecialtyList();
      emit(SpecialtyListState(specialtyResponse: specialtyListResponse));
    } catch (e) {
      emit(ListFailure(error: e.toString()));
    }
  }

  //license list
  Future<void> _onFetchLicense(
    FetchLicenseList event,
    Emitter<ListState> emit,
  ) async {
    emit(ListLoading());

    try {
      final licenseListResponse = await repository.fetchLicenseList();
      emit(LicenseListState(licenseResponse: licenseListResponse));
    } catch (e) {
      emit(ListFailure(error: e.toString()));
    }
  }

  //Certified
   Future<void> _onFetchCertified(
    FetchCertifiedList event,
    Emitter<ListState> emit,
  ) async {
    emit(ListLoading());

    try {
      final certifiedListResponse = await repository.fetchCertifiedList();
      print(certifiedListResponse);
      emit(CertifiedListState(certifiedResponse: certifiedListResponse));
    } catch (e) {
      emit(ListFailure(error: e.toString()));
    }
  }

  //Specialty type
  Future<void> _onFetchSpecialtyType(
    FetchSpecialtyTypeList event,
    Emitter<ListState> emit,
  ) async {
    emit(ListLoading());

    try { 
      final specialtyTypeResponse = await repository.fetchSpecialtyTypeList();
      print(Response);
      emit(SpecialtyTypeListState(specialtyTypeResponse: specialtyTypeResponse)); 
    } catch (e) {
      emit(ListFailure(error: e.toString()));
    }
  }
}
