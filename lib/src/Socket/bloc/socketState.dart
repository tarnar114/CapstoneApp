import 'dart:io';

class socketState {
  final bool Connecting, Connected;
  late Socket? sock;
  socketState({required this.Connecting, required this.Connected, this.sock});
  factory socketState.initial() {
    return socketState(Connecting: false, Connected: false);
  }
  socketState copyWith({bool? Connecting, bool? Connected, Socket? sock}) {
    return socketState(
        Connecting: Connecting ?? this.Connecting,
        Connected: Connected ?? this.Connected,
        sock: sock ?? this.sock);
  }
}
