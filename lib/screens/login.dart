import 'package:flutter/material.dart';
import 'package:movieto/utilities/utilities.dart';
import 'package:movieto/screens/home/dashboard.dart';
import 'package:movieto/screens/signup.dart';
import 'package:flutter/services.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> with WidgetsBindingObserver {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool hidePassword = true;
  String? emailText;
  String? passwordText;
  bool signupBTNdisabled = true;
  String? formErrorMessage;

  // Check if all inputs are filled
  checkInputs() async {
    setState(() {
      if (email.text == '') {
        signupBTNdisabled = true;
        formErrorMessage = 'Enter email address';
      } else if (password.text == '') {
        signupBTNdisabled = true;
        formErrorMessage = 'Enter password';
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
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ));
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hi,',
                              style: header6BoldTextWhite(),
                            ),
                            Text(
                              'Welcome Back',
                              style: header6BoldTextWhite(),
                            ),
                          ],
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
                                  'Email',
                                  style: smallTextLightWhite(),
                                ),
                              ),
                              TextField(
                                onChanged: (text) {
                                  setState(() {
                                    emailText = text;
                                  });
                                  checkInputs();
                                },
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  contentPadding:
                                      const EdgeInsets.fromLTRB(20, 10, 10, 10),
                                  hintText: 'Enter email address',
                                  hintStyle: smallTextLightBlack(),
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
                                  style: smallTextLightWhite(),
                                ),
                              ),
                              TextField(
                                onChanged: (text) {
                                  setState(() {
                                    passwordText = text;
                                  });
                                  checkInputs();
                                },
                                keyboardType: TextInputType.text,
                                obscureText: hidePassword,
                                decoration: InputDecoration(
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        hidePassword = !hidePassword;
                                      });
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(right: 20),
                                      child: SizedBox(
                                        width: 1,
                                        child: Image.asset(
                                          'images/icons/hide.png',
                                        ),
                                      ),
                                    ),
                                  ),
                                  contentPadding:
                                      const EdgeInsets.fromLTRB(20, 10, 10, 10),
                                  hintText: 'Enter password',
                                  hintStyle: smallTextLightBlack(),
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
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Signup(),
                              ),
                            );
                          },
                          child: Container(
                            color: Colors.transparent,
                            padding: const EdgeInsets.fromLTRB(5, 10, 0, 10),
                            child: Text(
                              'Create Account',
                              style: smallTextWhite(),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: SizeConfig.blockSizeVertical! * 5,
                        ),
                        child: AnimatedButton(
                          text: 'Log in',
                          link: '/user/login',
                          disabled: signupBTNdisabled,
                          error: formErrorMessage,
                          obj: {
                            "email": email.text,
                            "password": password.text,
                          },
                          req: 'post',
                          callback: (res) async {
                            if (res['isSuccessful'] == true) {
                              setState(() {
                                globalUserData = res['user'];
                              });
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Dashboard(),
                                ),
                              );

                              return showToast(
                                context,
                                'Successful',
                                'Successfully logged in',
                                Colors.green,
                              );
                            } else {
                              return showToast(
                                context,
                                'Error!!!',
                                '${res['error']}',
                                Colors.red,
                              );
                            }
                          },
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
