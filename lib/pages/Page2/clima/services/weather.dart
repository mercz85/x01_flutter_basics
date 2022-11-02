import 'package:flutter/material.dart';
import 'package:x01_flutter_basics/pages/Page2/clima/services/secrets.dart';

import 'location.dart';
import 'networking.dart';

const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';
const weatherAPIKey = 'weather_API_key';

//'https://api.openweathermap.org/data/2.5/weather?q=London&appid=xxxxxxxx';
class WeatherModel {
  String _apiKey = '';

  WeatherModel() {
    setApikey();
  }

  Future<void> setApikey() async {
    _apiKey = (await SecretFile().getValueFromKey(weatherAPIKey))!;
  }

  checkAPIkey() async {
    if (_apiKey == '') {
      await setApikey();
    }
  }

  Future<dynamic> getCityWeather(String cityName) async {
    await checkAPIkey();

    var url = '$openWeatherMapURL?q=$cityName&appid=$_apiKey&units=metric';
    //var url = '$openWeatherMapURL?q=$cityName&appid=$apiKey';

    NetworkHelper networkHelper = NetworkHelper(url);
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    await checkAPIkey();

    // void getLocation(
    // ) async {
    //Future<void> getLocationData() async {
    Location location = Location();
    await location.getCurrentLocation();
    //print(location.latitude.toString() + ' ' + location.longitud.toString());
    NetworkHelper networkHelper = NetworkHelper(
        //[Interpolation] ${location.latitude}
        '$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$_apiKey&units=metric');

    var weatherData = await networkHelper.getData();
    //print(weatherData["main"]);
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
