import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/repository/bloc/case_details_event.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/repository/case_det_repository.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/repository/model/case_details_model.dart';

part 'case_details_state.dart';

class CaseDetailsBloc extends Bloc<CaseDetailsEvent, CaseDetailsState> {
  final CaseDetRepository repository;

  CaseDetailsBloc({required this.repository}) : super(CaseDetailsInitial()) {
    on<CaseDetailsEventRequested>((event, emit) async {
      // 👇 Show loading only when it's not a silent refresh
      if (!event.silent) {
        emit(CaseDetailsLoading());
      }

      try {
        final casedtlResponse = await repository.getcaseDetails(
          saltID: event.saltID,
        );

        if (casedtlResponse.status == 1) {
          emit(casedetailsSuccess(caseDetailsModel: casedtlResponse));
        } else {
          emit(
            casedetailsFailure(
              casedtlResponse.info.isNotEmpty
                  ? casedtlResponse.info
                  : "Invalid credentials...",
            ),
          );
        }
      } on Exception catch (e) {
        emit(casedetailsFailure(e.toString()));
      }
    });
  }
}
