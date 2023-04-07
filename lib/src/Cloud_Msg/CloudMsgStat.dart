import 'dart:async';

class CloudMsgState {
  final String title, name;
  final bool sending, sent;
  CloudMsgState(
      {required this.title,
      required this.name,
      required this.sending,
      required this.sent});
  factory CloudMsgState.initial() {
    return CloudMsgState(title: "", name: "", sending: false, sent: false);
  }
}
