import 'package:flutter/material.dart';
import 'package:movieto/utilities/utilities.dart';

class StepTwo extends StatefulWidget {
  const StepTwo({Key? key}) : super(key: key);

  @override
  StepTwoState createState() => StepTwoState();
}

class StepTwoState extends State<StepTwo> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        width: SizeConfig.blockSizeHorizontal! * 100,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical! * 10),
              child: Image.asset(
                'images/logo_pink.png',
                width: SizeConfig.blockSizeHorizontal! * 15,
              ),
            ),
            Expanded(
              child: Image.asset(
                'images/illustrations/step_two.png',
                width: SizeConfig.blockSizeHorizontal! * 70,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 50),
              child: Text(
                'TV Show Discovery Made Easy with MovieTo',
                style: headerBoldTextBlack(),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
