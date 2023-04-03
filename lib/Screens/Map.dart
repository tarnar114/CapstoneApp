import 'package:capstone_app/src/Bluetooth/bloc/BLE_bloc.dart';
import 'package:capstone_app/src/Bluetooth/bloc/BLE_event.dart';
import 'package:flutter/material.dart';
import '../widgets/CustAppBar.dart';
import '../widgets/CustDrawer.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:capstone_app/src/Bluetooth/bloc/BLE_state.dart';

class Map extends StatefulWidget {
  const Map({super.key});

  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  late GoogleMapController mapController;
  LatLng _currentPosition = LatLng(45.521563, -122.677433);
  String res = "";
  Location location = Location();
  bool permStatus = true;
  bool loading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLoc();
  }

  getLoc() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        res = "perms issue";
        permStatus = false;
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        setState(() {
          res = "perms issue";
          permStatus = false;
        });
        return;
      }
    }
    setState(() {
      res = "waiting for GPS locations";
    });

    await getGPSsettings();

    List<int> arduinoRes = getArduinoRes();
    if (arduinoRes.isNotEmpty) {
      setState(() {
        loading = false;
      });
      print("gps data non empty")
    } else {
      print("gps data empty");
    }
  }

  Future<void> getGPSsettings() async {
    context.read<BleBloc>().add(BleReadEvent());
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  List<int> getArduinoRes() {
    if (context.read<BleState>().arduinoRes.isEmpty) {
      return [];
    } else {
      return context.read<BleState>().arduinoRes;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<BleBloc, BleState, int>(
      selector: ((state) {
        if (permStatus) {
          if (loading) {
            if (permStatus) {
              return 1;
            } else {
              return 2;
            }
          }
        } else {
          if (loading) {
            return 3;
          } else {
            return 4;
          }
        }
        return 5;
      }),
      builder: (context, state) {
        if (state == 1) {
          return Container(
            child: Text("loading but perms"),
          );
        } else if (state == 2) {
          return Container(child: Text("gotten gps data"));
        } else {
          return Container(
            child: Text("loading and perms"),
          );
        }
      },
    );
    // if (loading && permStatus == false) {
    //   return Center(
    //       child: Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: [CircularProgressIndicator(), Text("looking for GPS data")],
    //   ));
    // } else if (loading == false && permStatus == true) {
    //   return GoogleMap(
    //       onMapCreated: _onMapCreated,
    //       initialCameraPosition: CameraPosition(
    //         target: _currentPosition,
    //         zoom: 15.0,
    //       ));
    // } else {
    //   return Center(
    //     child: Column(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: [Text("perm issue")]),
    //   );
    // }
  }
}
