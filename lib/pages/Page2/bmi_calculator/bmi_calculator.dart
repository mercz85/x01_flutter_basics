import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:x01_flutter_basics/pages/Page2/bmi_calculator/reusable_card.dart';

import 'icon_content.dart';

const double bottomContainerHeight = 54;
const Color activeCardColor = Color(0xFF1D1E33);
const Color bottomButtonColor = Color(0xFFEB1555);

class BMICalculatorPage extends StatefulWidget {
  const BMICalculatorPage({Key? key}) : super(key: key);

  @override
  State<BMICalculatorPage> createState() => _BMICalculatorPageState();
}

class _BMICalculatorPageState extends State<BMICalculatorPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                ReusableCard(
                  color: activeCardColor,
                  cardChild: IconContent(
                    //[icons]
                    iconData: FontAwesomeIcons.mars,
                    label: 'MALE',
                  ),
                ),
                ReusableCard(
                  color: activeCardColor,
                  cardChild: IconContent(
                    iconData: FontAwesomeIcons.venus,
                    label: 'FEMALE',
                  ),
                ),
              ],
            ),
          ),
          ReusableCard(
            color: activeCardColor,
          ),
          Expanded(
            child: Row(
              children: [
                ReusableCard(
                  color: activeCardColor,
                ),
                ReusableCard(
                  color: activeCardColor,
                ),
              ],
            ),
          ),
          Container(
            color: bottomButtonColor,
            height: bottomContainerHeight,
            width: double.infinity,
            margin: EdgeInsets.only(top: 10),
          ),
        ],
      ),
    );
  }
}
