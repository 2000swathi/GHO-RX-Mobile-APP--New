import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghorx_mobile_app_new/features/profile/add/repository/add_profile_repo.dart';
import 'add_event.dart';
part 'add_state.dart';

class AddBloc extends Bloc<AddEvent, AddState> {
  final AddProfileRepository repository;

  AddBloc({required this.repository}) : super(AddInitial()) {
    on<AddLicense>(_onAddLicense);
  }

  Future<void> _onAddLicense(AddLicense event, Emitter<AddState> emit) async {
    emit(AddLoading());

    try {
      final licenseResponse = await repository.addLicense(
        licenseNumber: event.licenseNumber,
        issuingAuthority: event.issuingAuthority,
        licenseType: event.licenseType,
        issueDate: event.issueDate,
        expiryDate: event.expiryDate,
      );

      emit(AddLicenseInfoState(response: licenseResponse));
    } catch (e) {
      emit(AddError(message: e.toString()));
    }
  }
}
