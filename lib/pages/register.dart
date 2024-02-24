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
  String? groupValue = "male";

  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  bool loading = false;

  bool hidePassword = true;

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
                          color: Colors.white.withOpacity(0.4),
                          child: Row(
                            children: [
                              Expanded(
                                child: ListTile(
                                  title: const Text(
                                    "male",
                                    style: TextStyle(color: Colors.white),
                                    textAlign: TextAlign.end,
                                  ),
                                  trailing: Radio(
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
                                    "female",
                                    style: TextStyle(color: Colors.white),
                                    textAlign: TextAlign.end,
                                  ),
                                  trailing: Radio(
                                      value: "male",
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
                                icon: Icon(Icons.email),
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
                            child: ListTile(
                              title: TextFormField(
                                decoration: const InputDecoration(
                                  hintText: "Password",
                                  icon: Icon(Icons.lock_outline),
                                  border: InputBorder.none,
                                ),
                                controller: password,
                                obscureText: true,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "The password field cannot be emepty";
                                  } else if (value.length < 6) {
                                    return "The Password has to be at least 6 characters long";
                                  }
                                  return null;
                                },
                              ),
                              trailing: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      hidePassword = false;
                                    });
                                  },
                                  icon: const Icon(Icons.remove_red_eye)),
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
                            child: ListTile(
                              title: TextFormField(
                                decoration: const InputDecoration(
                                  hintText: "Confirm Password",
                                  icon: Icon(Icons.lock_outline),
                                  border: InputBorder.none,
                                ),
                                controller: confirmPassword,
                                obscureText: true,
                                validator: (value) {
                                  if (password.text != value) {
                                    return "The passwords do not match";
                                  }
                                  return null;
                                },
                              ),
                              trailing: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      hidePassword = false;
                                    });
                                  },
                                  icon: const Icon(Icons.remove_red_eye)),
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
                              onPressed: () async {
                                validateForm();
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

  valueChanged(e) {
    if (e == "male") {
      groupValue = e;
      gender = e;
    } else if (e == "female") {
      groupValue = e;
      gender = e;
    }
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
