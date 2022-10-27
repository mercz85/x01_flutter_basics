import 'package:flutter/services.dart';
import 'dart:convert';

/*  NOTES: 
secrets.json is not kept on GitHub since it's a file to store api keys or passwords, you have to add it locally
secrets.json FILE FORMAT:

{
    "secrets": [
      {
        "key": "weather_API_key",
        "value": "xxxxxx"
      }
    ]
}

*/

class SecretFile {
  Future<String?> getValueFromKey(String key) async {
    Map<String, String> secretsMap = await readJson();
    return secretsMap[key];
  }

  //[readJSONFile]
  Future<Map<String, String>> readJson() async {
    final String response = await rootBundle.loadString('assets/secrets.json');
    final data = await jsonDecode(response);
    //Parse json List to List<dynamic>
    final List<dynamic> dataSecrets = data['secrets'];
    final Map<String, String> secretsMap = {};

    for (int i = 0; i < dataSecrets.length; i++) {
      //Mapping the List<dynamic>
      secretsMap[dataSecrets[i]['key']] = dataSecrets[i]['value'];
    }

    return secretsMap;
  }
}
