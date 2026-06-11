import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CityMapView extends StatefulWidget {
  final String cityName;
  final LatLng cityCoordinates;

  const CityMapView({
    super.key,
    required this.cityName,
    required this.cityCoordinates,
  });

  @override
  State<CityMapView> createState() => CityMapViewState();
}

class CityMapViewState extends State<CityMapView> {
  GoogleMapController? _mapController;
  late final Set<Marker> _markers;

  @override
  void initState() {
    super.initState();
    _markers = {
      Marker(
        markerId: MarkerId(widget.cityName),
        position: widget.cityCoordinates,
        infoWindow: InfoWindow(title: widget.cityName),
      ),
    };
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: widget.cityCoordinates,
        zoom: 12,
      ),
      markers: _markers,
      onMapCreated: (controller) {
        _mapController = controller;
        _mapController!.animateCamera(
          CameraUpdate.newLatLngZoom(widget.cityCoordinates, 20),
        );
      },
    );
  }
}
