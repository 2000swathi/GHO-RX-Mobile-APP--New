import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghorx_mobile_app_new/features/remote_config/Bloc/update_event.dart';
import 'package:ghorx_mobile_app_new/features/remote_config/remote_config_service.dart';
import 'package:in_app_update/in_app_update.dart';
import 'update_state.dart';

class UpdateBloc extends Bloc<UpdateEvent, UpdateState> {
  final RemoteConfigService service;

  UpdateBloc(this.service) : super(UpdateInitial()) {
    on<CheckForUpdateEvent>(_checkUpdate);
  }

  Future<void> _checkUpdate(
      CheckForUpdateEvent event, Emitter<UpdateState> emit) async {
    emit(UpdateChecking());

    try {
      await service.init();

      final currentVersion = await service.getCurrentFullVersion();
      final latestVersion = service.getLatestVersion();
      final forceUpdate = service.getForceUpdate();

      final isUpdateAvailable =
          service.isUpdateAvailable(currentVersion, latestVersion);

      if (!isUpdateAvailable) {
        emit(UpdateNotAvailable());
        return;
      }

      /// ANDROID In-App Update
      if (Platform.isAndroid) {
        try {
          final updateInfo = await InAppUpdate.checkForUpdate();

          if (updateInfo.updateAvailability ==
              UpdateAvailability.updateAvailable) {
            await InAppUpdate.performImmediateUpdate();
            emit(UpdateNotAvailable());
            return;
          }
        } catch (_) {}
      }

      emit(UpdateAvailable(forceUpdate: forceUpdate));
    } catch (e) {
      emit(UpdateError(e.toString()));
    }
  }
}