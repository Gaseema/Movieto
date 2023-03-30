import 'package:flutter/material.dart';
import 'package:movieto/utilities/utilities.dart';
import 'package:movieto/screens/login.dart';
import 'package:movieto/utilities/utilities.dart';
import 'package:movieto/screens/home/dashboard.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  SignupState createState() => SignupState();
}

class SignupState extends State<Signup> with WidgetsBindingObserver {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  String selectedCountry = '254';
  bool showPassword = true;
  bool showConfirmPassword = true;
  bool signupBTNdisabled = true;
  String? formErrorMessage;

  returnPhoneNumber(String phoneNo) {
    if (phoneNo.isNotEmpty) {
      if (phoneNo[0] == '0') {
        return selectedCountry + phoneNo.substring(1);
      }
      return selectedCountry + phoneNo;
    }
  }

  // Check if all inputs are filled
  checkInputs() async {
    setState(() {
      if (username.text.isEmpty) {
        signupBTNdisabled = true;
        formErrorMessage = 'Enter first name';
      } else if (email.text == '') {
        signupBTNdisabled = true;
        formErrorMessage = 'Enter email address';
      } else if (password.text == '') {
        signupBTNdisabled = true;
        formErrorMessage = 'Enter password';
      } else if (password.text.length < 4) {
        signupBTNdisabled = true;
        formErrorMessage = 'Password must be at least 4 characters';
      } else if (password.text != confirmPassword.text) {
        signupBTNdisabled = true;
        formErrorMessage = 'Passwords do not match';
      } else {
        signupBTNdisabled = false;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    checkInputs();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => alertExitModal(context),
      child: Scaffold(
        body: Container(
          width: SizeConfig.blockSizeHorizontal! * 100,
          child: Stack(
            children: [
              Image.asset(
                'images/illustrations/movie_collage.png',
                width: SizeConfig.blockSizeHorizontal! * 100,
                height: SizeConfig.blockSizeVertical! * 100,
                fit: BoxFit.cover,
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.black.withOpacity(0.4),
                      Colors.black.withOpacity(0.4)
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 20,
                child: Container(
                  width: SizeConfig.blockSizeHorizontal! * 90,
                  height: SizeConfig.blockSizeVertical! * 100,
                  child: ListView(
                    children: [
                      Center(
                        child: Image.asset(
                          'images/logo_white.png',
                          width: SizeConfig.blockSizeHorizontal! * 30,
                          alignment: Alignment.center,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: SizeConfig.blockSizeVertical! * 3,
                        ),
                        width: SizeConfig.blockSizeHorizontal! * 100,
                        child: Text(
                          'Sign Up',
                          style: header2BoldTextWhite(),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: SizeConfig.blockSizeVertical! * 3,
                        ),
                        child: Container(
                          margin: const EdgeInsets.only(left: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(
                                  bottom: 10,
                                  left: 5,
                                ),
                                child: Text(
                                  'Enter your name',
                                  style: smallTextLightBlack(),
                                ),
                              ),
                              TextField(
                                onChanged: (text) {
                                  checkInputs();
                                },
                                style: normalTextBlack(),
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                  contentPadding:
                                      const EdgeInsets.fromLTRB(20, 10, 10, 10),
                                  hintText: 'Enter your name',
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: pinkColor.withOpacity(0.2),
                                      width: 2.3,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: pinkColor,
                                      width: 2.3,
                                    ),
                                  ),
                                ),
                                controller: username,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: SizeConfig.blockSizeVertical! * 3,
                        ),
                        child: Container(
                          margin: const EdgeInsets.only(left: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(
                                  bottom: 10,
                                  left: 5,
                                ),
                                child: Text(
                                  'Email Address',
                                  style: smallTextLightBlack(),
                                ),
                              ),
                              TextField(
                                onChanged: (text) {
                                  checkInputs();
                                },
                                style: normalTextBlack(),
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  contentPadding:
                                      const EdgeInsets.fromLTRB(20, 10, 10, 10),
                                  hintText: 'Email Address',
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: pinkColor.withOpacity(0.2),
                                      width: 2.3,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: pinkColor,
                                      width: 2.3,
                                    ),
                                  ),
                                ),
                                controller: email,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: SizeConfig.blockSizeVertical! * 3,
                        ),
                        child: Container(
                          margin: const EdgeInsets.only(left: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(
                                  bottom: 10,
                                  left: 5,
                                ),
                                child: Text(
                                  'Password',
                                  style: smallTextLightBlack(),
                                ),
                              ),
                              TextField(
                                onChanged: (text) {
                                  checkInputs();
                                },
                                style: normalTextBlack(),
                                keyboardType: TextInputType.text,
                                obscureText: showPassword,
                                decoration: InputDecoration(
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        showPassword = !showPassword;
                                      });
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(right: 20),
                                      child: Container(
                                        width: 1,
                                        child: Image.asset(
                                          'images/icons/hide.png',
                                        ),
                                      ),
                                    ),
                                  ),
                                  contentPadding:
                                      const EdgeInsets.fromLTRB(20, 10, 10, 10),
                                  hintText: 'Enter Password',
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: pinkColor.withOpacity(0.2),
                                      width: 2.3,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: pinkColor,
                                      width: 2.3,
                                    ),
                                  ),
                                ),
                                controller: password,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: SizeConfig.blockSizeVertical! * 3,
                        ),
                        child: Container(
                          margin: const EdgeInsets.only(left: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(
                                  bottom: 10,
                                  left: 5,
                                ),
                                child: Text(
                                  'Confirm Password',
                                  style: smallTextLightBlack(),
                                ),
                              ),
                              TextField(
                                onChanged: (text) {
                                  checkInputs();
                                },
                                style: normalTextBlack(),
                                keyboardType: TextInputType.text,
                                obscureText: showConfirmPassword,
                                decoration: InputDecoration(
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        showConfirmPassword =
                                            !showConfirmPassword;
                                      });
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(right: 20),
                                      child: Container(
                                        width: 1,
                                        child: Image.asset(
                                          'images/icons/hide.png',
                                        ),
                                      ),
                                    ),
                                  ),
                                  contentPadding:
                                      const EdgeInsets.fromLTRB(20, 10, 10, 10),
                                  hintText: 'Confirm Password',
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: pinkColor.withOpacity(0.2),
                                      width: 2.3,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: pinkColor,
                                      width: 2.3,
                                    ),
                                  ),
                                ),
                                controller: confirmPassword,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: SizeConfig.blockSizeVertical! * 5,
                        ),
                        child: AnimatedButton(
                          text: 'Sign Up',
                          link: '/user/signup',
                          disabled: signupBTNdisabled,
                          error: formErrorMessage,
                          obj: {
                            "username": username.text,
                            "email": email.text,
                            "password": password.text,
                          },
                          req: 'post',
                          callback: (res) async {
                            if (res['isSuccessful'] == true) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Dashboard(),
                                ),
                              );
                              return showToast(
                                context,
                                'Successful',
                                'Successfully signed up',
                                Colors.green,
                              );
                            } else {
                              return showToast(
                                context,
                                'Error!!!',
                                '${res['error']}',
                                pinkColor,
                              );
                            }
                          },
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
                          margin: EdgeInsets.only(
                            top: SizeConfig.blockSizeVertical! * 3,
                            bottom: SizeConfig.blockSizeVertical! * 3,
                          ),
                          child: Container(
                            color: Colors.transparent,
                            padding: const EdgeInsets.fromLTRB(0, 10, 5, 10),
                            child: Text(
                              'Have an account? Log in.',
                              style: smallTextWhite(),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
