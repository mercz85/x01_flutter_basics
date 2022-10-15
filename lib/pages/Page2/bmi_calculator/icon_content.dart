import 'package:flutter/material.dart';

import 'constants.dart';

class IconContent extends StatelessWidget {
  final IconData iconData;
  final String label;

  const IconContent({
    Key? key,
    required this.iconData,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          iconData,
          size: 60,
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          label,
          style: kLabelTextStyle,
        )
      ],
    );
  }
}
