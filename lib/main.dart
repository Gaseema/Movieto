import 'package:flutter/material.dart';
import 'package:movieto/utilities/utilities.dart';
import 'package:movieto/screens/login.dart';
import 'package:movieto/screens/onboarding/onboarding.dart';
import 'package:overlay_support/overlay_support.dart';

void main() async {
  runApp(
    const OverlaySupport.global(
      child: MaterialApp(
        title: 'GenAfrica',
        debugShowCheckedModeBanner: false,
        home: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  checkFirstSeen() async {
    bool? isFreshInstall = await freshInstall();

    if (isFreshInstall == true) {
      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Onboarding(),
        ),
      );
    } else {
      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Login(),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1000), () {
      checkFirstSeen();
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  'images/launcherIcon.png',
                  width: SizeConfig.blockSizeHorizontal! * 30,
                ),
              ),
            ),
            Text(
              'Loading...',
              style: smallTextLightBlack(),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
