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
      body: Column(
        children: [
          Container(
            width: SizeConfig.blockSizeHorizontal! * 100,
            padding: const EdgeInsets.only(bottom: 40),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.red,
                  Colors.blue,
                ],
              ),
              image: DecorationImage(
                image: AssetImage("images/test.jpeg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(
                      top: SizeConfig.blockSizeVertical! * 10, bottom: 10),
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
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
                      'Email: ${globalUserData['name']}',
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
              color: Colors.red,
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
    );
  }
}
