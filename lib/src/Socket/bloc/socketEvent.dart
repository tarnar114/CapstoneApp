abstract class socketEvent {}

class socketConn extends socketEvent {}

class socketConnected extends socketEvent {}

class socketWrite extends socketEvent {
  final String value;
  socketWrite(this.value);
}

class socketRead extends socketEvent {}
