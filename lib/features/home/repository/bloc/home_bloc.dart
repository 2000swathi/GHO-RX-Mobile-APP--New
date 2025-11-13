import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghorx_mobile_app_new/features/home/repository/home_repository.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository repository;

  HomeBloc({required this.repository}) : super(HomeInitial()) {
    on<FetchHomePageInfo>(_onFetchHomePage);
  }
  Future<void> _onFetchHomePage(
    FetchHomePageInfo event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomePageLoading());

    try {
      final response = await repository.fetchHomePageInfo();
      if (response["Status"] == 1) {
        emit(HomePageInfoState(response: response));
      }else{
        emit(HomePageError(message: response["Info"]));
      }
    } catch (e) {
      emit(HomePageError(message: e.toString()));
    }
  }
}
