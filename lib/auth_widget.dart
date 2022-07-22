import 'package:authentification/auth_flow.dart';
import 'package:authentification/auth_mail_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';

class AuthWidget extends StatelessWidget {

  final AuthFlow flow;

  //Toutes les methodes de Listener
  final void Function() cancel;
  final void Function() start;
  final void Function(String mail, void Function(FirebaseAuthException exception) errorCallback) checkMail; /// add

  AuthWidget({
    required this.flow,
    required this.cancel,
    required this.start,
    required this.checkMail /// add
  });

  @override
  Widget build(BuildContext context) {
    switch (flow) {
      case AuthFlow.disconnected: return firstLog();
      case AuthFlow.mail: return AuthMailForm(onValidate: onValidate, onCancel: cancel); /// add
      default: return Text(flow.toString());
    }
  }


  /// add
  onValidate(String email) {
    checkMail(email, (error) {
      print(error.toString());
    });
  }


  Column firstLog() {
    return Column(
      children: [
        SignInButton(Buttons.Email, onPressed: start),
        Divider(thickness: 1, color: Colors.purple.shade400,),
        SignInButton(Buttons.Google, onPressed: notImplemented),
        SignInButton(Buttons.GitHub, onPressed: notImplemented),
        SignInButton(Buttons.Facebook, onPressed: notImplemented),
        SignInButton(Buttons.Twitter, onPressed: notImplemented)
      ],
    );
  }

  notImplemented() {

  }
}