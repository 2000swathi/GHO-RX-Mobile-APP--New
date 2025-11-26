abstract class SendmailEvent {}

class SendMail extends SendmailEvent {
  String adminEmailId;
  String doctorEmailid;
  String msg;
  SendMail({
    required this.adminEmailId,
    required this.doctorEmailid,
    required this.msg,
  });
  List<Object> get props => [adminEmailId, doctorEmailid];
}

class SaveDraft extends SendmailEvent {
  final String from;
  final String to;
  final String msg;

  SaveDraft({
    required this.from,
    required this.to,
    required this.msg,
  });
}

class DiscardMail extends SendmailEvent {}
