import 'package:authentification/auth_widget.dart';
import 'package:authentification/firebase_listener.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



///   Provider.of<X> vs Consumer<X> dans Flutter
///---------------------------------------------
/// Provider.ofest le seul moyen d'obtenir et d'écouter un objet. Consumer, Selector, et tous les appels * ProxyProvider Provider.ofpour fonctionner.
/// Provider.ofvs Consumerest une question de préférence personnelle. Mais il y a quelques arguments pour les deux Fournisseur.de
// peut être appelé dans tout le cycle de vie des widgets, y compris les gestionnaires de clics etdidChangeDependencies
// n'augmente pas l'indentation

/// Consommateur
// permet des reconstructions de widgets plus granulaires
// résout la plupart des abus de BuildContext


/*
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Apprendre Auth",)),
      body: ListView(
        children: [
          Image.asset("images/cover.jpeg"),
          const SizedBox(height: 18,),
          Consumer<FirebaseListener>(builder: (context, auth, _) => Text(auth.auth.toString()))
        ],
      ),
    );
  }
}
*/


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Apprendre Auth",)),
      body: ListView(
        children: [
          Image.asset("assets/cover.jpeg"),
          const SizedBox(height: 18,),
          Consumer<FirebaseListener>(builder: (context, auth, _) => AuthWidget(
            flow: auth.auth,
            start: auth.start,
            cancel: auth.cancel,
            checkMail: auth.checkMail,   /// add
          )
          )
        ],
      ),
    );
  }
}