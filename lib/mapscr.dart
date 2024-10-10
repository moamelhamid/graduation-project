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
  LatLngBounds alNahrainBounds = LatLngBounds(
   LatLng(33.2730, 44.3690), // Southwest boundary
    LatLng(33.2860, 44.3840), // Northeast boundary
  );

  LatLng? currentLocation; // Variable to store current location
  bool isInUniversityArea = false; // Flag to check if the user is inside the university

  @override
  void initState() {
    super.initState();
    _determinePosition(); // Fetch user's location when the app starts
  }

  // Function to determine the current position
  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, handle this case
      return;
    }

    // Check for location permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permission denied, handle this case
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle this case
      return;
    }

    // Get the current location
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    LatLng userLocation = LatLng(position.latitude, position.longitude);

    // Check if the user is within the university boundaries
    bool insideBounds = alNahrainBounds.contains(userLocation);

    setState(() {
      if (insideBounds) {
        currentLocation = userLocation;
        isInUniversityArea = true;
      } else {
        isInUniversityArea = false;
        currentLocation = null;
        // Optionally, display a message that the user is outside the university area
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('You are outside the university area!')),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double markerSize = screenWidth * 0.08; // Marker size relative to screen width

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
        title: const Text(
          'AL-Nahrain Uni. Map',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 17, 17, 17),
          ),
        ),
      ),
      body: FlutterMap(
        options: MapOptions(
          center: currentLocation ??
              LatLng(33.2794595, 44.378828), // Fallback to a default center if not inside university
          zoom: 15.3, // Set initial zoom level
          maxZoom: 18.49, // Maximum zoom allowed
          minZoom: 15.5,
          maxBounds: alNahrainBounds,
        ),
        children: [
          openStreetMapTileLayer,
          MarkerLayer(
            markers: [
              Marker(
                point: LatLng(33.280084, 44.375086),
                builder: (ctx) => Icon(
                  Icons.border_color_outlined,
                  size: markerSize,
                  color: const Color.fromARGB(255, 103, 14, 248),
                ),
              ),
              Marker(
                point: LatLng(33.277599, 44.379208),
                builder: (ctx) => Icon(
                  Icons.mosque,
                  size: markerSize,
                  color: const Color.fromARGB(255, 103, 14, 248),
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
                    Icons.apartment_rounded,
                    size: markerSize,
                    color: const Color.fromARGB(255, 103, 14, 248),
                  ),
                ),
              ),
              
            ],
            
          ),
              PolylineLayer(
            polylines: [
              Polyline(
                points: borderCoordinates,
                strokeWidth: 2.0, // Thickness of the border
                color: Colors.red, // Border color
              ),
            ],
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
