// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/pages/home.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Login",
          style: TextStyle(color: Colors.red.shade900),
        ),
        elevation: 0.5,
      ),
      body: Stack(children: [
        Center(
          child: MaterialButton(
            color: Colors.red.shade900,
            onPressed: handleSignIn,
            child: const Text(
              'Sign in / Sign up with google',
              style: TextStyle(color: Colors.white),
            ),
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
    );
  }
}
