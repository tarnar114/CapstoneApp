import 'package:capstone_app/src/Socket/bloc/socketEvent.dart';
import 'package:capstone_app/src/Socket/bloc/socketState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';

class socketBloc extends Bloc<socketEvent, socketState> {
  late Socket sock;
  socketBloc() : super(socketState.initial()) {
    on<socketConn>(connect);
    on<socketWrite>(write);
    on<socketConnected>(connected);
  }
  void connect(socketConn event, Emitter<socketState> emit) async {
    emit(state.copyWith(Connecting: true));
    sock = await Socket.connect("192.168.2.22", 80).catchError((err) {
      print("socket connect issue: " + err.toString());
    });
    add(socketConnected());
  }

  void connected(socketConnected event, Emitter<socketState> emit) {
    emit(state.copyWith(Connected: true, Connecting: false, sock: sock));
  }

  void write(socketWrite event, Emitter<socketState> emit) {
    sock.write(event.value + "\n");
  }
}
