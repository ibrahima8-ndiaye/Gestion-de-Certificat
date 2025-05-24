import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gestion_certificats/page/auth/creation_compte1.dart';
import 'package:gestion_certificats/page/habitant/acceuil_hab.dart';
import 'package:gestion_certificats/page/auth/connexion.dart';
import 'package:gestion_certificats/constants/app_colors.dart';

// il faut appeler le constructeur MyCustomAppbarAvecTitre() pour les pages ou il y a le bouton
// "retour" et le titre de la page


class MyCustomAppbar extends StatefulWidget implements PreferredSizeWidget {
  final String? profilUtilisateur;
  final String? nomUtilisateur;
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
                Widget? route;
                if (widget.profilUtilisateur == 'Habitant') {
                  route = AcceuilHabitant();
                } else if (widget.profilUtilisateur == 'Administrateur') {
                  route = AcceuilHabitant();
                }
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => route!),
                );
              },
              icon: Image.asset("assets/images/logo-white.png"),
            ),
            elevation: 10,
            backgroundColor: Color.fromARGB(245, 33, 129, 101),
          ),
          _appbarBottom(),
        ]
      ),
    );
  }

  _appbarBottom() {
    return Column(
      children: [
        Container(
            width: MediaQuery.of(context).size.width,
            color: Color.fromARGB(255, 33, 129, 101),
            child: 
              Text(
                "Bienvenue, ${widget.nomUtilisateur ?? 'donnee non chargee'}",
                // "Bienvenue, donnee non chargee",
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
                widget.profilUtilisateur ?? 'donnee non chargee',
                style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic, color: Colors.white),
                textAlign: TextAlign.center,
              ),
          ),
      ],
    );
  }
}

class MyCustomAppbarAvecTitre extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  const MyCustomAppbarAvecTitre({super.key, required this.title});

  @override
  // Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  Size get preferredSize => const Size.fromHeight(200);

  @override
  State<MyCustomAppbarAvecTitre> createState() => _MyCustomAppbarAvecTitreState();
}

class _MyCustomAppbarAvecTitreState extends State<MyCustomAppbarAvecTitre> {

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
                  MaterialPageRoute(builder: (context) => CreationCompte()),
                );
              },
              icon: Image.asset("assets/images/logo-white.png"),
            ),
            elevation: 10,
            backgroundColor: Color.fromARGB(245, 33, 129, 101),
          ),
          _appbarBottom()
        ]
      ),
    );
  }

  _appbarBottom() {
    return Container(
      padding: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width,
      color: Color.fromARGB(255, 33, 129, 101),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () { Navigator.pop(context); },
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
            ),
            child: Row(
              children: [
                Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.white,
                ),
                SizedBox(width: 10,),
                Text(
                  "Retour",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ],
            ),
          ),
          Text(
            widget.title,
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white),
            textAlign: TextAlign.end,
          )
        ],
      ),
    );
  }
}

class MyDrawer extends StatefulWidget {
  final String? profilUtilisateur;
  final String? nomUtilisateur;
  const MyDrawer({super.key, required this.nomUtilisateur, required this.profilUtilisateur});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(color: AppColors.miniBackground),
            child: Column(
              children: [
                Text(
                  widget.nomUtilisateur!, style: const TextStyle(color: AppColors.textPrimary, fontSize: 24),
                  textAlign: TextAlign.center,
                ),
                Icon(Icons.person, size: 100, color: AppColors.textSecondary,), // profile picture
              ],
            ),
          ),
          ListTile(
            title: Text(
              widget.profilUtilisateur!, style: const TextStyle(color: AppColors.textPrimary, fontSize: 24),
              textAlign: TextAlign.center,
            ),
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Se Déconnecter"),
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushNamedAndRemoveUntil('/connexion', (route) => false);
            },
          ),
        ],
      ),
    );
  }
}