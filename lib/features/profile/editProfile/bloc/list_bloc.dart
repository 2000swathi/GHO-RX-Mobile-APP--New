import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghorx_mobile_app_new/features/profile/editProfile/repository/list_repository.dart';
import 'package:ghorx_mobile_app_new/features/profile/editProfile/repository/model/accreditationtype_response_model.dart';
import 'package:ghorx_mobile_app_new/features/profile/editProfile/repository/model/certified_response_model.dart';
import 'package:ghorx_mobile_app_new/features/profile/editProfile/repository/model/country_response_model.dart';
import 'package:ghorx_mobile_app_new/features/profile/editProfile/repository/model/issueing_authority.dart';
import 'package:ghorx_mobile_app_new/features/profile/editProfile/repository/model/issuing_response_model.dart';
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
    on<FetchAccrediationList>(_onFetchAccreditation);
    on<FetchCertifiedList>(_onFetchCertified);
    on<FetchSpecialtyTypeList>(_onFetchSpecialtyType);
    on<FetchIssueingAuthorityList>(_onFetchIssueingAuthority);
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

  //accrediation list
  Future<void> _onFetchAccreditation(
    FetchAccrediationList event,
    Emitter<ListState> emit,
  ) async {
    emit(ListLoading());

    try {
      final accreditationTypeResponse =
          await repository.fetchAccreditationTypeList();
      emit(
        AccreditationTypeListState(
          accreditationTypeResponse: accreditationTypeResponse,
        ),
      );
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

  // athority
  Future<void> _onFetchAuthorityType(
    FetchAuthorityList event,
    Emitter<ListState> emit,
  ) async {
    emit(ListLoading());

    try {
      final response = await repository.fetchAuthorityList();
      emit(AuthorityListState(response: response));
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
      emit(
        SpecialtyTypeListState(specialtyTypeResponse: specialtyTypeResponse),
      );
    } catch (e) {
      emit(ListFailure(error: e.toString()));
    }
  }

  //Issueing Authority
  Future<void> _onFetchIssueingAuthority(
    FetchIssueingAuthorityList event,
    Emitter<ListState> emit,
  ) async {
    emit(ListLoading());

    try {
      final issueingauthorityResponse =
          await repository.fetchIssueingAuthorityList();
      emit(
        IssueingauthorityListState(
          issueingauthorityResponse: issueingauthorityResponse,
        ),
      );
    } catch (e) {
      emit(ListFailure(error: e.toString()));
    }
  }
}
