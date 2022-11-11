import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  //Key is used to track the state of a widget
  //We don´t need it in this case, so we can delete this constructor
/*  const RoundedButton({
    Key key,
  }) : super(key: key);*/
  RoundedButton(
      {required this.colour, required this.text, required this.onPressed});
  //StatelessWidget is Immutable (immutable, destroyed when no longer needed)
  final Color colour;
  final String text;
  final VoidCallback onPressed; //Funcion onPressed
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        color: colour,
        borderRadius: BorderRadius.circular(30.0),
        elevation: 5.0,
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

//ejemplo
/*class ReusableCard extends StatelessWidget {
  ReusableCard({@required this.colour, this.cardChild, this.onPress});
  final Color colour;
  final Widget cardChild;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (onPress),
      child: Container(
        child: cardChild,
        margin: EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: colour,
        ),
      ),
    );
  }
}*/
