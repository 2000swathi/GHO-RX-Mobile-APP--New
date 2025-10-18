import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ghorx_mobile_app_new/features/profile/edit/repository/edit_repository.dart';

part 'edit_event.dart';
part 'edit_state.dart';

class EditBloc extends Bloc<EditEvent, EditState> {
  final EditprofileRepository repository;

  EditBloc({required this.repository}) : super(EditInitial()) {
    on<EditInfoEvent>(_onEditInfo);
    on<EditLicenseEvent>(_onEditLicense);
    on<EditLanguageEvent>(_onEditLanguage);
    on<EditBankInfoEvent>(_onEditBankInfo);
  }

  //profile Bloc
  Future<void> _onEditInfo(EditInfoEvent event, Emitter<EditState> emit) async {
    emit(EditLoading());
    try {
      final response = await repository.editPersonalInfo(event.data);

      final message = response['Info'] ?? "License updated successfully";
      emit(EditSuccess(message: message));
    } catch (e) {
      emit(EditFailure(error: e.toString()));
    }
  }

  //Edit license
  Future<void> _onEditLicense(
    EditLicenseEvent editevent,
    Emitter<EditState> emit,
  ) async {
    emit(EditLoading());
    try {
      final licenseresponse = await repository.editLicense(
        licenseNumber: editevent.licenseNumber,
        issuingAuthority: editevent.issuingAuthority,
        licenseType: editevent.licenseType,
        issueDate: editevent.issueDate,
        expiryDate: editevent.expiryDate,
        id: editevent.id,
      );

      final message = licenseresponse['Info'] ?? "License updated successfully";
      emit(EditSuccess(message: message));
    } catch (e) {
      emit(EditFailure(error: e.toString()));
    }
  }

  Future<void> _onEditLanguage(
    EditLanguageEvent editevent,
    Emitter<EditState> emit,
  ) async {
    emit(EditLoading());
    try {
      final languageRespone = await repository.editLanguage(
        language: editevent.language,
        proficiency: editevent.proficiency,
        id: editevent.id,
      );

      final message =
          languageRespone['Info'] ?? "Language updated successfully";
      emit(EditSuccess(message: message));
    } catch (e) {
      emit(EditFailure(error: e.toString()));
    }
  }

  //Bank Info
  Future<void> _onEditBankInfo(
    EditBankInfoEvent editBankevent,
    Emitter<EditState> emit,
  ) async {
    emit(EditLoading());
    try {
      final bankInforesponse = await repository.editBankInfo(
        accountType: editBankevent.accountType,
        routingNumber: editBankevent.routingNumber,
        accountNumber: editBankevent.accountNumber,
        holderName: editBankevent.holderName,
        id: editBankevent.id,
      );

      final message =
          bankInforesponse['Info'] ?? "License updated successfully";
      emit(EditSuccess(message: message));
    } catch (e) {
      emit(EditFailure(error: e.toString()));
    }
  }
}
