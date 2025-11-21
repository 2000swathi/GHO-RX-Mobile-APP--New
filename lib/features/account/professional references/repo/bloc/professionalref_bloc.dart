import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ghorx_mobile_app_new/features/account/professional%20references/repo/model/professionaleref_model.dart';
import 'package:ghorx_mobile_app_new/features/account/professional%20references/repo/professionalref_repo.dart';

part 'professionalref_event.dart';
part 'professionalref_state.dart';

class ProfessionalrefBloc
    extends Bloc<ProfessionalrefEvent, ProfessionalrefState> {
  final ProfessionalrefRepo repository;
  ProfessionalrefBloc({required this.repository})
    : super(ProfessionalrefInitial()) {
    on<ProfessionalrefEvent>((event, emit) {});
  }(FetchProfessionalref event,Emitter<ProfessionalrefState>emit,)async{emit(ProfessionalrefLoading());}
}
