import 'package:lostify/features/user/map/views/widgets/city_map_view.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapBody extends StatelessWidget {
  final String cityName;
  final Future<LatLng> cityCoordinatesFuture;

  const MapBody({super.key, 
    required this.cityName,
    required this.cityCoordinatesFuture,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<LatLng>(
      future: cityCoordinatesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (!snapshot.hasData) {
          return const Center(child: Text("No location found"));
        }

        return CityMapView(
          cityName: cityName,
          cityCoordinates: snapshot.data!,
        );
      },
    );
  }
}
