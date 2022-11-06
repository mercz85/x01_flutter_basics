import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:x01_flutter_basics/pages/Page2/clima/location_screen.dart';

import 'package:x01_flutter_basics/pages/Page2/clima/services/weather.dart';

const apiKey = '';

class LoadingScreen extends StatefulWidget {
  LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double latitude = 0;
  double longitude = 0;

  void getLocationData() async {
    // Location location = Location();
    // await location.getCurrentLocation();
    // latitude = location.latitude;
    // longitude = location.longitude;

    WeatherModel weatherModel = WeatherModel();
    var data = await weatherModel.getLocationWeather();

    //[passDataConstructor]
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => LocationScreen(
                weatherData: data,
              )),
    );
  }

  @override
  void initState() {
    getLocationData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Center(
        //[spinner]
        child: SpinKitDoubleBounce(
          color: Colors.blue,
          size: 100,
        ),
      ),
    );
  }
}
