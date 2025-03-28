// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart'; // For getting location
import 'package:latlong2/latlong.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:nahrain_univ/drawer/main_drawer.dart';
import 'package:nahrain_univ/markerdet/eng_details.dart';
import 'package:shared_preferences/shared_preferences.dart';



class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {

bool _isSignedIn = false;
  String? _userName;


Future<void> _checkAuthStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    
    setState(() {
      _isSignedIn = token != null && token.isNotEmpty;
      _userName = prefs.getString('username');
    });
  }


  Color nharaincol = const Color.fromARGB(255, 14, 66, 139);

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
    LatLng(33.275637, 44.372240),
    LatLng(33.275624, 44.372143),
    LatLng(33.277032, 44.372567),
    LatLng(33.277084, 44.372588),
    LatLng(33.280324, 44.374281),
    LatLng(33.280624, 44.374490),
    LatLng(33.281192, 44.374884),
    LatLng(33.281236, 44.374930),
    LatLng(33.281290, 44.375032),
    LatLng(33.281286, 44.375142),
    LatLng(33.281236, 44.375533),
    LatLng(33.281218, 44.375571),
    LatLng(33.281234, 44.375617),
    LatLng(33.281275, 44.375622),
    LatLng(33.281889, 44.375957),
    LatLng(33.281909, 44.375987),
    LatLng(33.281911, 44.376024),
    LatLng(33.281750, 44.376402),
    LatLng(33.281745, 44.376427),
    LatLng(33.281793, 44.376453),
    LatLng(33.282245, 44.376746),
    LatLng(33.282317, 44.376840),
    LatLng(33.282367, 44.376968),
    LatLng(33.282402, 44.377121),
    LatLng(33.282371, 44.377668),
    LatLng(33.282290, 44.378208),
    LatLng(33.282129, 44.378932),
    LatLng(33.280579, 44.384658),
    LatLng(33.280568, 44.384691),
    LatLng(33.280541, 44.384704),
    LatLng(33.279826, 44.385114),
    LatLng(33.278763, 44.382480),
    LatLng(33.278588, 44.382105),
    LatLng(33.278292, 44.381676),
    LatLng(33.276862, 44.380297),
    LatLng(33.276654, 44.379940),
    LatLng(33.276561, 44.379433),
    LatLng(33.276552, 44.378913),
    LatLng(33.276588, 44.377100),
    LatLng(33.276570, 44.376639),
    LatLng(33.276539, 44.376478),
    LatLng(33.276068, 44.374278),
    LatLng(33.275664, 44.372320),
    LatLng(33.275637, 44.372240),
  ];


  @override
  void initState() {
    super.initState();
   _checkAuthStatus();
    _checkLocationService(); // Check if location services are enabled
  }

  Future<void> _checkLocationService() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Location services are disabled. Please enable them in your settings.')),
      );
    } else {
      _checkAndRequestLocationPermission();
    }
  }

  Future<void> _checkAndRequestLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location permissions are denied')),
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                'Location permissions are permanently denied, please enable them in settings.')),
      );
      return;
    }

    _startLocationStream(); // Start listening for location updates if permission is granted
  }

  void _startLocationStream() {
    _positionStreamSubscription = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 3, // Update when the user moves 3 meters
      ),
    ).listen(
      (Position position) {
        LatLng userLocation = LatLng(position.latitude, position.longitude);
        bool insideBounds = _isPointInPolygon(userLocation, borderCoordinates);

        setState(() {
          if (insideBounds) {
            currentLocation = userLocation;
            isInUniversityArea = true;
            _currentZoom = 17.0; // Set the zoom level when inside the university
            _mapController.move(currentLocation!, _currentZoom);
          } else {
            isInUniversityArea = false;
            currentLocation = null;
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text('You are outside the university area!')),
            );
          }
        });
      },
      onError: (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error fetching location: $error')),
        );
      },
    );
  }

  bool _isPointInPolygon(LatLng point, List<LatLng> polygon) {
    var inside = false;

    for (var i = 0, j = polygon.length - 1; i < polygon.length; j = i++) {
      if ((polygon[i].longitude > point.longitude) !=
              (polygon[j].longitude > point.longitude) &&
          (point.latitude < (polygon[j].latitude - polygon[i].latitude) *
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
    _positionStreamSubscription?.cancel(); // Cancel the location stream when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double markerSize = screenWidth * 0.08;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'AL-Nahrain Unv. Tour Map',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold,
            color: nharaincol,
          ),
        ),
      ),
      endDrawer:  AppDrawer(nharaincol: Color.fromARGB(255, 14, 66, 139), isSignedIn: _isSignedIn,userName: 'mmmmm',),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              center: currentLocation ?? LatLng(33.2794595, 44.378828),
              zoom: _currentZoom,
              maxZoom: 18.49,
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
                    color: const Color.fromARGB(179, 14, 66, 139),
                  ),
                ],
              ),
              MarkerLayer(
                markers: [
                  if (currentLocation != null)
                    Marker(
                      point: currentLocation!,
                      builder: (ctx) => Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromARGB(255, 66, 134, 244).withOpacity(0.6),
                              blurRadius: 14,
                              spreadRadius: 8,
                              offset: const Offset(0, 0),
                            ),
                          ],
                        ),
                        child: Icon(
                          MdiIcons.circleSlice8,
                          size: markerSize,
                          color: const Color.fromARGB(255, 66, 134, 244),
                        ),
                      ),
                    ),
                    
                  Marker(
                    point: LatLng(33.280084, 44.375086),
                    builder: (ctx) => Icon(
                      Icons.location_on_rounded,
                      size: markerSize,
                      color: nharaincol,
                    ),
                  ),
                  Marker(
                    point: LatLng(33.281010, 44.379122),
                    builder: (ctx) => Icon(
                      Icons.location_on_rounded,
                      size: markerSize,
                      color: nharaincol,
                    ),
                  ),
                  Marker(
                    point: LatLng(33.278413, 44.374887),
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
                        color: nharaincol,
                      ),
                    ),
                  ),
                  Marker(
                    point: LatLng(33.279828, 44.374745),
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
                        color: nharaincol,
                      ),
                    ),
                  ),
                  Marker(
                    point: LatLng(33.279230, 44.374917),
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
                        color: nharaincol,
                      ),
                    ),
                  ),
                  Marker(
                    point: LatLng(33.280508, 44.375960),
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
                        color: nharaincol,
                      ),
                    ),
                  ),
                  Marker(
                    point: LatLng(33.278173, 44.375421),
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
                        color: const Color.fromARGB(255, 202, 19, 19),
                      ),
                    ),
                  ),
                  Marker(
                    point: LatLng(33.278467, 44.375273),
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
                        color: const Color.fromARGB(255, 202, 19, 19),
                      ),
                    ),
                  ),
                  Marker(
                    point: LatLng(33.276951, 44.375630),
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
                        color: nharaincol,
                      ),
                    ),
                  ),

                  // Add other static markers here...
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
                              'Current location is not available, you should be in the UNV.'),
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