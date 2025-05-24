import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gestion_certificats/page/admin/page_dashboard.dart';
import 'package:gestion_certificats/page/habitant/acceuil_hab.dart';
import 'package:gestion_certificats/page/auth/creation_compte1.dart';
import 'package:gestion_certificats/page/auth/inscription.dart';
import 'package:gestion_certificats/page/page_acceuil.dart';
import 'package:gestion_certificats/page/page_acceuil2.dart';

// dark green
// Color.fromARGB(255, 33, 129, 101)
// light green background
// Color.fromARGB(255, 230, 244, 231),

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  
  // firebase auth emulator initialisation
  await Firebase.initializeApp();
  FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
  FirebaseAuth.instance.useAuthEmulator('localhost', 9099);

  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  // const MainApp({super.key});
  MainApp({super.key});
  final bool isConnecte = false;
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestion des certificats',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      // debugShowCheckedModeBanner: false,
      home: PageAcceuil(),
      // home: user != null ? PageAcceuil() : CreationCompte(),
      routes: {
        '/connexion': (context) => CreationCompte(),
        '/inscription': (context) => Inscription(),
        '/acceuil-habitant': (context) => AcceuilHabitant(),
        '/acceuil-admin': (context) => PageDashboard(),
      },
      // home: Connexion(),
      // home: DemandeCertificat(),
      // home: Inscription(),
      // home: AcceuilHabitant(),
    );
  }
}
