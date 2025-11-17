import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ghorx_mobile_app_new/features/profile/accreditation/acc_repo.dart';
import 'package:ghorx_mobile_app_new/features/profile/accreditation/model/accreditationsmodel.dart';

part 'accreditation_event.dart';
part 'accreditation_state.dart';

class AccreditationBloc extends Bloc<AccreditationEvent, AccreditationState> {
  final AccRepo repository;
  AccreditationBloc({required this.repository})
    : super(AccreditationInitial()) {
    on<FetchAccreditation>(_onFetchAccreditation);
  }
  //accreditation
  Future<void> _onFetchAccreditation(
    FetchAccreditation event,
    Emitter<AccreditationState> emit,
  ) async {
    emit(AccrediationLoading());

    try {
      final accreditation = await repository.fetchAccreditationInfo();
      emit(Accreditation(accreditationModel: accreditation));
    } catch (e) {
      emit(AccrediationError(message: e.toString()));
    }
  }
}
