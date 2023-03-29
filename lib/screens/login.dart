import 'package:flutter/material.dart';
import 'package:movieto/utilities/utilities.dart';
import 'package:movieto/screens/home/dashboard.dart';
import 'package:movieto/screens/signup.dart';

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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => alertExitModal(context),
      child: Scaffold(
        body: SafeArea(
          child: Container(
            width: SizeConfig.blockSizeHorizontal! * 100,
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
            child: ListView(
              children: [
                Center(
                  child: Image.asset(
                    'images/launcherIcon.png',
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
                        style: header2BoldTextBlack(),
                      ),
                      Text(
                        'Welcome Back',
                        style: header1BoldTextBlack(),
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
                            style: smallTextLightBlack(),
                          ),
                        ),
                        TextField(
                          onChanged: (text) {
                            setState(() {
                              emailText = text;
                            });
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.fromLTRB(20, 10, 10, 10),
                            hintText: 'Enter email address',
                            hintStyle: normalTextBlack(),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.6),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.blue.withOpacity(0.2),
                                width: 2.3,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.blue,
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
                            setState(() {
                              passwordText = text;
                            });
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
                            hintStyle: normalTextBlack(),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.6),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.blue.withOpacity(0.2),
                                width: 2.3,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.blue,
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          color: Colors.transparent,
                          padding: const EdgeInsets.fromLTRB(5, 10, 0, 10),
                          child: Text(
                            'Create Account',
                            style: smallTextBlack(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: SizeConfig.blockSizeVertical! * 5,
                  ),
                  child: AnimatedButton(
                    text: 'Log In',
                    link: null,
                    req: 'post',
                    obj: {'username': emailText, 'password': passwordText},
                    callback: (res) async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Dashboard(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
