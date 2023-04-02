import 'package:bloc/bloc.dart';
import 'package:capstone_app/src/BarcodeScan/Scan.dart';
import 'dart:async';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:capstone_app/src/Bluetooth/bloc/BLE_state.dart';
import 'package:location/location.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:capstone_app/src/Bluetooth/bloc/BLE_event.dart';

class BleBloc extends Bloc<BleEvent, BleState> {
  final FlutterReactiveBle _ble = FlutterReactiveBle();
  late StreamSubscription<DiscoveredDevice> _scanStream;
  late Stream<ConnectionStateUpdate> _currConnectStream;
  late StreamSubscription<ConnectionStateUpdate> _currConnectSub;
  BleBloc() : super(BleState.initial()) {
    on<Scanning>(scanEvent);
    on<ConnectToDeviceEvent>(connectEvent);
    on<BleSubscribe>(subEvent);
    on<ScanFoundDevice>(foundDevice);
    on<WriteCharacteristicEvent>(writeEvent);
    on<Disconnect>(disconnectEvent);
    on<DeviceConnected>(connectedDevice);
  }
  Future<void> disconnectEvent(Disconnect event, Emitter<BleState> emit) async {
    _ble.deinitialize();
    emit(BleState.initial());
  }

  void subEvent(BleSubscribe event, Emitter<BleState> emit) async {
    _ble.subscribeToCharacteristic(event.characteristic).listen((event) {
      print("notifications:" + event.toString());
    }).onError((error) {
      print("error msg:" + error.toString());
    });
  }

  void writeEvent(
      WriteCharacteristicEvent event, Emitter<BleState> emit) async {
    print("writing to arduino");
    if (state.rxChar == null) {
      print("rxChar is null");
    }
    try {
      print("rxChar:" + state.rxChar.toString());
      if (state.rxChar != null) {
        try {
          await _ble.writeCharacteristicWithResponse(state.rxChar!,
              value: event.value);
        } catch (e) {
          print(e.toString());
        }
      }
    } catch (e) {
      print("write err: " + e.toString());
    }
  }

  void connectedDevice(DeviceConnected event, Emitter<BleState> emit) {
    if (event.update.connectionState == DeviceConnectionState.connected) {
      emit(state.copyWith(
          rxChar: QualifiedCharacteristic(
              serviceId: state.serviceUuid,
              characteristicId: state.charUuid,
              deviceId: event.update.deviceId),
          deviceId: event.update.deviceId,
          Connected: true));
    }
  }

  void connectEvent(ConnectToDeviceEvent event, Emitter<BleState> emit) async {
    print("bloc connecting");
    if (state.uniqueDevice != null) {
      state.copyWith(Connecting: true);
      _currConnectStream = _ble.connectToAdvertisingDevice(
          id: state.uniqueDevice!.id,
          withServices: [state.serviceUuid, state.charUuid],
          prescanDuration: const Duration(seconds: 1));
      _currConnectSub = _currConnectStream.listen((event) {
        switch (event.connectionState) {
          case DeviceConnectionState.connected:
            {
              print("-----connected-----");
              add(DeviceConnected(event));
              add(BleSubscribe(state.rxChar!));
              // _ble.writeCharacteristicWithoutResponse(
              //     QualifiedCharacteristic(
              //         serviceId: state.serviceUuid,
              //         characteristicId: state.charUuid,
              //         deviceId: event.deviceId),
              //     value: [1]);
              break;
            }
          // Can add various state state updates on disconnect
          case DeviceConnectionState.disconnected:
            {
              print("-----disconnected-----");
              add(DeviceConnected(event));
              break;
            }
          case DeviceConnectionState.connecting:
            {
              print("------connecting----");
              break;
            }
          case DeviceConnectionState.disconnecting:
            {
              print("------disconnecting----");
              break;
            }

          default:
        }
      }, onError: (dynamic error) {
        print("connection error");
        print(error.toString());
      });
      return;
    } else {
      emit(state.copyWith(uniqueDevice: null));
      print("error: something is wrong with your unique device");
      return;
    }
  }

  void scanEvent(Scanning event, Emitter<BleState> emit) async {
    emit(state.copyWith(Scanning: true));
    print("bloc scanning");
    Location location = Location();
    bool permGranted = false;
    PermissionStatus _permissionGranted;
    DiscoveredDevice arduino;
    print("scan started");
    _permissionGranted = await location.hasPermission();
    print(_permissionGranted.name);
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    } else {
      permGranted = true;
    }
    if (permGranted) {
      _scanStream = _ble.scanForDevices(
          withServices: [state.serviceUuid],
          scanMode: ScanMode.lowLatency).listen((event) {
        if (event.name.isNotEmpty) {
          print(event.name);
          add(ScanFoundDevice(event));
        }
      });
    }
  }

  void foundDevice(ScanFoundDevice event, Emitter<BleState> emit) {
    if (event.device.name == "Nano 33 BLE Sense") {
      print("connected");
      emit(state.copyWith(Scanning: false, uniqueDevice: event.device));
      _scanStream.cancel();
      add(ConnectToDeviceEvent());
    } else {
      if (state.uniqueDevice != null) {
        emit(state.copyWith(Scanning: false));
      } else {
        emit(state.copyWith(Scanning: true, uniqueDevice: null));
      }
    }
  }
}
