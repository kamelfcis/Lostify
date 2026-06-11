import 'package:lostify/core/utilies/sizes/sized_config.dart';
import 'package:lostify/features/user/map/views/widgets/map_body.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:lostify/features/user/upload_image/views/widgets/custom_header.dart';

class MapScreen extends StatefulWidget {
  final String cityName;

  const MapScreen({super.key, required this.cityName});
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late Future<LatLng> _cityCoordinates;

  @override
  void initState() {
    super.initState();
    _cityCoordinates = _fetchCityCoordinates(widget.cityName);
  }

  Future<LatLng> _fetchCityCoordinates(String cityName) async {
    try {
      final locations = await locationFromAddress(cityName);
      if (locations.isNotEmpty) {
        final loc = locations.first;
        return LatLng(loc.latitude, loc.longitude);
      } else {
        throw Exception("No locations found for $cityName");
      }
    } catch (e) {
      throw Exception("Error fetching location: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomHeader(title: "Map", icon: Icons.map),
          SizedBox(height: SizeConfig.height * 0.02),
          Expanded(
            child: MapBody(
              cityName: widget.cityName,
              cityCoordinatesFuture: _cityCoordinates,
            ),
          ),
        ],
      ),
    );
  }
}


