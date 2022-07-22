import 'package:authentification/app_library.dart';
import 'package:authentification/values.dart';
import 'package:flutter/material.dart';

class CreateAccountForm extends StatelessWidget {
  final String email;
  final mailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  final _globalKey = Values().getKey("create");
  final void Function() onCancel;
  final void Function(String mail, String password , String username) onCreate;

  CreateAccountForm({required this.email, required this.onCreate, required this.onCancel});

  @override
  Widget build(BuildContext context) {
    mailController.text = email;
    return MyPadding(
        child: Form(
          key: _globalKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormTitle(title: "Création de compte"),
              AuthTextField(authValue: "mail", controller: mailController, obscure: false,),
              AuthTextField(authValue: "mot de passe", controller: passwordController, obscure: true,),
              BottomButtons(onValidate: () {
                onCreate(mailController.text, passwordController.text, usernameController.text);
              },
                  onCancel: onCancel)

            ],
          ),
        )
    );
  }

}