import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ghorx_mobile_app_new/features/account/personal_info/repo/profile_info_repo.dart';
import 'package:ghorx_mobile_app_new/features/account/personal_info/repo/model/personalinfo_model.dart';

part 'profile_info_event.dart';
part 'profile_info_state.dart';

class ProfileInfoBloc extends Bloc<ProfileInfoEvent, ProfileInfoState> {
  final ProfileInfoRepo repository;
  ProfileInfoBloc({required this.repository}) : super(ProfileInfoInitial()) {
    
    //get

    on<FetchPersonalInfo>((event, emit) async {
      emit(ProfileInfoLoading());

      try {
        final response = await repository.fetchPersonalInfo();
        emit(PersonalInfoState(personalInfomodel: response));
      } catch (e) {
        emit(ProfileInfoError(message: e.toString()));
      }
    });
  }
}
