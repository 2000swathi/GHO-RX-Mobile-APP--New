import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghorx_mobile_app_new/features/home/repository/home_repository.dart';
import 'package:ghorx_mobile_app_new/features/home/repository/model/homepage_model.dart';
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
      final home = await repository.fetchHomePageInfo();
      emit(HomePageInfoState(homePageModel: home));
    } catch (e) {
      emit(HomePageError(message: e.toString()));
    }
  }
}
