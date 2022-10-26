import 'package:flutter/services.dart';
import 'dart:convert';

class SecretFile {
  String? _weather_API_key = '';

  Future<String?> getWeatherAPIKey() async {
    await readJson();
    return _weather_API_key;
  }

  //[readJSONFile]
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/secrets.json');
    final data = await jsonDecode(response);
    //Parse json List to List<dynamic>
    final List<dynamic> dataSecrets = data['secrets'];
    final Map<String, String> secretsMap = {};

    for (int i = 0; i < dataSecrets.length; i++) {
      //Mapping the List<dynamic>
      secretsMap[dataSecrets[i]['key']] = dataSecrets[i]['value'];
    }

    _weather_API_key = secretsMap["weather_API_key"];
  }
}

/*
NOTE: secrets.json file format

{
    "secrets": [
      {
        "key": "weather_API_key",
        "value": "xxxxxx"
      }
    ]
}

*/
