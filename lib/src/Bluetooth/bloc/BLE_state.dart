import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'dart:async';

class BleState {
  final bool Scanning, Connecting, Connected;
  late DiscoveredDevice? uniqueDevice;
  late QualifiedCharacteristic? rxChar;
  final Uuid serviceUuid, charUuid;
  final List<int> arduinoRes;
  late String? deviceId;
  BleState(
      {required this.Scanning,
      required this.Connecting,
      required this.Connected,
      this.uniqueDevice,
      this.rxChar,
      required this.arduinoRes,
      this.deviceId,
      required this.serviceUuid,
      required this.charUuid});
  factory BleState.initial() {
    return BleState(
        Scanning: false,
        Connecting: false,
        Connected: false,
        arduinoRes: [],
        serviceUuid: Uuid.parse("180A"),
        charUuid: Uuid.parse("2A57"),
        uniqueDevice: null,
        rxChar: null,
        deviceId: "");
  }
  BleState copyWith(
      {bool? Scanning,
      bool? Connecting,
      bool? Connected,
      DiscoveredDevice? uniqueDevice,
      StreamSubscription<DiscoveredDevice>? scanStream,
      QualifiedCharacteristic? rxChar,
      Uuid? serviceUuid,
      Uuid? charUuid,
      String? deviceId,
      List<int>? arduinoRes}) {
    return BleState(
        Scanning: Scanning ?? this.Scanning,
        Connecting: Connecting ?? this.Connecting,
        Connected: Connected ?? this.Connected,
        uniqueDevice: uniqueDevice ?? this.uniqueDevice,
        rxChar: rxChar ?? this.rxChar,
        serviceUuid: serviceUuid ?? this.serviceUuid,
        charUuid: charUuid ?? this.charUuid,
        arduinoRes: arduinoRes ?? this.arduinoRes,
        deviceId: deviceId ?? this.deviceId);
  }
}
