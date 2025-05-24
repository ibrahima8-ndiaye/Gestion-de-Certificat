import 'package:flutter/material.dart';
import 'package:gestion_certificats/widgets/appbar.dart';
import 'package:gestion_certificats/widgets/custom_card.dart';
import 'package:gestion_certificats/page/habitant/demande_certificat.dart';
import 'package:gestion_certificats/utils/db_service.dart';

class AcceuilHabitant extends StatefulWidget {
  const AcceuilHabitant({super.key});

  @override
  State<AcceuilHabitant> createState() => _AcceuilHabitantState();
}

class _AcceuilHabitantState extends State<AcceuilHabitant> {
  final DatabaseService dbService = DatabaseService();
  Map<String, dynamic>? donnees;
  String? profil;
  String? nom;
  
  @override
  void initState() {
    super.initState();
    _getUserData();
    
  }
  _getUserData() async {
    donnees = await dbService.getCurrentUserData();
    if(donnees != null) {
      setState(() {
        profil = donnees?['profil'];
        nom = donnees?['nom'];
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyCustomAppbar(nomUtilisateur: nom, profilUtilisateur: profil,),
      endDrawer: MyDrawer(nomUtilisateur: nom, profilUtilisateur: profil,),
      body: Column(
        children: [
          _boutonDemande(context),
          _historiqueCertificats(context),
        ],
      ),
    );
  }

  _boutonDemande(context) {
    return Container(
      margin: EdgeInsets.only(left: 42, right: 42, top: 12, bottom: 24),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.grey, blurRadius: 10, offset: Offset(0, 8))
        ]
      ),
      child: ElevatedButton(
        onPressed: () {
          // Navigator.push(context, MaterialPageRoute(builder: (context) => DemandeCertificat()));
          showDialog(context: context, builder: (context) {
            return DemandeCertificat();
          });
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)
          ),
          padding: const EdgeInsets.symmetric(vertical: 18),
          backgroundColor: Color.fromARGB(255, 33, 129, 101),
          foregroundColor: Color.fromARGB(155, 218, 236, 230),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            "Demander un certificat",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      ),
    );     
  }


  _historiqueCertificats(context) {
    final double heightElementsEnHaut = 375; // cette valeur a ete determine manuellement, implementation a ameliorer

    return MyCustomCard(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Text(
              "Historique des certificats",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color.fromARGB(255, 33, 129, 101),),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12),
            height: MediaQuery.of(context).size.height - heightElementsEnHaut,
            child: ListView(
                children: [
                  CardHistoriqueCert(),
                  CardHistoriqueCert(),
                  CardHistoriqueCert(),
                  CardHistoriqueCert(),
                  CardHistoriqueCert(),
                  CardHistoriqueCert(),
                  CardHistoriqueCert(),
                ],
              ),
          ),
        ],
      ),
    );
  }
}

class CardHistoriqueCert extends StatelessWidget {
  const CardHistoriqueCert({super.key});

  @override
  Widget build(BuildContext context) {
    String? date = "05-04-2025";
    String? heure = "18:30";

    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Card(
        color: Colors.white,
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          splashColor: Color.fromARGB(255, 230, 244, 231),
          onTap: () {
            debugPrint('Afficher details certificat.');
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            width: 380,
            height: 80,
            child: Row(
              // spacing: 50,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset("assets/images/icert-alpha.png",),
                Text(date,  textAlign: TextAlign.center, 
                  style: TextStyle(
                    color: Color.fromARGB(255, 33, 129, 101), fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Column(
                  children: [
                    Text(
                      heure,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromARGB(255, 33, 129, 101), fontWeight: FontWeight.bold, fontSize: 16
                      ),
                    ),
                    SizedBox(height: 20,),
                    Text(
                      "Validite",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        color: Color.fromARGB(255, 33, 129, 101), fontWeight: FontWeight.bold, fontSize: 16
                      ),
                    ),
                  ]
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}