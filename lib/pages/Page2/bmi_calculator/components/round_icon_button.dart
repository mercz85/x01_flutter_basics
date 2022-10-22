import 'package:flutter/material.dart';

//[buttonComposition]
class RoundIconButton extends StatelessWidget {
  final IconData iconData;
  final void Function()? onPress;

  const RoundIconButton({
    Key? key,
    required this.iconData,
    this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPress,
      elevation: 6,
      fillColor: const Color(0xFF4C4F5E),
      shape: const CircleBorder(),
      constraints: const BoxConstraints(minHeight: 40, minWidth: 40),
      child: Icon(iconData),
    );
  }
}
