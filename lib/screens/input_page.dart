import 'package:bmi_calculator/calculator_brain.dart';

import 'results_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bmi_calculator/components/reusable_card.dart';
import 'package:bmi_calculator/components/icon_content.dart';
import 'package:bmi_calculator/constants.dart';
import 'package:bmi_calculator/components/bottom_button.dart';
import 'package:bmi_calculator/components/round_icon_button.dart';

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

enum Gender {
  male,
  female,
}
enum Box {
  weight,
  age,
}
enum AddOrSubtract {
  add,
  subtract,
}

class _InputPageState extends State<InputPage> {
  Color femaleCardColor = kInactiveCardColor;
  Color maleCardColor = kInactiveCardColor;
  Gender selectedGender;
  int _height = 160;
  int _weight = 60;
  int _age = 20;

  void updateData({Box b, AddOrSubtract x}) {
    setState(() {
      if (x == AddOrSubtract.add)
        b == Box.weight ? _weight -= 1 : _age -= 1;
      else
        b == Box.weight ? _weight += 1 : _age += 1;
    });
  }

  //updates the value of weight and age

  Expanded returnBox({String t, int n, Box b}) {
    return Expanded(
      child: ReusableCard(
        colour: kInactiveCardColor,
        cardChild: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              t,
              style: kLabelTextStyle,
            ),
            Text(
              n.toString(),
              style: kNumberTextStyle,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RoundIconButton(
                  child: FontAwesomeIcons.minus,
                  onPressed: () {
                    updateData(b: b, x: AddOrSubtract.add);
                  },
                ),
                RoundIconButton(
                  child: FontAwesomeIcons.plus,
                  onPressed: () {
                    setState(() {
                      updateData(b: b, x: AddOrSubtract.subtract);
                    });
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  //Age and Weight Containers

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI CALCULATOR'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ReusableCard(
                    onPress: () {
                      setState(() {
                        selectedGender == Gender.male
                            ? selectedGender = null
                            : selectedGender = Gender.male;
                      });
                    },
                    colour: selectedGender == Gender.male
                        ? kActiveCardColor
                        : kInactiveCardColor,
                    cardChild: IconContent(
                      icon: FontAwesomeIcons.mars,
                      label: 'MALE',
                    ),
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    onPress: () {
                      setState(() {
                        selectedGender == Gender.female
                            ? selectedGender = null
                            : selectedGender = Gender.female;
                      });
                      print('Male button was pressed');
                    },
                    colour: selectedGender == Gender.female
                        ? kActiveCardColor
                        : kInactiveCardColor,
                    cardChild: IconContent(
                      icon: FontAwesomeIcons.venus,
                      label: 'FEMALE',
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: ReusableCard(
              colour: kInactiveCardColor,
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Center(
                    child: Text('HEIGHT', style: kLabelTextStyle),
                  ),
                  Row(
                    textBaseline: TextBaseline.alphabetic,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    children: <Widget>[
                      Text(
                        _height.toString(),
                        style: kNumberTextStyle,
                      ),
                      Text(
                        'cm',
                        style: kLabelTextStyle,
                      )
                    ],
                  ),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                        thumbColor: kPinkColor,
                        activeTrackColor: kPinkColor,
                        overlayColor: kTransparentPinkColor,
                        inactiveTrackColor: kInactiveTextColor,
                        thumbShape:
                            RoundSliderThumbShape(enabledThumbRadius: 15.0),
                        overlayShape:
                            RoundSliderOverlayShape(overlayRadius: 30.0)),
                    child: Slider(
                      max: 220,
                      min: 100,
                      value: _height.toDouble(),
                      onChanged: (double newValue) {
                        setState(() {
                          _height = newValue.toInt();
                        });
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Row(
              children: <Widget>[
                returnBox(t: 'WEIGHT', n: _weight, b: Box.weight),
                returnBox(t: 'AGE', n: _age, b: Box.age),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: BottomButton(
              onTap: () {
                CalculatorBrain calc =
                    CalculatorBrain(height: _height, weight: _weight);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ResultsPage(
                          bmi: calc.calculateBMI(),
                          result: calc.getResult(),
                          feedback: calc.getInterpretation())),
                );
              },
              buttonTitle: 'CALCULATE',
            ),
          )
        ],
      ),
    );
  }
}
