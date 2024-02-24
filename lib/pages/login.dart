// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/pages/home.dart';
import 'package:e_commerce_app/pages/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  SharedPreferences? preferences;
  bool loading = false;
  bool isLoggedin = false;

  @override
  void initState() {
    super.initState();
    isSignedIn();
  }

  void isSignedIn() async {
    setState(() {
      loading = true;
    });

    preferences = await SharedPreferences.getInstance();
    isLoggedin = await googleSignIn.isSignedIn();

    User? user = firebaseAuth.currentUser;
    if (user != null) {
      setState(() {
        isLoggedin = true;
      });
    }

    if (isLoggedin == true) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home()));
    }
    setState(() {
      loading = false;
    });
  }

  Future handleSignIn() async {
    preferences = await SharedPreferences.getInstance();
    setState(() {
      loading = true;
    });
    GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleUser!.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    UserCredential userCredential =
        await firebaseAuth.signInWithCredential(credential);
    User? user = userCredential.user;
    if (user != null) {
      final QuerySnapshot result = await FirebaseFirestore.instance
          .collection("users")
          .where("id", isEqualTo: user.uid)
          .get();
      final List<DocumentSnapshot> documents = result.docs;
      if (documents.isEmpty) {
        FirebaseFirestore.instance.collection("users").doc(user.uid).set({
          "id": user.uid,
          "username": user.displayName,
          "profilePicture": user.photoURL,
        });
        await preferences!.setString("id", user.uid);
        await preferences!.setString("username", user.displayName!);
        await preferences!.setString("profilePicture", user.photoURL!);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home()));
      } else {
        await preferences!.setString("id", documents[0]["id"]);
        await preferences!.setString("username", documents[0]["username"]);
        await preferences!
            .setString("profilePicture", documents[0]["profilePicture"]);
      }
      Fluttertoast.showToast(msg: "Login was successful");
      setState(() {
        loading = false;
      });
    } else {}
  }

  bool hidePassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
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
                          fit: BoxFit.cover,
                          width: 180,
                          height: 180,
                        ),
                      ),
                    ),
                    Center(
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
                                        prefixIcon:
                                            const Icon(Icons.lock_outline),
                                        suffixIcon: hidePassword
                                            ? IconButton(
                                                icon: const Icon(
                                                    Icons.visibility_off),
                                                onPressed: () {
                                                  setState(() {
                                                    hidePassword = false;
                                                  });
                                                },
                                              )
                                            : IconButton(
                                                icon: const Icon(
                                                    Icons.visibility),
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
                                          return "The password field cannot be empty";
                                        } else if (value.length < 6) {
                                          return "The Password has to be at least 6 characters long";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 30),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Material(
                                    borderRadius: BorderRadius.circular(20.0),
                                    color: Colors.white,
                                    elevation: 0.0,
                                    child: MaterialButton(
                                      onPressed: () {},
                                      minWidth:
                                          MediaQuery.of(context).size.width,
                                      child: const Text(
                                        "Login",
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
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const SignUp()));
                                  },
                                  child: RichText(
                                      text: const TextSpan(
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16.0,
                                          ),
                                          children: [
                                        TextSpan(
                                            text:
                                                "Dont't have an account ? Click Here to "),
                                        TextSpan(
                                            text: "Sign up !",
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold,
                                            )),
                                      ])),
                                ),
                              )
                            ],
                          )),
                    ),
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
                  ))
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(30.0), // Adjust the value as needed
          ),
          color: Colors.red.shade900,
          onPressed: handleSignIn,
          child: const Padding(
            padding: EdgeInsets.all(15),
            child: Text(
              'Sign in / Sign up with google',
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          ),
        ),
      ),
    );
  }
}
