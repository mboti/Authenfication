import 'package:authentification/app_library.dart';
import 'package:authentification/values.dart';
import 'package:flutter/material.dart';

class AuthMailForm extends StatelessWidget {

  final _globalKey = Values().getKey("email");
  final mailController = TextEditingController();
  final void Function() onCancel;
  final void Function(String mail) onValidate;

  AuthMailForm({required this.onValidate, required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return MyPadding(
        child: Form(
          key: _globalKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormTitle(title: "Adresse mail"),
              AuthTextField(authValue: "email", controller: mailController),
              BottomButtons(onValidate: () {
                final email = mailController.text;
                if (_globalKey.currentState!.validate()) {
                  onValidate(email);
                }
              },
                  onCancel: onCancel)
            ],
          ),
        )
    );
  }

}