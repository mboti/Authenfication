import 'package:authentification/app_library.dart';
import 'package:authentification/values.dart';
import 'package:flutter/material.dart';

class SignInForm extends StatelessWidget {
  final String email;
  final _globalKey = Values().getKey("signIn");
  final mailController = TextEditingController();
  final passwordController = TextEditingController();
  final void Function() onCancel;
  final void Function(String mail, String password) onSignIn;

  SignInForm({required this.email, required this.onSignIn, required this.onCancel});

  @override
  Widget build(BuildContext context) {
    mailController.text = email;
    return MyPadding(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FormTitle(title: "Se Connecter"),
          AuthTextField(authValue: "adresse mail", controller: mailController, obscure: false,),
          AuthTextField(authValue: "mot de passe", controller: passwordController, obscure: true,),
          BottomButtons(onValidate: () {
            onSignIn(mailController.text, passwordController.text);
          }, onCancel: onCancel)
        ],
      ),
    );
  }
}