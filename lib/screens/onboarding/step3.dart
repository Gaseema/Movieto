import 'package:flutter/material.dart';
import 'package:movieto/utilities/utilities.dart';

class StepThree extends StatefulWidget {
  const StepThree({Key? key}) : super(key: key);

  @override
  StepThreeState createState() => StepThreeState();
}

class StepThreeState extends State<StepThree> with WidgetsBindingObserver {
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
                'images/illustrations/step_three.png',
                width: SizeConfig.blockSizeHorizontal! * 70,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 50),
              child: Text(
                'Track & Discover Your Favorite Shows with MovieTo',
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
