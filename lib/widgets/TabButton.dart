import 'package:flutter/material.dart';

//TODO Animated killing effect
//min 6:20 https://www.youtube.com/watch?v=mhcgTYzZPv0
//[customTabButton]
class TabButton extends StatelessWidget {
  //const TabButton({Key? key}) : super(key: key);
  final String? text;
  final int? selectedPage;
  final int? pageNumber;
  final void Function()? onPressed;

  TabButton(
      {@required this.text,
      @required this.selectedPage,
      @required this.pageNumber,
      @required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: selectedPage == pageNumber ? Colors.blue : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 20,
        ),
        child: Text(
          text!,
          style: TextStyle(
              color: selectedPage == pageNumber ? Colors.white : Colors.white),
        ),
      ),
    );
  }
}
