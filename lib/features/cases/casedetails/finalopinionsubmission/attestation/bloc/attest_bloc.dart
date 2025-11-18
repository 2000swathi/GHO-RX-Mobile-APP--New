import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/finalopinionsubmission/attestation/attestation_repo.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/finalopinionsubmission/attestation/bloc/attest_event.dart';
part 'attest_state.dart';

class AttestBloc extends Bloc<AttestEvent, AttestState> {
  AttestationRepo repository;
  AttestBloc({required this.repository}) : super(AttestInitial()) {
    on<AttestListEvent>((event, emit) async {
      if (!event.silent) {
        emit(AttestLoading());
      }
      try {
        final response = await repository.getAttestation(event.saltID);
        if (response["Status"] == 1) {
          emit(AttestSuccessState(response));
        } else {
          emit(AttestFailedState(response["Info"]));
        }
      } on Exception catch (e) {
        emit(AttestFailedState(e.toString()));
      }
    });
  }
}
