import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ghorx_mobile_app_new/features/profile/insurances/insurance_repo.dart';
import 'package:ghorx_mobile_app_new/features/profile/insurances/model/insurance_model.dart';
part 'insurance_event.dart';
part 'insurance_state.dart';

class InsuranceBloc extends Bloc<InsuranceEvent, InsuranceState> {
  final InsuranceRepo repository;

  InsuranceBloc({required this.repository}) : super(InsuranceInitial()) {
    on<FetchInsurance>(_onFetchInsurance);
  }
  Future<void> _onFetchInsurance(
    FetchInsurance event,
    Emitter<InsuranceState> emit,
  ) async {
    emit(InsuranceLoading());

    try {
      final insurance = await repository.fetchInsuranceInfo();
      emit(Insurance(insuranceModel: insurance));
    } catch (e) {
      emit(InsuranceError(message: e.toString()));
    }
  }
}
