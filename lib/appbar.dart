import 'package:flutter/material.dart';
import 'package:gestion_certificats/acceuil.dart';

class MyCustomAppbar extends StatefulWidget implements PreferredSizeWidget {
  final String nomUtilisateur;
  final String profilUtilisateur;
  const MyCustomAppbar({super.key, required this.nomUtilisateur, required this.profilUtilisateur});

  @override
  // Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  Size get preferredSize => const Size.fromHeight(200);

  @override
  State<MyCustomAppbar> createState() => _MyCustomAppbarState();
}

class _MyCustomAppbarState extends State<MyCustomAppbar> {
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size(400, 200),
      child: Column(
        children: [
          AppBar(
            foregroundColor: Colors.white,
            toolbarHeight: 100,
            leadingWidth: 100,
            leading: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Acceuil()),
                );
              },
              icon: Image.asset("assets/images/logo-white.png"),
            ),
            // title: Text("Bienvenue Baye Mor Diouf"),
            actions: [
              IconButton(
                icon: const Icon(Icons.menu_rounded),
                iconSize: 50,
                tooltip: 'Menu',
                onPressed: () {
                  // handle the press
                },
              ),
            ],
            elevation: 10,
            backgroundColor: const Color.fromARGB(255, 33, 129, 101),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            color: Color.fromARGB(255, 33, 129, 101),
            child: 
              Text(
                "Bienvenue, ${widget.nomUtilisateur}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                textAlign: TextAlign.center,
              ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            width: MediaQuery.of(context).size.width,
            color: Color.fromARGB(255, 33, 129, 101),
            child: 
              Text(
                widget.profilUtilisateur!,
                style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic, color: Colors.white),
                textAlign: TextAlign.center,
              ),
          ),
        ]
      ),
    );
  }
}