import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:ghorx_mobile_app_new/features/account/professional%20references/repo/model/professionaleref_model.dart';
import 'package:ghorx_mobile_app_new/features/account/professional%20references/repo/professionalref_repo.dart';

part 'professionalref_event.dart';
part 'professionalref_state.dart';

class ProfessionalrefBloc
    extends Bloc<ProfessionalrefEvent, ProfessionalrefState> {
  final ProfessionalrefRepo repository;
  ProfessionalrefBloc({required this.repository})
    : super(ProfessionalrefInitial()) {
    on<FetchProfessionalref>(_onFetchProfessionalref);
    on<AddProRef>(_addProfessionalRef);
    on<EditProRef>(_editProref);
  }
  Future<void> _onFetchProfessionalref(
    FetchProfessionalref event,
    Emitter<ProfessionalrefState> emit,
  ) async {
    emit(ProfessionalrefLoading());

    try {
      final professionalref = await repository.fetchProfessionalinfo();
      emit(ProfessionalrefgetState(professionalerefModel: professionalref));
    } catch (e) {
      emit(ProfessionalrefError(message: e.toString()));
    }
  }

  //add
  Future<void> _addProfessionalRef(
    AddProRef event,
    Emitter<ProfessionalrefState> emit,
  ) async {
    emit(ProfessionalrefAddLoading());
    try {
      final response = await repository.addProRef(
        fullName: event.fullName,
        designation: event.designation,
        relationship: event.relationship,
        phone: event.phone,
      );
      if (response["Status"] == 1) {
        String message = "Reference updated successfully";

        final data = response["Data"];
        if (data is List && data.isNotEmpty) {
          final level1 = data[0];
          if (level1 is List && level1.isNotEmpty) {
            final msgObj = level1[0];
            if (msgObj is Map && msgObj["msg"] != null) {
              message = msgObj["msg"].toString();
            }
          }
        }
        // 🔥 RE-FETCH updated list after add
        final updatedList = await repository.fetchProfessionalinfo();

        emit(ProfessionalrefgetState(professionalerefModel: updatedList));
        emit(ProRefSuccess(message: message));
      }
    } catch (e) {
      emit(ProfessionalrefError(message: "An error occurred: ${e.toString()}"));
    }
  }

  //edit
  Future<void> _editProref(
    EditProRef event,
    Emitter<ProfessionalrefState> emit,
  ) async {
    emit(ProfessionalrefEditLoading());
    try {
      final response = await repository.editProRef(
        refId: event.refId,
        fullName: event.fullName,
        designation: event.designation,
        relationship: event.relationship,
        phone: event.phone,
      );
      if (response["Status"] == 1) {
        String message = "Updated Successfully";
        final data = response["Data"];
        if (data is List && data.isNotEmpty) {
          final level1 = data[0];
          if (level1 is List && level1.isNotEmpty) {
            final msgObj = level1[0];
            if (msgObj is Map && msgObj["msg"] != null) {
              message = msgObj["msg"].toString();
            }
          }
        }

        final updatedList = await repository.fetchProfessionalinfo();
        emit(ProfessionalrefgetState(professionalerefModel: updatedList));
        emit(ProRefSuccess(message: message));

        // emit(ProRefSuccess(message: message));
      } else {
        final error =
            response["Error"]?.toString() ??
            "Failed to update Prosfessional reference";
        emit(ProfessionalrefError(message: error));
      }
    } catch (e) {
      emit(ProfessionalrefError(message: e.toString()));
    }
  }
}
