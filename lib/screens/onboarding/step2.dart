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
