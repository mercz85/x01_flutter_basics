import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:x01_flutter_basics/pages/Page2/bmi_calculator/reusable_card.dart';

import 'constants.dart';
import 'icon_content.dart';

enum Gender { none, male, female }

class BMICalculatorPage extends StatefulWidget {
  const BMICalculatorPage({Key? key}) : super(key: key);

  @override
  State<BMICalculatorPage> createState() => _BMICalculatorPageState();
}

class _BMICalculatorPageState extends State<BMICalculatorPage> {
  Gender selectedGender = Gender.none;
  int height = 150;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                ReusableCard(
                  onPress: () {
                    setState(() {
                      selectedGender = Gender.male;
                    });
                  },
                  color: selectedGender == Gender.male
                      ? kActiveCardColor
                      : kInactiveCardColor,
                  cardChild: IconContent(
                    //[icons]
                    iconData: FontAwesomeIcons.mars,
                    label: 'MALE',
                  ),
                ),
                ReusableCard(
                  onPress: () {
                    // changeGender(Gender.female);
                    setState(() {
                      selectedGender = Gender.female;
                    });
                  },
                  color: selectedGender == Gender.female
                      ? kActiveCardColor
                      : kInactiveCardColor,
                  cardChild: IconContent(
                    iconData: FontAwesomeIcons.venus,
                    label: 'FEMALE',
                  ),
                ),
              ],
            ),
          ),
          ReusableCard(
            color: kActiveCardColor,
            cardChild: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'HEIGHT',
                  style: kLabelTextStyle,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment:
                      CrossAxisAlignment.baseline, //[rowBaselinAlignText]
                  textBaseline: TextBaseline.alphabetic, //[rowBaselinAlignText]
                  children: [
                    Text(
                      height.toString(),
                      style: kNumberTextStyle,
                    ),
                    Text(
                      ' cm',
                      style: kLabelTextStyle,
                    ),
                  ],
                ),
                //[sliderTheme]
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: Colors.white,
                    inactiveTrackColor: Color(0xFF8D8E98),
                    thumbColor: Color(0xFFEB1555),
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10),
                    overlayColor: Color(0x29EB1555),
                    overlayShape: RoundSliderOverlayShape(overlayRadius: 20),
                    trackHeight: 2,
                  ),
                  //[slider]
                  child: Slider(
                      min: 120,
                      max: 220,
                      value: height.toDouble(),
                      onChanged: (newHeight) {
                        setState(() {
                          height = newHeight.round(); //[doubleToInt]
                        });
                      }),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                ReusableCard(
                  color: kActiveCardColor,
                ),
                ReusableCard(
                  color: kActiveCardColor,
                ),
              ],
            ),
          ),
          Container(
            color: kBottomButtonColor,
            height: kBottomContainerHeight,
            width: double.infinity,
            margin: EdgeInsets.only(top: 10),
          ),
        ],
      ),
    );
  }
}
