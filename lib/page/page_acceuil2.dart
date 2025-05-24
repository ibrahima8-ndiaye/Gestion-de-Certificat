import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gestion_certificats/page/admin/page_dashboard.dart';
import 'package:gestion_certificats/page/auth/creation_compte1.dart';
import 'package:gestion_certificats/page/habitant/acceuil_hab.dart';
import 'package:gestion_certificats/utils/db_service.dart';
import 'dart:async';

import '../../../constants/app_colors.dart';

class PageAcceuil2 extends StatefulWidget {
  const PageAcceuil2({super.key});

  @override
  State<PageAcceuil2> createState() => _PageAcceuil2State();
}

class _PageAcceuil2State extends State<PageAcceuil2> {
  DatabaseService dbService = DatabaseService();
  User? user = FirebaseAuth.instance.currentUser;
  
  @override
  void initState() {
    super.initState();
    // Redirection après 10 secondes
    Timer(const Duration(seconds: 4), () {
      _routeConditionnel();
    });

  }

  _routeConditionnel() async {
    String route = '';

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
