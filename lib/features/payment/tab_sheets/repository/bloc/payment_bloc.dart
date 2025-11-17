import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ghorx_mobile_app_new/features/payment/tab_sheets/repository/payment_repo.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final PaymentRepo repository;
  PaymentBloc({required this.repository}) : super(PaymentInitial()) {
    on<FetchPaymentInfo>((event, emit) async{
      emit(PaymentLoading());
      try{
final response = await repository.fetchPaymentHis(event.dateValue);
      if (response["Status"] == 1) {
        emit(PaymentSuccess(response: response));
      }else{
        emit(PaymentFailure(error: response["Info"]));
      }
      }catch (e){
       emit( PaymentFailure(error: e.toString()));
      }
     
    });
  }
}
