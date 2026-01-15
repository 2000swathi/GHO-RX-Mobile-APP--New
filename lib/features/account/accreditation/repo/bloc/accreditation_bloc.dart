import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ghorx_mobile_app_new/features/account/accreditation/repo/acc_repo.dart';
import 'package:ghorx_mobile_app_new/features/account/accreditation/repo/model/accreditationsmodel.dart';

part 'accreditation_event.dart';
part 'accreditation_state.dart';

class AccreditationBloc extends Bloc<AccreditationEvent, AccreditationState> {
  final AccRepo repository;
  AccreditationBloc({required this.repository})
    : super(AccreditationInitial()) {
    on<FetchAccreditation>(_onFetchAccreditation);
    on<AddAccreditationEvent>(_addAccreditation);
  }
  //fetch accreditation
  Future<void> _onFetchAccreditation(
    FetchAccreditation event,
    Emitter<AccreditationState> emit,
  ) async {
    emit(AccrediationLoading());

    try {
      final accreditation = await repository.fetchAccreditationInfo();
      if (accreditation.status == 1) {
        emit(AccreditationgetState(accreditationModel: accreditation));
      } else {
     
        final errorMsg =
            accreditation.info.isNotEmpty
                ? accreditation.info
                : 'Failed to fetch accreditations';
        emit(AccrediationError(message: errorMsg));
      }
    } catch (e) {
      emit(AccrediationError(message: e.toString()));
    }
  }
  // Save Accreditation
  Future<void> _addAccreditation(
    AddAccreditationEvent event,
    Emitter<AccreditationState> emit,
  ) async {
    emit(AccrediationSaveLoading());

    try {
      final response = await repository.addAccreditation(
        accreditationName: event.accreditationName,
      );

      if (response["Status"] == 1) {
        String message = "Saved Successfully";
        final data = response["Data"];
        if (data is List &&
            data.isNotEmpty &&
            data[0] is List &&
            data[0].isNotEmpty &&
            data[0][0]['msg'] != null) {
          message = data[0][0]['msg'].toString();
        }
        emit(AccSuccess(message: message));
      } else {
        final error =
            response["Error"]?.toString() ?? "Failed to save accreditation";
        emit(AccrediationError(message: error));
      }
    } catch (e) {
      emit(AccrediationError(message: e.toString()));
    }
  }
}
