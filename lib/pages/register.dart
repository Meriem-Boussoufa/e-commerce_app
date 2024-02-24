import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  String? gender;

  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          Image.asset(
            'assets/images/back.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 150),
            child: Container(
              alignment: Alignment.topCenter,
              child: Image.asset(
                'assets/images/logo.png',
                width: 150,
                height: 150,
              ),
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.4),
            width: double.infinity,
            height: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 300.0),
            child: Center(
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white.withOpacity(0.8),
                          elevation: 0.0,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                hintText: "Full Name",
                                icon: Icon(Icons.person_outline),
                              ),
                              controller: name,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "The name field cannot be empty";
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white.withOpacity(0.8),
                          elevation: 0.0,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                hintText: "Email",
                                icon: Icon(Icons.email),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              controller: email,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  String pattern =
                                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
                                  RegExp regex = RegExp(pattern);
                                  if (!regex.hasMatch(value)) {
                                    return 'Please make sure your email is valid';
                                  } else {
                                    return null;
                                  }
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white.withOpacity(0.8),
                          elevation: 0.0,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                hintText: "Password",
                                icon: Icon(Icons.lock_outline),
                              ),
                              controller: password,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "The password field cannot be emepty";
                                } else if (value.length < 6) {
                                  return "The Password has to be at least 6 characters long";
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white.withOpacity(0.8),
                          elevation: 0.0,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                hintText: "Confirm Password",
                                icon: Icon(Icons.lock_outline),
                              ),
                              controller: confirmPassword,
                              validator: (value) {
                                return null;
                              },
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Material(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.blue,
                            elevation: 0.0,
                            child: MaterialButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              minWidth: MediaQuery.of(context).size.width,
                              child: const Text(
                                "Sign Up",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            )),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Forgot password",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  )),
            ),
          ),
          Visibility(
              visible: loading,
              child: Container(
                alignment: Alignment.center,
                color: Colors.white.withOpacity(0.7),
                child: const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                ),
              ))
        ]),
      ),
    );
  }
}
