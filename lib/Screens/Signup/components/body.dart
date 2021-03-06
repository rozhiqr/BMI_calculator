import 'package:BMIcalculator/Screens/profile.dart';
import 'package:BMIcalculator/helper/helperFunction.dart';
import 'package:BMIcalculator/services/database.dart';
import 'package:flutter/material.dart';
import 'package:BMIcalculator/Screens/Login/login_screen.dart';
import 'package:BMIcalculator/Screens/Signup/components/background.dart';
import 'package:BMIcalculator/Screens/Signup/components/or_divider.dart';
import 'package:BMIcalculator/Screens/Signup/components/social_icon.dart';
import 'package:BMIcalculator/components/already_have_an_account_acheck.dart';
import 'package:BMIcalculator/components/rounded_button.dart';
import 'package:BMIcalculator/components/rounded_input_field.dart';
import 'package:BMIcalculator/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _auth = FirebaseAuth.instance;
  DatabaseMethods databaseMethods = new DatabaseMethods();

  bool showSpinner = false;
  String email;
  String password;
  String username;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "SIGNUP",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.03),
              SvgPicture.asset(
                "assets/icons/signup.svg",
                height: size.height * 0.35,
              ),
              RoundedInputField(
                hintText: "Your Username",
                onChanged: (value) {
                  username = value;
                },
              ),
              RoundedInputField(
                hintText: "Your Email",
                onChanged: (value) {
                  email = value;
                },
              ),
              RoundedPasswordField(
                onChanged: (value) {
                  password = value;
                },
              ),
              RoundedButton(
                text: "SIGNUP",
                press: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    final newUser = await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                    var firebaseUser = FirebaseAuth.instance.currentUser;

                    if (newUser != null) {
                      Map<String, String> userInfoMap = {
                        "name": username,
                        "email": email
                      };
                      HelperFunctions.saveUserNameSharedPreference(username);
                      HelperFunctions.saveUserEmailSharedPreference(email);
                      databaseMethods.uploadUserInfo(
                          userInfoMap, firebaseUser.uid);
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return Profile();
                      }));
                    }

                    setState(() {
                      showSpinner = false;
                    });
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'email-already-in-use') {
                      setState(() {
                        showSpinner = false;
                      });
                      AlertDialog alert = AlertDialog(
                        title: Text('Error'),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('ok'))
                        ],
                        content: Text('this email is already in use'),
                      );
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          });
                    }

                    print(e);
                  }
                },
              ),
              SizedBox(height: size.height * 0.03),
              AlreadyHaveAnAccountCheck(
                login: false,
                press: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return LoginScreen();
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
