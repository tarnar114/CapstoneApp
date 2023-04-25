import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'dart:async';

class BleState {
  final bool scanning, connecting, connected;
  late DiscoveredDevice? uniqueDevice;
  late QualifiedCharacteristic? rxChar;
  final Uuid serviceUuid, charUuid;
  final List<int> arduinoRes;
  late String? deviceId;
  BleState(
      {required this.scanning,
      required this.connecting,
      required this.connected,
      this.uniqueDevice,
      this.rxChar,
      required this.arduinoRes,
      this.deviceId,
      required this.serviceUuid,
      required this.charUuid});
  factory BleState.initial() {
    return BleState(
        scanning: false,
        connecting: false,
        connected: false,
        arduinoRes: [],
        serviceUuid: Uuid.parse("180A"),
        charUuid: Uuid.parse("2A57"),
        uniqueDevice: null,
        rxChar: null,
        deviceId: "");
  }
  BleState copyWith(
      {bool? scanning,
      bool? connecting,
      bool? connected,
      DiscoveredDevice? uniqueDevice,
      StreamSubscription<DiscoveredDevice>? scanStream,
      QualifiedCharacteristic? rxChar,
      Uuid? serviceUuid,
      Uuid? charUuid,
      String? deviceId,
      List<int>? arduinoRes}) {
    return BleState(
        scanning: scanning ?? this.scanning,
        connecting: connecting ?? this.connecting,
        connected: connected ?? this.connected,
        uniqueDevice: uniqueDevice ?? this.uniqueDevice,
        rxChar: rxChar ?? this.rxChar,
        serviceUuid: serviceUuid ?? this.serviceUuid,
        charUuid: charUuid ?? this.charUuid,
        arduinoRes: arduinoRes ?? this.arduinoRes,
        deviceId: deviceId ?? this.deviceId);
  }
}
