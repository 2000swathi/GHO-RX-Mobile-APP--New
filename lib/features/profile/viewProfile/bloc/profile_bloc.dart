import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghorx_mobile_app_new/features/profile/viewProfile/repository/profile_repo.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository repository;

  ProfileBloc({required this.repository}) : super(ProfileInitial()) {
    on<FetchPersonalInfo>(_onFetchProfile);
    on<FetchSpecialty>(_onFetchSpecialty);
    on<FetchInsurance>(_onFetchInsurance);
    on<FetchLicence>(_onFetchLicense);
  }
  //personal info

  Future<void> _onFetchProfile(
    FetchPersonalInfo event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());

    try {
      final profile = await repository.fetchPersonalInfo();
      emit(PersonalInfoState(personalInfomodel: profile));
    } catch (e) {
      emit(ProfileError(message: e.toString()));
    }
  }

  //specialty

  Future<void> _onFetchSpecialty(
    FetchSpecialty event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());

    try {
      final specialties = await repository.fetchSpecialtyInfo();
      emit(SpecialtyState(specialtyModel: specialties));
    } catch (e) {
      emit(ProfileError(message: e.toString()));
    }
  }

  //insurance
  Future<void> _onFetchInsurance(
    FetchInsurance event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());

    try {
      final insurance = await repository.fetchInsuranceInfo();
      emit(InsuranceState(insuranceModel: insurance));
    } catch (e) {
      emit(ProfileError(message: e.toString()));
    }
  }
  
  //license
  Future<void> _onFetchLicense(
    FetchLicence event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());

    try {
      final insurance = await repository.fetchLicenseInfo();
      emit(LicenseState(licenseModel: insurance));
    } catch (e) {
      emit(ProfileError(message: e.toString()));
    }
  }
}
