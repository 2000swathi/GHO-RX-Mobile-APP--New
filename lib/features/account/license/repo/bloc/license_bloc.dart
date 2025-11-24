import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ghorx_mobile_app_new/features/account/license/repo/license_repo.dart';
import 'package:ghorx_mobile_app_new/features/account/license/repo/model/license_model.dart';
part 'license_event.dart';
part 'license_state.dart';

class LicenseBloc extends Bloc<LicenseEvent, LicenseState> {
  final LicenseRepo repository;

  LicenseBloc({required this.repository}) : super(LicenseInitial()) {
    on<FetchLicense>(_onFetchLicense);
    on<EditLicenseEvent>(_onEditLicense);
    on<AddLicenseEvent>(_onAddLicense);
  }
  //license
  Future<void> _onFetchLicense(
    FetchLicense event,
    Emitter<LicenseState> emit,
  ) async {
    emit(LicenseLoading());

    try {
      final license = await repository.fetchLicenseInfo();
      emit(Licensegetsuccess(licenseModel: license));
    } catch (e) {
      emit(LicenseError(message: e.toString()));
    }
  }

  Future<void> _onAddLicense(
    AddLicenseEvent event,
    Emitter<LicenseState> emit,
  ) async {
    try {
      final licenseResponse = await repository.addLicense(
        licenseNumber: event.licenseNumber,
        licenseType: event.licenseType.toString(),
        issueDate: event.issueDate,
        expiryDate: event.expiryDate,
        issuingAuthority: event.issuingAuthority,
      );
      if (licenseResponse['Status'] == 1) {
        emit(LicSuccess(message: licenseResponse["Data"][0][0]["msg"]));
      } else {
        emit(
          LicenseError(
            message: licenseResponse['Error'] ?? "Failed to add license",
          ),
        );
      }
    } catch (e) {
      emit(LicenseError(message: e.toString()));
    }
  }

  Future<void> _onEditLicense(
    EditLicenseEvent editevent,
    Emitter<LicenseState> emit,
  ) async {
    emit(LicenseeditLoading());

    try {
      final response = await repository.editLicense(
        licenseNumber: editevent.licenseNumber,
        licenseType: editevent.licenseType.toString(),
        issueDate: editevent.issueDate,
        expiryDate: editevent.expiryDate,
        id: editevent.id,
        issuingAuthority: editevent.issuingAuthority,
      );

      if (response["Status"] == 1) {
        String message = "License updated successfully";

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

        emit(LicSuccess(message: message));
      } else {
        final error =
            response["Error"]?.toString() ?? "Failed to update license";
        emit(LicenseError(message: error));
      }
    } catch (e) {
      emit(LicenseError(message: e.toString()));
    }
  }
}
