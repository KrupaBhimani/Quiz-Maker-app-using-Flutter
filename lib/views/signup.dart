import 'package:flutter/material.dart';
import 'package:quiz_maker/helper/functions.dart';
import 'package:quiz_maker/services/auth.dart';
import 'package:quiz_maker/views/home.dart';
import 'package:quiz_maker/views/signin.dart';
import 'package:quiz_maker/widgets/widgets.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  String name, email, password;

  AuthService authService = new AuthService();
  bool _isLoading = false;

  signUp() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });

      await authService
          .signUpWithEmailAndPassword(email, password)
          .then((value) {
        if (value != null) {
          setState(() {
            _isLoading = true;
          });
          //HelperFunctions.saveUserLoggedInDetails(isLoggedin: true);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Home()));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: appBar(context),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          brightness: Brightness.light,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _isLoading
                  ? Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Form(
                      key: _formKey,
                      child: Container(
                        height: 800,
                        margin: EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          children: [
                            //Spacer(),
                            SizedBox(
                              height: 400,
                            ),
                            TextFormField(
                              validator: (val) {
                                return val.isEmpty ? "Enter Name" : null;
                              },
                              decoration: InputDecoration(hintText: "Name"),
                              onChanged: (val) {
                                name = val;
                              },
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            TextFormField(
                              validator: (val) {
                                return val.isEmpty ? "Enter Emailid" : null;
                              },
                              decoration: InputDecoration(hintText: "Email"),
                              onChanged: (val) {
                                email = val;
                              },
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            TextFormField(
                              obscureText: true,
                              validator: (val) {
                                return val.isEmpty ? "Enter Password" : null;
                              },
                              decoration: InputDecoration(hintText: "Password"),
                              onChanged: (val) {
                                password = val;
                              },
                            ),
                            SizedBox(
                              height: 24,
                            ),
                            GestureDetector(
                              onTap: () {
                                signUp();
                              },
                              child: blueButton(
                                  context: context,
                                  label: "Sign Up"
                              ),
                            ),
                            SizedBox(
                              height: 18,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Already have an account? ",
                                  style: TextStyle(fontSize: 15.5),
                                ),
                                GestureDetector(
                                    onTap: () {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => SignIn()));
                                    },
                                    child: Text(
                                      "Sign In ",
                                      style: TextStyle(
                                          fontSize: 15.5,
                                          decoration: TextDecoration.underline),
                                    )),
                              ],
                            ),

                            SizedBox(
                              height: 80,
                            )
                          ],
                        ),
                      ),
                    ),
            ],
          ),
        ));
  }
}
