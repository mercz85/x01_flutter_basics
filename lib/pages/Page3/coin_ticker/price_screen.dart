import 'package:flutter/material.dart';
import 'package:x01_flutter_basics/pages/Page3/coin_ticker/coin_data.dart';

class PriceScreen extends StatefulWidget {
  PriceScreen({Key? key}) : super(key: key);

  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';

  List<DropdownMenuItem> getDropDownItems() {
    List<DropdownMenuItem<String>> currencyList = [];
    // for (var i = 0; i < currenciesList.length; i++) {
    //   currencyList.add(
    //     DropdownMenuItem(
    //       value: currenciesList[i],
    //       child: Text(
    //         currenciesList[i],
    //       ),
    //     ),
    //   );
    // }

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

    return currencyList;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            flex: 4,
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Card(
                    margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: Colors.lightBlueAccent,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        '1 BTC = ? USD',
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              width: double.infinity,
              color: Colors.lightBlueAccent,
              child: Center(
                child: DropdownButton(
                  value: selectedCurrency,
                  items: getDropDownItems(),
                  onChanged: (value) {
                    setState(() {
                      selectedCurrency = value;
                    });
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
