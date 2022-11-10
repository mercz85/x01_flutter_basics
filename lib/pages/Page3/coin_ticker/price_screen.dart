import 'dart:io' show Platform; //[Platform]
import 'package:flutter/cupertino.dart'; //[Cupertino]
import 'package:flutter/material.dart';
import 'package:x01_flutter_basics/pages/Page3/coin_ticker/coin_data.dart';

class PriceScreen extends StatefulWidget {
  PriceScreen({Key? key}) : super(key: key);

  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = currenciesList[4];
  String cryptoValue = '?';
  String cryptoCurrency = cryptoList[0];
  Map<String, String> cryptoValues = {};
  List<CryptoCard> cards = [];

  //[async]
  void getCoinExchange(String selectedCurrency) async {
    /* For 1 single exchange card

    var cryptoVal = await CoinData().getCoinData(selectedCurrency);

    setState(() {
      cards = [
        CryptoCard(
            cryptoValue: cryptoVal.toStringAsFixed(0),
            selectedCurrency: selectedCurrency,
            cryptoCurrency: 'BTC'),
      ];
    });

    */

    cryptoValues = await CoinData().getCoinsData(selectedCurrency);

    setState(() {
      cards = [];
      cryptoValues.forEach((key, val) {
        cards.add(CryptoCard(
            cryptoValue: val,
            selectedCurrency: selectedCurrency,
            cryptoCurrency: key));
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getCoinExchange(selectedCurrency);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          flex: 4,
          child: Column(
            children: cards,
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            width: double.infinity,
            color: Colors.lightBlueAccent,
            child: Center(
              child: Platform.isIOS
                  ? getIOSPicker()
                  : getDropdownButton(), //[Platform]
            ),
          ),
        )
      ],
    );
  }

  DropdownButton<String> getDropdownButton() {
    List<DropdownMenuItem<String>> currencyList = [];

    for (String currency in currenciesList) {
      currencyList.add(
        DropdownMenuItem(
          value: currency,
          child: Text(
            currency,
          ),
        ),
      );
    }

    return DropdownButton(
      value: selectedCurrency,
      items: currencyList,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value.toString();
          getCoinExchange(selectedCurrency);
        });
      },
    );
  }

//[Cupertino]
  CupertinoPicker getIOSPicker() {
    List<Text> currencyList = [];

    for (var i = 0; i < currenciesList.length; i++) {
      currencyList.add(Text(currenciesList[i]));
    }

    return CupertinoPicker(
        itemExtent: 32,
        onSelectedItemChanged: (selectedIndex) {
          setState(() {
            selectedCurrency = currencyList[selectedIndex].data.toString();
            getCoinExchange(selectedCurrency);
          });
        },
        children: currencyList);
  }
}

class CryptoCard extends StatelessWidget {
  final String cryptoValue;
  final String selectedCurrency;
  final String cryptoCurrency;

  const CryptoCard(
      {super.key,
      required this.cryptoValue,
      required this.selectedCurrency,
      required this.cryptoCurrency});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: Colors.lightBlueAccent,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            '1 $cryptoCurrency = $cryptoValue $selectedCurrency',
            style: const TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
