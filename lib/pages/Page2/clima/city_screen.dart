import 'package:flutter/material.dart';

const kInputTextDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  icon: Icon(Icons.location_city, color: Colors.white),
  hintText: 'Enter city name',
  hintStyle: TextStyle(color: Colors.grey),
  border: OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.all(
      Radius.circular(4),
    ),
  ),
);

class CityScreen extends StatefulWidget {
  CityScreen({Key? key}) : super(key: key);

  @override
  State<CityScreen> createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  String cityName = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('City Screen'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/clima/city_background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        //Expand Container to fit screen
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsets.all(20.0),
                child: TextField(
                  onChanged: (value) {
                    cityName = value;
                  },
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  decoration: kInputTextDecoration,
                ),
              ),
              TextButton(
                onPressed: () {
                  //[passDataNavigator] pass back cityName
                  Navigator.pop(context, cityName);
                },
                child: const Text(
                  'Get weather',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
