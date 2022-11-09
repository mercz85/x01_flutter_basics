import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import '../../../secrets.dart';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate/';
const apiKeyName = 'coin_API_key';

//full url
// https://rest.coinapi.io/v1/exchangerate/BTC?apikey=XXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXXX
/* JSON format
  {
    "asset_id_base": "BTC",
    "rates" : [
      {
        "time": "2017-08-09T14:31:37.0520000Z",
        "asset_id_quote": "USD",
        "rate": 3258.8875417798037784035133948
      },
      {
        "time": "2017-08-09T14:31:36.7570000Z",
        "asset_id_quote": "EUR",
        "rate": 2782.5255080599273092901331567
      },
      {
        "time": "2017-08-09T14:31:36.7570000Z",
        "asset_id_quote": "CNY",
        "rate": 21756.295595926054627342411501
      },
      {
        "time": "2017-08-09T14:31:36.7570000Z",
        "asset_id_quote": "GBP",
        "rate": 2509.6024203799580199765804823
      }
    ]
  }
   */
class CoinData {
  String _apiKey = '';

  CoinData() {
    setApikey();
  }

  Future<void> setApikey() async {
    _apiKey = (await SecretFile().getValueFromKey(apiKeyName))!;
  }

  checkAPIkey() async {
    if (_apiKey == '') {
      await setApikey();
    }
  }

  Future getCoinsData(String selectedCurrency) async {
    await checkAPIkey();

    var result = <String, String>{};
    DateTime now = DateTime.now();
    Uri url = Uri();
    var client = http.Client();
    var headers = <String, String>{'X-CoinAPI-Key': _apiKey};

    try {
      for (String cryptoCoin in cryptoList) {
        url = Uri.parse('$coinAPIURL$cryptoCoin/$selectedCurrency');
        var response = await client.get(url, headers: headers);
        //var response = await client.get(url);
        if (response.statusCode == 200) {
          var jsonResponse =
              convert.jsonDecode(response.body) as Map<String, dynamic>;

          result[cryptoCoin] = jsonResponse['rate'].toStringAsFixed(0);
        } else {
          throw 'Request failed with status: ${response.statusCode}. For $cryptoCoin';
        }
      }
    } finally {
      client.close();
    }

    return result;
  }

  //Seguir aqui: https://pub.dev/packages/http

  /* JSON format
  {
  "time": "2017-08-09T14:31:18.3150000Z",
  "asset_id_base": "BTC",
  "asset_id_quote": "USD",
  "rate": 3260.3514321215056208129867667
  }
   */
  Future getCoinData(String selectedCurrency) async {
    await checkAPIkey();

    DateTime now = DateTime.now();
    String isoDate = now.toIso8601String();
    var url = Uri.parse(
        '$coinAPIURL${cryptoList[0]}/$selectedCurrency'); // '?time=$isoDate' +
    var result;
    var client = http.Client();
    //[HTTPHeaders]
    var headers = <String, String>{'X-CoinAPI-Key': _apiKey};

    try {
      var response = await client.get(url, headers: headers);
      //var response = await client.get(url);
      if (response.statusCode == 200) {
        var jsonResponse =
            convert.jsonDecode(response.body) as Map<String, dynamic>;
        //print(jsonResponse['rates'][0]['rate']);
        print(jsonResponse['rate']);
        result = jsonResponse['rate'];
      } else {
        throw 'Request failed with status: ${response.statusCode}.';
      }
    } finally {
      client.close();
    }
    return result;
  }
}
/* HTTP NO-Client
  Future getCoinData() async {
    String requestURL = '$coinAPIURL/BTC/USD?apikey=$apiKey';
    http.Response response = await http.get(requestURL);
    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);
      var lastPrice = decodedData['rate'];
      return lastPrice;
    } else {
      print(response.statusCode);
      throw 'Problem with the get request';
    }
  }
*/

