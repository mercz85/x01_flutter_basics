import '../constants.dart';
import '../models/product.dart';
import 'package:flutter/material.dart';

// The code below is for the dummy server, and you should not need to modify it
// in this workshop.

class Server {
  static Product getProductById(String id) {
    return kDummyData[id]!;
  }

  static List<String> getProductList({String? filter}) {
    if (filter == null) return kDummyData.keys.toList();
    final List<String> ids = <String>[];
    for (final Product product in kDummyData.values) {
      if (product.title.toLowerCase().contains(filter.toLowerCase())) {
        ids.add(product.id);
      }
    }
    return ids;
  }
}

final Map<String, Product> kDummyData = {
  '0': const Product(
    id: '0',
    title: 'Explore Pixel phones',
    description: TextSpan(children: <TextSpan>[
      TextSpan(
        text: 'Capture the details.\n',
        style: TextStyle(color: Colors.black),
      ),
      TextSpan(
        text: 'Capture your world.',
        style: TextStyle(color: Colors.blue),
      ),
    ]),
    pictureURL: '$baseAssetURL/pixels.png',
  ),
  '1': const Product(
    id: '1',
    title: 'Nest Audio',
    description: TextSpan(children: <TextSpan>[
      TextSpan(text: 'Amazing sound.\n', style: TextStyle(color: Colors.green)),
      TextSpan(text: 'At your command.', style: TextStyle(color: Colors.black)),
    ]),
    pictureURL: '$baseAssetURL/nest.png',
  ),
  '2': const Product(
    id: '2',
    title: 'Nest Audio Entertainment packages',
    description: TextSpan(children: <TextSpan>[
      TextSpan(
        text: 'Built for music.\n',
        style: TextStyle(color: Colors.orange),
      ),
      TextSpan(
        text: 'Made for you.',
        style: TextStyle(color: Colors.black),
      ),
    ]),
    pictureURL: '$baseAssetURL/nest-audio-packages.png',
  ),
  '3': const Product(
    id: '3',
    title: 'Nest Home Security packages',
    description: TextSpan(children: <TextSpan>[
      TextSpan(text: 'Your home,\n', style: TextStyle(color: Colors.black)),
      TextSpan(text: 'safe and sound.', style: TextStyle(color: Colors.red)),
    ]),
    pictureURL: '$baseAssetURL/nest-home-packages.png',
  ),
};
