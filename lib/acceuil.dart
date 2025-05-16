import 'package:flutter/material.dart';
import 'package:gestion_certificats/connexion.dart';
import 'package:gestion_certificats/inscription.dart';

class Acceuil extends StatefulWidget {
  const Acceuil({super.key});

  @override
  State<Acceuil> createState() => _AcceuilState();
}

class _AcceuilState extends State<Acceuil> {
  // List <String> nomPages = ['Connexion', 'Inscription'];
  int indexPageCourant = 0;
  List pages = [Connexion(), Inscription()];

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
          // Icons.arrow_back),
        // title: 
        // TextButton(
        //     onPressed: () {
        //       setState(() {
        //         indexPageCourant = 0;
        //       });
        //     },
        //     child: const Text("Retour")
        //     // child: const Text("Retour", style: TextStyle(color: Colors.green),)
        // ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          margin: const EdgeInsets.all(24),
          // decoration: BoxDecoration(color: Colors.red),
          child: Column(
            children: [
              _header(context),
              pages[indexPageCourant],
              _bottomRow(context),
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
          height: 200,
          width: 400,
          child: Image.asset('assets/images/logo-cert-green.png'),
        ),
        Text(
          "Bienvenue dans la page de connexion",
          style: TextStyle(fontSize: 18,),
        ),
      ],
    );
  }

  _bottomRow(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () {},
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