import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:primeseek/screens/screen2.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
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
                  'Location ...',
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
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Search for a location',
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide:
                            BorderSide(style: BorderStyle.solid, width: 2)),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 250.0,
                color: Colors.white70,
                child: Image.network(
                  'https://media.istockphoto.com/id/1371312054/photo/air-condition-outdoor-unit-compressor-install-outside-the-building.jpg?s=612x612&w=0&k=20&c=GZYyRWF87lSQIzaeKs9u2wQ8QGtt7Vz-7GYH_WKKScM=',
                  width: MediaQuery.of(context).size.width,
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ServiceProvider(
                      icon: Icons.bolt,
                      name: 'Electrician',
                    ),
                    ServiceProvider(
                      icon: Icons.water_drop,
                      name: 'Plumber',
                    ),
                    ServiceProvider(
                      icon: Icons.cleaning_services,
                      name: 'House Keeping',
                    ),
                    ServiceProvider(
                      icon: Icons.construction,
                      name: 'Construction',
                    ),
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
              Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ServiceProvider(
                      icon: Icons.water_drop,
                      name: 'Plumber',
                    ),
                    ServiceProvider(
                      icon: Icons.bolt,
                      name: 'Electrician',
                    ),
                    ServiceProvider(
                      icon: Icons.construction,
                      name: 'Construction',
                    ),
                    ServiceProvider(
                      icon: Icons.cleaning_services,
                      name: 'House Keeping',
                    ),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ServiceProvider(
                      icon: Icons.cleaning_services,
                      name: 'House Keeping',
                    ),
                    ServiceProvider(
                      icon: Icons.bolt,
                      name: 'Electrician',
                    ),
                    ServiceProvider(
                      icon: Icons.water_drop,
                      name: 'Plumber',
                    ),
                    ServiceProvider(
                      icon: Icons.construction,
                      name: 'Construction',
                    ),
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
  ServiceProvider({
    super.key,
    required this.name,
    required this.icon,
  });
  String name;
  IconData icon;
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
          child: Column(
            children: [
              Icon(
                widget.icon,
                color: Colors.black,
                size: 30,
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                '${widget.name}',
                style: GoogleFonts.inriaSans(fontWeight: FontWeight.w700),
              )
            ],
          ),
        ),
      ),
    );
  }
}
