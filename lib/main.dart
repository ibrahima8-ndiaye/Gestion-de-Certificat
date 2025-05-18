import 'package:flutter/material.dart';
import 'package:gestion_certificats/acceuil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gestion_certificats/acceuil_hab.dart';
import 'package:gestion_certificats/connexion.dart';
import 'package:gestion_certificats/demande_certificat.dart';

// dark green
// Color.fromARGB(255, 33, 129, 101)
// light green background
// Color.fromARGB(255, 230, 244, 231),

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestion des certificats',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      // debugShowCheckedModeBanner: false,
      home: Connexion(),
      // home: DemandeCertificat(),
      // home: AcceuilHabitant(),
    );
  }
}
