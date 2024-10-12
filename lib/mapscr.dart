import 'dart:async'; // Import to use StreamSubscription
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart'; // For getting location
import 'package:latlong2/latlong.dart';
import 'package:nahrain_univ/about_screen.dart';
import 'package:nahrain_univ/markerdet/eng_details.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  Color nharaincol = const Color.fromARGB(255, 103, 14, 248);

  LatLngBounds alNahrainBounds = LatLngBounds(
    LatLng(33.2730, 44.3690), // Southwest boundary
    LatLng(33.2860, 44.3840), // Northeast boundary
  );

  LatLng? currentLocation; // Variable to store current location
  bool isInUniversityArea =
      false; // Flag to check if the user is inside the university
  StreamSubscription<Position>?
      _positionStreamSubscription; // To manage the location stream
  double _currentZoom = 15.15; // Variable to store the current zoom level
  final MapController _mapController =
      MapController(); // To control map zoom and center

  List<LatLng> borderCoordinates = [
    LatLng(33.275086, 44.372009), // Southwest
    LatLng(33.275552, 44.372717), // Northwest
    LatLng(33.276180, 44.375324), // Northeast
    LatLng(33.276440, 44.376676), // Southeast
    LatLng(33.276458, 44.379637),
    LatLng(33.277184, 44.380828),
    LatLng(33.278494, 44.382191),
    LatLng(33.280010, 44.385860),
    LatLng(33.280557, 44.385592),
    LatLng(33.282360, 44.378468),
    LatLng(33.282405, 44.376837),
    LatLng(33.281929, 44.376386),
    LatLng(33.281279, 44.375995),
    LatLng(33.280979, 44.375378),
    LatLng(33.280705, 44.374643),
    LatLng(33.278216, 44.373157),
    LatLng(33.277005, 44.372503),
    LatLng(33.274834, 44.371827),
    LatLng(33.275086, 44.372009),
  ];

  @override
  void initState() {
    super.initState();
    _startLocationStream(); // Start listening for location updates
  }

  // Function to start listening for location updates
  void _startLocationStream() {
    _positionStreamSubscription = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10, // Update when the user moves 10 meters
      ),
    ).listen((Position position) {
      LatLng userLocation = LatLng(position.latitude, position.longitude);

      // Check if the user is within the polygon defined by borderCoordinates
      bool insideBounds = _isPointInPolygon(userLocation, borderCoordinates);

      setState(() {
        if (insideBounds) {
          currentLocation = userLocation;
          isInUniversityArea = true;
        } else {
          isInUniversityArea = false;
          currentLocation = null;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('You are outside the university area!')),
          );
        }
      });
    });
  }

  // Function to check if a point is inside a polygon
  bool _isPointInPolygon(LatLng point, List<LatLng> polygon) {
    var inside = false;

    for (var i = 0, j = polygon.length - 1; i < polygon.length; j = i++) {
      if ((polygon[i].longitude > point.longitude) !=
              (polygon[j].longitude > point.longitude) &&
          (point.latitude <
              (polygon[j].latitude - polygon[i].latitude) *
                      (point.longitude - polygon[i].longitude) /
                      (polygon[j].longitude - polygon[i].longitude) +
                  polygon[i].latitude)) {
        inside = !inside;
      }
    }
    return inside;
  }

  @override
  void dispose() {
    _positionStreamSubscription
        ?.cancel(); // Cancel the location stream when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double markerSize =
        screenWidth * 0.08; // Marker size relative to screen width

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) => const AboutScreen()),
              );
            },
            icon: const Icon(Icons.menu),
          )
        ],
        title: Text(
          'AL-Nahrain Uni. Map',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: nharaincol,
          ),
        ),
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              center: currentLocation ??
                  LatLng(33.2794595, 44.378828), // Fallback center
              zoom: _currentZoom,
              maxZoom: 18.49, // Maximum zoom allowed
              minZoom: 15.5,
              maxBounds: alNahrainBounds,
            ),
            children: [
              openStreetMapTileLayer,
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: borderCoordinates,
                    strokeWidth: 6.0,
                    color: const Color.fromARGB(149, 30, 33, 124),
                  ),
                ],
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: LatLng(33.280084, 44.375086),
                    builder: (ctx) => Icon(
                      Icons.location_on_rounded,
                      size: markerSize,
                      color: nharaincol,
                    ),
                  ),
                  Marker(
                    point: LatLng(33.277599, 44.379208),
                    builder: (ctx) => Icon(
                      Icons.location_on_rounded,
                      size: markerSize,
                      color: nharaincol,
                    ),
                  ),
                  Marker(
                    point: LatLng(33.278353, 44.375082),
                    builder: (ctx) => GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => const DepartmentsListScreen(),
                          ),
                        );
                      },
                      child: Icon(
                        Icons.location_on_rounded,
                        size: markerSize,
                        color: const Color.fromARGB(255, 103, 14, 248),
                      ),
                    ),
                  ),
                  if (currentLocation != null)
                    Marker(
                      point: currentLocation!,
                      builder: (ctx) => Icon(
                        Icons.location_on,
                        size: markerSize,
                        color: const Color.fromARGB(255, 163, 8, 8),
                      ),
                    ),
                ],
              ),
            ],
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: Column(
              children: [
                FloatingActionButton(
                  heroTag: 'zoomIn',
                  onPressed: () {
                    setState(() {
                      _currentZoom = (_currentZoom + 0.5).clamp(15.5, 18.49);
                      _mapController.move(_mapController.center, _currentZoom);
                    });
                  },
                  child: const Icon(Icons.zoom_in),
                ),
                const SizedBox(height: 10),
                FloatingActionButton(
                  heroTag: 'zoomOut',
                  onPressed: () {
                    setState(() {
                      _currentZoom = (_currentZoom - 0.5).clamp(15.5, 18.49);
                      _mapController.move(_mapController.center, _currentZoom);
                    });
                  },
                  child: const Icon(Icons.zoom_out),
                ),
                const SizedBox(height: 10),
                FloatingActionButton(
                  heroTag: 'currentLocation',
                  onPressed: () {
                    if (currentLocation != null) {
                      _mapController.move(currentLocation!, _currentZoom);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'Current location is not available, you should be in the UNV .'),
                        ),
                      );
                    }
                  },
                  child: const Icon(Icons.my_location),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

TileLayer get openStreetMapTileLayer => TileLayer(
      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
      userAgentPackageName: 'com.myapp.nahrainuniversitytourguide',
    );
