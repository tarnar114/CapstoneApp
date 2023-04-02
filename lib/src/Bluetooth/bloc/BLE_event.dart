import 'package:capstone_app/src/Bluetooth/bloc/BLE_state.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

abstract class BleEvent {}

class Scanning extends BleEvent {}

class ConnectToDeviceEvent extends BleEvent {}

class Disconnected extends BleEvent {}

class DeviceConnected extends BleEvent {
  ConnectionStateUpdate update;
  DeviceConnected(this.update);
}

class ScanFoundDevice extends BleEvent {
  final DiscoveredDevice device;
  ScanFoundDevice(this.device);
}

class BleSubscribe extends BleEvent {
  final QualifiedCharacteristic characteristic;

  BleSubscribe(this.characteristic);
}

class WriteCharacteristicEvent extends BleEvent {
  final List<int> value;

  WriteCharacteristicEvent(this.value);
}

class Disconnect extends BleEvent {}
