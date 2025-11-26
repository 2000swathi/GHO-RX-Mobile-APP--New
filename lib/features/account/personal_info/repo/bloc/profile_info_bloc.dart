import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ghorx_mobile_app_new/features/account/personal_info/repo/profile_info_repo.dart';
import 'package:ghorx_mobile_app_new/features/account/personal_info/repo/model/personalinfo_model.dart';

part 'profile_info_event.dart';
part 'profile_info_state.dart';

class ProfileInfoBloc extends Bloc<ProfileInfoEvent, ProfileInfoState> {
  final ProfileInfoRepo repository;

  ProfileInfoBloc({required this.repository}) : super(ProfileInfoInitial()) {
    // -------- Fetch PersonalInfo --------
    on<FetchPersonalInfo>((event, emit) async {
      emit(ProfileInfoLoading());

      try {
        final response = await repository.fetchPersonalInfo();
        emit(PersonalInfoState(personalInfomodel: response));
      } catch (e) {
        emit(ProfileInfoError(message: e.toString()));
      }
    });

    // -------- Edit PersonalInfo --------
    on<EditInfoEvent>((event, emit) async {
      emit(ProfileInfoLoading());

      try {
        final response = await repository.editPersonalInfo(event.data);

        if (response["Status"] == 1) {
          String message = "Profile updated successfully";

          // extract message safely
          final data = response["Data"];
          if (data is List && data.isNotEmpty) {
            final inner = data[0];
            if (inner is List && inner.isNotEmpty) {
              final msgObject = inner[0];
              if (msgObject is Map && msgObject["msg"] != null) {
                message = msgObject["msg"].toString();
              }
            }
          }

          emit(EditSuccess(message: message));
        } else {
          emit(
            ProfileInfoError(
              message: response["Info"]?.toString() ?? "Something went wrong",
            ),
          );
        }
      } catch (e) {
        emit(ProfileInfoError(message: e.toString()));
      }
    });
  }
}
