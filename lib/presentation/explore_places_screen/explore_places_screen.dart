import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hierosecret/core/app_export.dart';
import 'package:hierosecret/presentation/explore_places_screen/models/cardslist_item_model.dart';
import 'package:latlong2/latlong.dart';

import 'controller/api_services.dart';

class ExplorePlacesScreen extends StatefulWidget {
  @override
  _ExplorePlacesScreenState createState() => _ExplorePlacesScreenState();
}

class _ExplorePlacesScreenState extends State<ExplorePlacesScreen> {
  List<CardslistItemModel> places = [];
  LatLng? userLocation;

  @override
  void initState() {
    super.initState();
    determineUserLocation();
    loadPlaces();
  }

  Future<void> determineUserLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print("Location services are disabled.");
      return;
    }

    // Check location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print("Location permission denied.");
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print("Location permissions are permanently denied.");
      return;
    }

    // Get user location
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      userLocation = LatLng(position.latitude, position.longitude);
    });
  }

  Future<void> loadPlaces() async {
    List<CardslistItemModel> fetchedPlaces = await ApiService.fetchPlaces();
    setState(() {
      places = fetchedPlaces;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Explore Places")),
      body: userLocation == null
          ? Center(child: CircularProgressIndicator())
          : FlutterMap(
              options: MapOptions(
                initialCenter: userLocation!,
                minZoom: 10.0,
                maxZoom: 12.0,
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c'],
                ),
                MarkerLayer(
                  markers: places.map((place) {
                    return Marker(
                      width: 40.0,
                      height: 40.0,
                      point: LatLng(place.latitude, place.longitude),
                      child: GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) => PlaceDetails(place: place),
                            );
                          },
                          child: CustomImageView(
                            imagePath: ImageConstant.imgSettingsPrimary,
                            height: 122.adaptSize,
                            width: 122.adaptSize,
                            color: const Color.fromARGB(255, 155, 10, 0),
                          )),
                    );
                  }).toList(),
                ),
              ],
            ),
    );
  }
}

class PlaceDetails extends StatelessWidget {
  final CardslistItemModel place;

  const PlaceDetails({required this.place});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      height: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(place.name,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text("Rating: ${place.rate}/5"),//todo add stars
          SizedBox(height: 8),
          Text(place.description),
        ],
      ),
    );
  }
}
