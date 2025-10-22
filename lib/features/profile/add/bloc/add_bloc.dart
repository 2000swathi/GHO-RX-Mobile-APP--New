import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghorx_mobile_app_new/features/profile/add/repository/add_profile_repo.dart';
import 'add_event.dart';
import 'add_event.dart';
part 'add_state.dart';

class AddBloc extends Bloc<AddEvent, AddState> {
  final AddProfileRepository repository;

  AddBloc({required this.repository}) : super(AddInitial()) {
    on<AddLicense>(_onAddLicense);
    on<AddLanguage>(_onAddLanguage);
    on<AddBankInfo>(_onAddBankInfo);
  }
  // License
  Future<void> _onAddLicense(AddLicense event, Emitter<AddState> emit) async {
    final AddProfileRepository repository;
    
    AddBloc({required this.repository}) : super(AddInitial()){
      on<AddSpecialty>(_onFetchSpecialty);
      on<AddAccrediation>(addaccrediation);
      on<AddInsurance>(addInsurance);
    }
//specialty
   Future<void> _onFetchSpecialty(
    AddSpecialty  event,
    Emitter<AddState> emit,
  ) async {
    emit(AddLoading());

    try {
      final licenseResponse = await repository.addLicense(
        licenseNumber: event.licenseNumber,
        licenseType: event.licenseType,
        issueDate: event.issueDate,
        expiryDate: event.expiryDate,
      );

      emit(AddLicenseInfoState(response: licenseResponse));
    } catch (e) {
      emit(AddError(message: e.toString()));
    }
  }

  Future<void> _onAddLanguage(AddLanguage event, Emitter<AddState> emit) async {
    emit(AddLoading());
    try {
      final languageResponse = await repository.addLanguage(
        language: event.language,
        proficiency: event.proficiency,
      );
      emit(AddLanguageInfoState(response: languageResponse));
      final addspecialty = await repository.addSpecialty(
        specialty: event.specialty,
        certifiedBoard: event.certifiedBoard,
        specialtyType: event.specialtyType,
      );
      emit(AddSpecialtyInfoState());
    } catch (e) {
      emit(AddError(message: e.toString()));
    }
  }

  // Bank Info
  Future<void> _onAddBankInfo(AddBankInfo event, Emitter<AddState> emit) async {
    emit(AddLoading());
    try {
      final bankInfoResponse = await repository.addBankInfo(
        accountType: event.accountType,
        routingNumber: event.routingNumber,
        accountNumber: event.accountNumber,
        holderName: event.holderName,
      );
      emit(AddBankInfoState(response: bankInfoResponse));
    } catch (e) {
      emit(AddError(message: e.toString()));
    }
  }
}

//accreditation
  Future<void> addaccrediation(
    AddAccrediation event,
    Emitter<AddState> emit,
  ) async {
    emit(AddLoading());

    try {
      final addaccrediation = await repository.addaccrediation(
        accreditationtype: event.accreditationtype,
        accreditationbody: event.accreditationbody,
        accreditationnumber: event.accreditationnumber,
      );
      emit(AddAccrediationInfoState());
    } catch (e) {
      emit(AddError(message: e.toString()));
    }
  } 
  
  //insurance
  Future<void> addInsurance(
    AddInsurance event,
    Emitter<AddState> emit,
  ) async {
    print("add insurance");
    emit(AddLoading());

    try {
      final addInsurance = await repository.addInsurance(
        providerID: event.providerID,
        providerName: event.providerName,
        issueDate: event.issueDate,
        expiryDate: event.expiryDate,
      );
      emit(AddInsuranceInfoState());
    } catch (e) {
      emit(AddError(message: e.toString()));
}
  }
}