import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghorx_mobile_app_new/features/profile/add/repository/add_profile_repo.dart';
import 'add_event.dart';
part 'add_state.dart';

class AddBloc extends Bloc<AddEvent, AddState> {
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