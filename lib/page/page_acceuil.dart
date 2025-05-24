import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gestion_certificats/page/auth/creation_compte1.dart';
import 'package:gestion_certificats/page/habitant/acceuil_hab.dart';
import 'package:gestion_certificats/utils/db_service.dart';
import 'dart:async';

import '../../../constants/app_colors.dart';

class PageAcceuil extends StatefulWidget {
  const PageAcceuil({super.key});

  @override
  State<PageAcceuil> createState() => _PageAcceuilState();
}

class _PageAcceuilState extends State<PageAcceuil> {
  DatabaseService dbService = DatabaseService();
  User? user = FirebaseAuth.instance.currentUser;
  
  @override
  void initState() {
    super.initState();

    // Redirection après 10 secondes
    Timer(const Duration(seconds: 2), () {
      // _routeConditionnel();
      Navigator.of(context).pushNamed('/connexion');
    });
  }

  _routeConditionnel() async {
    String route = '/connexion';

    if(user != null) {
      try {
        Map<String, dynamic> donnees = await dbService.getCurrentUserData();
        
        debugPrint("profil: ${donnees['profil']}");
        if(donnees['profil'] == "Habitant") {
          route = '/acceuil-habitant';
        } else if(donnees['profil'] == "Administrateur") {
          route = '/acceuil-admin';
        } else {
          route = '/connexion';
        }
      } catch (e) {
        route = '/inscription';
        Navigator.of(context).pushNamed(route);
      }

      Navigator.of(context).pushReplacementNamed(route);
    }
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: AppColors.primary,
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/logo-white.png',
            height: 300,
          ),
          const SizedBox(height: 20),
          
          SizedBox(
            width: 300,
            child: LinearProgressIndicator(
              backgroundColor: Colors.white24,  // léger contraste
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
        ],
      ),
    ),
  );
}
}
