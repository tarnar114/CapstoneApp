import 'package:flutter/material.dart';
import '../widgets/CustAppBar.dart';
import '../widgets/CustDrawer.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class Map extends StatefulWidget {
  const Map({super.key});

  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  late GoogleMapController mapController;
  LatLng _currentPosition = LatLng(43.72667491215607, -79.24246156557156);
  Location location = Location();
  bool permStatus = false;
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
        setState(() {
          loading = false;
        });
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        setState(() {
          loading = false;
        });
        return;
      }
    }

    if (_currentPosition.latitude != null &&
        _currentPosition.longitude != null) {
      permStatus = true;
      setState(() {
        loading = false;
      });
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    if (loading && !permStatus) {
      return Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [CircularProgressIndicator()],
      ));
    } else {
      return GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _currentPosition,
            zoom: 15.0,
          ));
    }
  }
}
