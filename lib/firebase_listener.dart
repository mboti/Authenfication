import 'package:authentification/auth_flow.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class FirebaseListener extends ChangeNotifier{

  AuthFlow auth = AuthFlow.disconnected;
  String email = "";

  FirebaseListener(){
    init();
  }

  Future<void> init() async {
    // init App
    await Firebase.initializeApp();
    //Listen Auth
    FirebaseAuth.instance.userChanges().listen((newUser) {
      auth = (newUser == null) ? AuthFlow.disconnected : AuthFlow.connected;
      notifyListeners();
    });
  }

  //StartFlow
  start() {
    auth = AuthFlow.mail;
    notifyListeners();
  }

  //CheckMail
  checkMail(String email, void Function(FirebaseAuthException authException) errorCallback) async {
    try {
      final allMethods =  await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
      if (allMethods.contains('password')) {
        auth = AuthFlow.signIn;
      } else {
        auth = AuthFlow.createAccount;
      }
      this.email = email;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  //SignIn
  signIn(String mail, String password, void Function(FirebaseAuthException authException) errorCallback) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: mail, password: password);
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  //CreateAccount
  createAccount(String mail, String password, String username, void Function(FirebaseAuthException authException) errorCallback) async {
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: mail, password: password);
      await credential.user!.updateDisplayName(username);
      //Ajoutera plus tard sur Cloud l'user
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  //Disconnect
  logOut() {
    FirebaseAuth.instance.signOut();
  }

  //Cancel
  cancel() {
    if (auth == AuthFlow.mail) {
      auth = AuthFlow.disconnected;
    } else {
      auth = AuthFlow.mail;
    }
    notifyListeners();
  }

}