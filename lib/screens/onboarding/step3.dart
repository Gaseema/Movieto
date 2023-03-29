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
      body: Column(
        children: [
          Expanded(
            child: Image.asset('images/genafrica.png'),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 50),
            child: Text(
              'We help you grow your investment',
              style: headerBoldTextBlack(),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
