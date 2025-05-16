import 'package:flutter/material.dart';
import 'package:gestion_certificats/connexion.dart';
import 'package:gestion_certificats/inscription.dart';
import 'package:gestion_certificats/reinitialisation.dart';

class Acceuil extends StatefulWidget {
  const Acceuil({super.key});

  @override
  State<Acceuil> createState() => _AcceuilState();
}

class _AcceuilState extends State<Acceuil> {
  // List <String> nomPages = ['Connexion', 'Inscription'];
  int indexPageCourant = 0;
  List pages = [Connexion(), Inscription(), Reinitialisation()];

  @override
  Widget build(BuildContext context) {
    // padding: EdgeInsets.only(left: 24, right: 24, top: 24, bottom: MediaQuery.of(context).viewInsets.bottom+24),
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            setState(() {
              indexPageCourant = 0;
            });
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 5),
          // decoration: BoxDecoration(color: Colors.red),
          child: Column(
            children: [
              _header(context),
              // pages[indexPageCourant],
              pages[indexPageCourant],
              indexPageCourant == 0 ? _bottomRow(context) : SizedBox(height: 0,),
            ]
          )
        ),
      )
    );
  }


  _header(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      // mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(
          height: 150,
          // width: 300,
          child: Image.asset('assets/images/logo-cert-green.png'),
        ),
        Text(
          // "Bienvenue dans la page de connexion",
          "Votre certificat facilement",
          style: TextStyle(fontSize: 18, color: const Color.fromARGB(255, 51, 103, 53)),
        ),
      ],
    );
  }

  _bottomRow(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () {
            setState(() {
                indexPageCourant = 2;
              });
          },
          child: const Text("Mot de passe oublie ?",
            style: TextStyle(color: Colors.green),
          ),
        ),
        TextButton(
            onPressed: () {
              setState(() {
                indexPageCourant = 1;
              });
            },
            child: const Text("Creer un compte", style: TextStyle(color: Colors.green),)
        )
      ],
    );
  }
}