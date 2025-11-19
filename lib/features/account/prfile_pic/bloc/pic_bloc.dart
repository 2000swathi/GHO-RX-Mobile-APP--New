import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ghorx_mobile_app_new/features/account/prfile_pic/bloc/pic_event.dart';
import 'package:ghorx_mobile_app_new/features/account/prfile_pic/profile_pic_repo.dart';

part 'pic_state.dart';

class PicBloc extends Bloc<PicEvent, PicState> {
  final ProfilePicRepo repository;
  PicBloc({required this.repository}) : super(PicInitial()) {
    on<FetchPicEvent>((event, emit) async {
      emit(PicLoading());
      try {
        final response = await repository.fetchImage();
        if (response["Status"] == 1) {
          return emit(PicSuccess(response: response));
        } else {
          return emit(PicFailure(error: response["Info"]));
        }
      } catch (e) {
        return emit(PicFailure(error: e.toString()));
      }
    });
  }
}
