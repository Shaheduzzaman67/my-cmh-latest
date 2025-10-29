import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_cmh_updated/common/constants.dart';
import 'package:my_cmh_updated/ui/bmi/Components/BottomContainer_Button.dart';
import 'package:my_cmh_updated/ui/bmi/constants.dart';
import '../Components/Reusable_Bg.dart';

class ResultPage extends StatelessWidget {
  final String? resultText;
  final String? bmi;
  final String? advise;
  final Color? textColor;

  ResultPage({this.textColor, this.resultText, this.bmi, this.advise});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'BMI Calculator',
          style: TextStyle(
            fontFamily: FONT_NAME,
            fontSize: 18.0,
            color: Colors.black,
            fontWeight: FontWeight.normal,
          ),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(15.0),
            child: Text('Your Result', style: ktitleTextStyle),
          ),
          SizedBox(height: 20),
          ReusableBg(
            colour: kactiveCardColor,
            cardChild: Padding(
              padding: const EdgeInsets.only(
                left: 15,
                right: 15,
                top: 20,
                bottom: 20,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(bmi!, style: kBMITextStyle),
                  Text(
                    resultText!,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 27.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 25),
                  Text('Normal BMI range', style: klabelTextStyle),
                  Text('18.5 - 25 kg/m2', style: kBodyTextStyle),
                  Text(
                    advise!,
                    textAlign: TextAlign.center,
                    style: kBodyTextStyle,
                  ),
                  SizedBox(height: 15.0),
                ],
              ),
            ),
          ),
          Spacer(),
          BottomContainer(
            text: 'RE-CALCULATE',
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
