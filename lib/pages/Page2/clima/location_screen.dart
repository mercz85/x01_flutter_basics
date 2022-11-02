import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:x01_flutter_basics/pages/Page2/clima/services/city_screen.dart';
import 'package:x01_flutter_basics/pages/Page2/clima/services/weather.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({Key? key, this.weatherData}) : super(key: key);

  final weatherData;

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weatherModel = WeatherModel();

  int temperature = 0;
  String conditionIconData = '';
  String cityName = '';
  String message = 'ERROR fetching the wheater';

  @override
  void initState() {
    //print(widget.weatherData);
    updateUI(widget.weatherData);
    super.initState();
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) return;

      double temp = weatherData['main']['temp'];
      temperature = temp.toInt();
      message = weatherModel.getMessage(temperature);

      var condition = weatherData['weather'][0]['id'];
      conditionIconData = weatherModel.getWeatherIcon(condition);

      cityName = weatherData['name'];
      //print(cityName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location Screen'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/clima/location_background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        //Expand Container to fit screen
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () async {
                      var weatherData = await weatherModel.getLocationWeather();
                      updateUI(weatherData);
                    },
                    icon: const Icon(Icons.near_me_sharp),
                    color: Colors.white,
                  ),
                  IconButton(
                    onPressed: () async {
                      //[passDataNavigator] receive cityName from popped CityScreen
                      String? cityName = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CityScreen()));
                      //[NullOrEmpty] anystring?.isEmpty
                      if (cityName?.isEmpty == false) {
                        var weatherData = await weatherModel
                            .getCityWeather(cityName.toString());
                        updateUI(weatherData);
                      }
                    },
                    icon: const Icon(Icons.location_city_sharp),
                    color: Colors.white,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '$temperatureº',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 60,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Text(
                    conditionIconData,
                    style: const TextStyle(
                      fontSize: 40,
                    ),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                child: Text(
                  "$message in $cityName",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 24,
              )
            ],
          ),
        ),
      ),
    );
  }
}
