import 'package:firebase1/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthenticationService {
  late FirebaseAuth firebaseAuth;
  AuthenticationService({required this.firebaseAuth});
  Stream<User?> get authStateChanges => firebaseAuth.authStateChanges();
  // login
  Future<String?> login(String email, String password) async {
    String messageError = "Error";
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return "Sing in ";
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "invalid-email":
          messageError = "Your email address appears to be malformed.";
          break;
        case "wrong-password":
          messageError = "Your password is wrong.";
          break;
        case "user-not-found":
          messageError = "User with this email doesn't exist.";
          break;
        case "user-disabled":
          messageError = "User with this email has been disabled.";
          break;
        case "too-many-requests":
          messageError = "Too many requests";
          break;
        case "operation-not-allowed":
          messageError = "Signing in with Email and Password is not enabled.";
          break;
        default:
          messageError = "An undefined Error happened.";
      }
      Fluttertoast.showToast(msg: messageError);
    }
    navigatorKey.currentState?.popUntil((route) => false);
  }

  // register
  Future Register(String UserEmail, String UserPassword) async {
    final regiterAcc = FirebaseAuth.instance;
    try {
      await regiterAcc
          .createUserWithEmailAndPassword(
              email: UserEmail, password: UserPassword)
          .then((value) => firebaseAuth.currentUser);
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
    return firebaseAuth.signOut();
  }
}
