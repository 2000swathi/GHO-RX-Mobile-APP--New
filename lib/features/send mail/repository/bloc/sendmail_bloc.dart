import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ghorx_mobile_app_new/features/send%20mail/repository/bloc/sendmail_event.dart';
import 'package:ghorx_mobile_app_new/features/send%20mail/repository/sendmail_repo.dart';

part 'sendmail_state.dart';

class SendmailBloc extends Bloc<SendmailEvent, SendmailState> {
  final SendEmailRepository repository;

  SendmailBloc({required this.repository}) : super(SendmailInitial()) {
    // Send Email Event
    on<SendMail>((event, emit) async {
      emit(SendmailLoading());
      try {
        final response = await repository.sendEmail(
          event.adminEmailId,
          event.doctorEmailid,
          event.msg,
        );
        if (response["Status"] == 1) {
          emit(SendmailSuccess(message: response["Data"][0][0]["msg"]));
        } else {
          emit(SendmailFailure(error: response["Info"]));
        }
      } catch (e) {
        emit(SendmailFailure(error: e.toString()));
      }
    });

    // Save Draft Event
    on<SaveDraft>((event, emit) async {
      emit(SendmailLoading());
      try {
        await repository.saveDraft(event.from, event.to, event.msg);
        emit(const SendmailSuccess(message: "Draft saved successfully"));
      } catch (e) {
        emit(SendmailFailure(error: e.toString()));
      }
    });

    // Discard Mail Event
    on<DiscardMail>((event, emit) {
      emit(SendmailInitial());
    });
  }
}
