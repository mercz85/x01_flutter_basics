import 'package:http/http.dart' as http;
import 'dart:convert'; //to use jsonDecode

/*
//https://openweathermap.org/current

    Uri urlXML = Uri.parse(
        'https://samples.openweathermap.org/data/2.5/weather?q=London&mode=xml&appid=b6907d289e10d714a6e88b30761fae22');

*/

class NetworkHelper {
  final String url;
  NetworkHelper(this.url);

  Future getData() async {
    //[http]
    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      String data = response.body;

/*  [jsonDecode]

      //KEY: "cord":{"lon": 139.01,"lat": 35.02}
      var longitude = jsonDecode(data)['coord']['lon'];
      //LIST[]: "weather":[{"id":800,"description":"clear sky"}]
      var weatherDescription = jsonDecode(data)['weather'][0]['description'];
*/
      //NOTICE DIFFERENT WAYS OF DECLARING VARIABLE TYPES
      var decodedData = jsonDecode(data); //could be just 'var' or 'dynamic'
      return decodedData;
    } else {
      print(response.statusCode);
    }
  }
}
