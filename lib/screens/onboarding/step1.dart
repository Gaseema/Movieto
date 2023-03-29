import 'package:flutter/material.dart';
import 'package:movieto/utilities/utilities.dart';

class StepOne extends StatefulWidget {
  const StepOne({Key? key}) : super(key: key);

  @override
  StepOneState createState() => StepOneState();
}

class StepOneState extends State<StepOne> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
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
      ),
    );
  }
}
