import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:movieto/utilities/utilities.dart';
import 'package:movieto/screens/signup.dart';
import 'package:movieto/screens/login.dart';
import 'package:movieto/screens/onboarding/step1.dart';
import 'package:movieto/screens/onboarding/step2.dart';
import 'package:movieto/screens/onboarding/step3.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  OnboardingState createState() => OnboardingState();
}

class OnboardingState extends State<Onboarding> with WidgetsBindingObserver {
  PageController controller = PageController();
  List<Widget> onboardingPages = [
    const StepOne(),
    const StepTwo(),
    const StepThree(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: Column(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.bottomLeft,
                decoration: const BoxDecoration(),
                child: PageView(
                  controller: controller,
                  children: onboardingPages,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: 50,
              ),
              child: SmoothPageIndicator(
                controller: controller,
                count: onboardingPages.length,
                effect: ExpandingDotsEffect(
                  dotHeight: 10,
                  dotWidth: 10,
                  dotColor: Colors.grey,
                  activeDotColor: pinkColor,
                ),
              ),
            ),
            Wrap(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Signup(),
                      ),
                    );
                  },
                  child: Container(
                    width: SizeConfig.blockSizeHorizontal! * 90,
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: pinkColor,
                    ),
                    child: Text(
                      'Join Now',
                      style: normalTextWhite(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Login(),
                      ),
                    );
                  },
                  child: Container(
                    color: Colors.transparent,
                    margin: EdgeInsets.only(
                      bottom: SizeConfig.blockSizeVertical! * 1,
                      top: SizeConfig.blockSizeVertical! * 2,
                    ),
                    padding: EdgeInsets.only(
                      bottom: SizeConfig.blockSizeVertical! * 2,
                      top: SizeConfig.blockSizeVertical! * 2,
                    ),
                    width: SizeConfig.blockSizeHorizontal! * 90,
                    child: Text(
                      'Already a member? Log in',
                      style: smallBoldTextBlack(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
