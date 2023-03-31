import 'package:flutter/material.dart';
import 'package:movieto/utilities/utilities.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(20, 24, 57, 1),
              Color.fromRGBO(25, 27, 65, 1),
              Color.fromRGBO(25, 27, 65, 1),
              Color.fromRGBO(20, 24, 57, 1),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.15, 0.5, 0.6, 1],
          ),
        ),
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(
                  'images/illustrations/movie_collage.png',
                  height: SizeConfig.blockSizeVertical! * 40,
                  width: SizeConfig.blockSizeHorizontal! * 100,
                  fit: BoxFit.cover,
                ),
                Container(
                  width: SizeConfig.blockSizeHorizontal! * 100,
                  height: SizeConfig.blockSizeVertical! * 40,
                  padding: const EdgeInsets.only(bottom: 40),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        purpleColor,
                        purpleColor.withOpacity(0.4),
                        purpleColor.withOpacity(0.4),
                        purpleColor,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: const [0.01, 0.5, 0.8, 1],
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            top: SizeConfig.blockSizeVertical! * 10,
                            bottom: 10),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: pinkColor,
                        ),
                        child: Image.asset(
                          'images/icons/profile_black.png',
                          width: SizeConfig.blockSizeHorizontal! * 10,
                        ),
                      ),
                      Text(
                        globalUserData['name'],
                        style: normalBoldTextWhite(),
                      ),
                      Text(
                        globalUserData['email'],
                        style: normalTextWhite(),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 3,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      child: Text(
                        'Personal Information',
                        style: normalBoldTextBlack(),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        'Name: ${globalUserData['name']}',
                        style: normalTextBlack(),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        'Email: ${globalUserData['email']}',
                        style: normalTextBlack(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: pinkColor,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 3,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: Container(
                  width: SizeConfig.blockSizeHorizontal! * 80,
                  child: Text(
                    'Log out',
                    style: normalBoldTextWhite(),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
