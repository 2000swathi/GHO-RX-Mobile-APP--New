import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ghorx_mobile_app_new/features/profile/License/license_repo.dart';
import 'package:ghorx_mobile_app_new/features/profile/License/model/license_model.dart';
part 'license_event.dart';
part 'license_state.dart';

class LicenseBloc extends Bloc<LicenseEvent, LicenseState> {
  final LicenseRepo repository;

  LicenseBloc({required this.repository}) : super(LicenseInitial()) {
    on<FetchLicense>(_onFetchLicense);
  }
  //license
  Future<void> _onFetchLicense(
    FetchLicense event,
    Emitter<LicenseState> emit,
  ) async {
    emit(LicenseLoading());

    try {
      final license = await repository.fetchLicenseInfo();
      emit(License(licenseModel: license));
    } catch (e) {
      emit(LicenseError(message: e.toString()));
    }
  }
}
