import 'dart:developer';

import 'package:e_commerce_app/db/users_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'home.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final UserServices _userServices = UserServices();

  final _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  String? gender;
  String? groupValue = "";

  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  bool loading = false;

  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 800,
              child: Image.asset(
                'assets/images/back.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Container(
              color: Colors.black.withOpacity(0.3),
              width: double.infinity,
              height: double.infinity,
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 110),
                    child: Container(
                      alignment: Alignment.topCenter,
                      child: Image.asset(
                        'assets/images/logo.png',
                        width: 180,
                        height: 180,
                      ),
                    ),
                  ),
                  Center(
                      child: Form(
                    key: _formKey,
                    child: Column(children: [
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
                                prefixIcon: Icon(Icons.person_outline),
                                border: InputBorder.none,
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
                        child: Container(
                          color: Colors.white.withOpacity(0.3),
                          child: Row(
                            children: [
                              Expanded(
                                child: ListTile(
                                  title: const Text(
                                    "Male",
                                    style: TextStyle(color: Colors.white),
                                    textAlign: TextAlign.end,
                                  ),
                                  trailing: Radio(
                                      activeColor: Colors.red,
                                      value: "male",
                                      groupValue: groupValue,
                                      onChanged: (e) {
                                        valueChanged(e);
                                      }),
                                ),
                              ),
                              Expanded(
                                child: ListTile(
                                  title: const Text(
                                    "Female",
                                    style: TextStyle(color: Colors.white),
                                    textAlign: TextAlign.end,
                                  ),
                                  trailing: Radio(
                                      activeColor: Colors.red,
                                      value: "female",
                                      groupValue: groupValue,
                                      onChanged: (e) {
                                        valueChanged(e);
                                      }),
                                ),
                              ),
                            ],
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
                                prefixIcon: Icon(Icons.email),
                                border: InputBorder.none,
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
                              decoration: InputDecoration(
                                hintText: "Password",
                                prefixIcon: const Icon(Icons.lock_outline),
                                suffixIcon: hidePassword
                                    ? IconButton(
                                        icon: const Icon(Icons.visibility_off),
                                        onPressed: () {
                                          setState(() {
                                            hidePassword = false;
                                          });
                                        },
                                      )
                                    : IconButton(
                                        icon: const Icon(Icons.visibility),
                                        onPressed: () {
                                          setState(() {
                                            hidePassword = true;
                                          });
                                        },
                                      ),
                                border: InputBorder.none,
                              ),
                              controller: password,
                              obscureText: hidePassword,
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
                              decoration: InputDecoration(
                                hintText: "Confirm Password",
                                prefixIcon: const Icon(Icons.lock_outline),
                                suffixIcon: hidePassword
                                    ? IconButton(
                                        icon: const Icon(Icons.visibility_off),
                                        onPressed: () {
                                          setState(() {
                                            hidePassword = false;
                                          });
                                        },
                                      )
                                    : IconButton(
                                        icon: const Icon(Icons.visibility),
                                        onPressed: () {
                                          setState(() {
                                            hidePassword = true;
                                          });
                                        },
                                      ),
                                border: InputBorder.none,
                              ),
                              controller: confirmPassword,
                              obscureText: hidePassword,
                              validator: (value) {
                                if (password.text != value) {
                                  return "The passwords do not match";
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Material(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.white,
                            elevation: 0.0,
                            child: MaterialButton(
                              onPressed: () async {
                                validateForm();
                              },
                              minWidth: MediaQuery.of(context).size.width,
                              child: const Text(
                                "Sign Up",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.red,
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
                    ]),
                  ))
                ],
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
              ),
            )
          ],
        ),
      ),
    );
  }

  valueChanged(e) {
    setState(() {
      groupValue = e;
    });
  }

  Future<void> validateForm() async {
    FormState? formState = _formKey.currentState;
    Map? value;
    if (formState!.validate()) {
      formState.reset();
      User? user = firebaseAuth.currentUser!;

      // ignore: unnecessary_null_comparison
      if (user == null) {
        firebaseAuth
            .createUserWithEmailAndPassword(
          email: email.text,
          password: password.text,
        )
            .then((userCredential) {
          User? newUser = userCredential.user;
          if (newUser != null) {
            value = {
              "username": name.text,
              "email": email.text,
              "userId": newUser.uid,
              "gender": gender,
            };
            _userServices.createUser(value!);
          }
          // ignore: invalid_return_type_for_catch_error
        }).catchError((err) => {
                  log(err.toString()),
                });
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Home()));
      }
    }
  }
}
