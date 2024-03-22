import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:primeseek/screens/interiordecors.dart';
import 'package:primeseek/screens/screen2.dart';
import 'package:primeseek/screens/search.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _locationData = 'Location will be updated automatically';
  Position? _currentPosition;
  String? _currentCity;

  @override
  void initState() {
    super.initState();
    _startLocationUpdates();
  }

  void _startLocationUpdates() {
    const Duration updateInterval = Duration(seconds: 15);

    _getCurrentLocation();

    Timer.periodic(updateInterval, (Timer timer) {
      _getCurrentLocation();
    });
  }

  void _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _currentPosition = position;
        _locationData = 'Last updated: ${DateTime.now()}';
      });

      // Access the latitude and longitude from the position
      double latitude = _currentPosition?.latitude ?? 0.0;
      double longitude = _currentPosition?.longitude ?? 0.0;

      print('Latitude: $latitude, Longitude: $longitude');

      // Now you can use these latitude and longitude values as needed.
      // If you want to update the city based on these coordinates, you can use the geocoding package as shown in the previous example.
      _getCityName(latitude, longitude);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _getCityName(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        setState(() {
          _currentCity = place.locality ?? 'City Not Found';
        });
      } else {
        setState(() {
          _currentCity = 'City Not Found';
        });
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        _currentCity = 'Error fetching city';
      });
    }
  }

  final List<String> imageUrls = [
    'https://media.istockphoto.com/id/1371312054/photo/air-condition-outdoor-unit-compressor-install-outside-the-building.jpg?s=612x612&w=0&k=20&c=GZYyRWF87lSQIzaeKs9u2wQ8QGtt7Vz-7GYH_WKKScM=',
    'https://www.thestatesman.com/wp-content/uploads/2017/08/1487584282-water-supply.-getty.jpg',
    'https://t4.ftcdn.net/jpg/00/68/63/23/360_F_68632352_kmHLwFc2rQLmnKqn6gM0bhOPqxRTx8sY.jpg',
  ];

  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              children: [
                Icon(
                  Icons.pin_drop_outlined,
                  color: Colors.black,
                  size: 30.0,
                ),
                SizedBox(
                  width: 8.0,
                ),
                Text(
                  '$_currentCity',
                  style: GoogleFonts.reemKufi(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SearchLocation()));
                  },
                  child: Container(
                      child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: Colors.grey, width: 2),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 10.0),
                        Expanded(
                          child: Text(
                            'Search for a location',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 17),
                          ),
                        ),
                      ],
                    ),
                  )),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              CarouselSlider(
                items: imageUrls.map((imageUrl) {
                  return Builder(
                    builder: (BuildContext context) {
                      return GestureDetector(
                        onTap: () {
                          // Handle the tap event if needed
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            image: DecorationImage(
                              image: NetworkImage(imageUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
                options: CarouselOptions(
                  height: 200.0,
                  enlargeCenterPage: true,
                  autoPlay: true,
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Text(
                      "Domestic Services",
                      style: GoogleFonts.inriaSans(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.left,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 145,
                // Set the height as needed
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  reverse: true, // Set reverse to true
                  children: [
                    ServiceProvider(
                      icon: Icons.construction,
                      name: 'Construction',
                      colr: Colors.black,
                    ),

                    ServiceProvider(
                      icon: Icons.water_drop,
                      name: 'Plumber',
                      colr: Colors.blue.shade700,
                    ),
                    ServiceProvider(
                      icon: Icons.cleaning_services,
                      name: 'House Keeping',
                      colr: Colors.green,
                    ),
                    ServiceProvider(
                      icon: Icons.bolt,
                      name: 'Electrician',
                      colr: Colors.yellow.shade700,
                    ),

                    // Add more ServiceProvider widgets as needed
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Text(
                      "Home Services",
                      style: GoogleFonts.inriaSans(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.left,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 275,
                  // Set the height as needed
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    reverse: true, // Set reverse to true
                    children: [
                      AdvServiceProvider(
                        icon: Icons.cleaning_services,
                        name: 'House Keeping',
                        colr: Colors.green,
                      ),

                      AdvServiceProvider(
                        icon: Icons.water_drop,
                        name: 'Plumber',
                        colr: Colors.blue.shade700,
                      ),
                      AdvServiceProvider(
                        icon: Icons.bolt,
                        name: 'Electrician',
                        colr: Colors.yellow.shade700,
                      ),
                      AdvServiceProvider(
                        icon: Icons.construction,
                        name: 'Construction',
                        colr: Colors.black,
                      ),
                      // Add more ServiceProvider widgets as needed
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Text(
                      "Commercial Services",
                      style: GoogleFonts.inriaSans(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.left,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 145,
                // Set the height as needed
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  reverse: true, // Set reverse to true
                  children: [
                    ServiceProvider(
                      icon: Icons.cleaning_services,
                      name: 'House Keeping',
                      colr: Colors.green,
                    ),
                    ServiceProvider(
                      icon: Icons.bolt,
                      name: 'Electrician',
                      colr: Colors.yellow.shade700,
                    ),
                    ServiceProvider(
                      icon: Icons.water_drop,
                      name: 'Plumber',
                      colr: Colors.blue.shade700,
                    ),
                    ServiceProvider(
                      icon: Icons.construction,
                      name: 'Construction',
                      colr: Colors.black,
                    ),
                    // Add more ServiceProvider widgets as needed
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ServiceProvider extends StatefulWidget {
  ServiceProvider(
      {super.key, required this.name, required this.icon, required this.colr});
  String name;
  IconData icon;
  Color colr;
  @override
  State<ServiceProvider> createState() => _ServiceProviderState();
}

class _ServiceProviderState extends State<ServiceProvider> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Screen2()));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: InkWell(
            onTap: () {
              if (widget.name == 'Interior Decors') {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => InteriorDecors()));
              } else {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Screen2()));
              }
            },
            child: Container(
              height: 130,
              width: 125,
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    widget.icon,
                    color: widget.colr,
                    size: 45,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    '${widget.name}',
                    style: GoogleFonts.inriaSans(fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AdvServiceProvider extends StatefulWidget {
  AdvServiceProvider(
      {super.key, required this.name, required this.icon, required this.colr});
  String name;
  IconData icon;
  Color colr;
  @override
  State<AdvServiceProvider> createState() => _AdvServiceProviderState();
}

class _AdvServiceProviderState extends State<AdvServiceProvider> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Screen2()));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: InkWell(
            onTap: () {
              if (widget.name == 'Interior Decors') {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => InteriorDecors()));
              } else {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Screen2()));
              }
            },
            child: Container(
              height: 300,
              width: 150,
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    widget.icon,
                    color: widget.colr,
                    size: 45,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    '${widget.name}',
                    style: GoogleFonts.inriaSans(fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
