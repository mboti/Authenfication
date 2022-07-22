import 'package:authentification/auth_flow.dart';
import 'package:authentification/auth_mail_form.dart';
import 'package:authentification/create_account_form.dart';
import 'package:authentification/sign_in_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';

class AuthWidget extends StatelessWidget {

  final AuthFlow flow;
  final String? email; /// add

  //Toutes les methodes de Listener
  final void Function() cancel;
  final void Function() start;
  final void Function(String mail, void Function(FirebaseAuthException exception) errorCallback) checkMail; /// add
  final void Function(String mail, String password, String username, void Function(FirebaseAuthException) error) createAccount; /// add2
  final void Function(String mail, String password, void Function(FirebaseAuthException e) error) signIn; /// add3
  final void Function() logOut; /// add3

  AuthWidget({
    required this.flow,
    required this.cancel,
    required this.start,
    required this.checkMail, /// add
    required this.createAccount, /// add2
    required this.email, /// add2
    required this.logOut, /// add3
    required this.signIn /// add3
  });

  @override
  Widget build(BuildContext context) {
    switch (flow) {
      case AuthFlow.disconnected: return firstLog();
      case AuthFlow.mail: return AuthMailForm(onValidate: onValidate, onCancel: cancel); /// add
      case AuthFlow.createAccount: return CreateAccountForm(email: email ?? "", onCreate: onCreate, onCancel: cancel); /// add2
      case AuthFlow.connected: return Center(child: ElevatedButton(onPressed: logOut, child: const Text("Se déconnecter"))); /// add3
      case AuthFlow.signIn: return SignInForm(email: email ?? "", onSignIn: onSignIn, onCancel: cancel); /// add3
      default: return Text(flow.toString());
    }
  }


  /// add
  onValidate(String email) {
    checkMail(email, (error) {
      print(error.toString());
    });
  }

  /// add2
  onCreate(String mail, String password, String username) {
    createAccount(mail, password, username, (error) {
      print(error.toString());
    });
  }

  onSignIn(String mail, String password) {
    signIn(mail, password, (error) {
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