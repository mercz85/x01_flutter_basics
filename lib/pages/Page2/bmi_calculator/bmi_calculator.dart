// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:x01_flutter_basics/pages/Page2/bmi_calculator/reusable_card.dart';

import 'constants.dart';
import 'icon_content.dart';
import 'round_icon_button.dart';

enum Gender { none, male, female }

enum BMIView { input, result }

class BMICalculatorPage extends StatefulWidget {
  const BMICalculatorPage({Key? key}) : super(key: key);

  @override
  State<BMICalculatorPage> createState() => _BMICalculatorPageState();
}

class _BMICalculatorPageState extends State<BMICalculatorPage> {
  Gender selectedGender = Gender.none;
  BMIView bmiView = BMIView.input;

  int height = 150;
  int weight = 60;
  int age = 37;

  void changeView(BMIView newView) {
    setState(() {
      bmiView = newView;
    });
  }

  @override
  Widget build(BuildContext context) {
    return bmiView == BMIView.input ? inputView(context) : resultView(context);
  }

  //[extractMethod] to see different 'views' in the same Tab
  Column inputView(BuildContext context) {
    return Column(
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
                cardChild: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'WEIGHT',
                      style: kLabelTextStyle,
                    ),
                    Text(
                      weight.toString(),
                      style: kNumberTextStyle,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RoundIconButton(
                          iconData: Icons.remove,
                          onPress: () {
                            setState(() {
                              weight--;
                            });
                          },
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        RoundIconButton(
                          iconData: Icons.add,
                          onPress: () {
                            setState(() {
                              weight++;
                            });
                          },
                        )
                      ],
                    )
                  ],
                ),
              ),
              ReusableCard(
                color: kActiveCardColor,
                cardChild: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'AGE',
                      style: kLabelTextStyle,
                    ),
                    Text(
                      age.toString(),
                      style: kNumberTextStyle,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RoundIconButton(
                          iconData: Icons.remove,
                          onPress: () {
                            setState(() {
                              age--;
                            });
                          },
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        RoundIconButton(
                          iconData: Icons.add,
                          onPress: () {
                            setState(() {
                              age++;
                            });
                          },
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: (() {
            changeView(BMIView.result);
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) {
            //       return ResultsPage();
            //     },
            //   ),
            // );
          }),
          child: Container(
            alignment: AlignmentGeometry.lerp(Alignment.center, null, 0),
            color: kBottomButtonColor,
            height: kBottomContainerHeight,
            width: double.infinity,
            margin: const EdgeInsets.only(top: 10),
            child: const Text('CALCULATE'),
          ),
        ),
      ],
    );
  }

  Column resultView(BuildContext context) {
    return Column(
      children: [
        const Text(
          'RESULTS',
          style: TextStyle(fontSize: 20),
        ),
        const Expanded(child: SizedBox()),
        GestureDetector(
          onTap: (() {
            changeView(BMIView.input);
            //Navigator.pop(context);
          }),
          child: Container(
            alignment: AlignmentGeometry.lerp(Alignment.center, null, 0),
            color: kBottomButtonColor,
            height: kBottomContainerHeight,
            width: double.infinity,
            margin: const EdgeInsets.only(top: 10),
            child: const Text('INPUT'),
          ),
        ),
      ],
    );
  }
}
