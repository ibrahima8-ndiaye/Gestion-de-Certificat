import 'package:flutter/material.dart';
import 'package:gestion_certificats/appbar.dart';
import 'package:gestion_certificats/custom_card.dart';

class AcceuilHabitant extends StatefulWidget {
  const AcceuilHabitant({super.key});

  @override
  State<AcceuilHabitant> createState() => _AcceuilHabitantState();
}

class _AcceuilHabitantState extends State<AcceuilHabitant> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: _appbar(context, "Baye Mor Diouf", "Habitant")
      appBar: MyCustomAppbar(nomUtilisateur: "Baye Mor Diouf", profilUtilisateur: "Habitant",),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _boutonDemande(context),
          _historiqueCertificats(context),
        ],
      ),
    );
  }

  _boutonDemande(context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 42, vertical: 24),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.grey, blurRadius: 10, offset: Offset(0, 8))
        ]
      ),
      child: ElevatedButton(
        onPressed: () {
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0)
          ),
          padding: const EdgeInsets.symmetric(vertical: 12),
          backgroundColor: Color.fromARGB(255, 33, 129, 101),
          foregroundColor: Color.fromARGB(155, 218, 236, 230),
        ),
        child: const Text(
          "Demander un certificat",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );     
  }


  _historiqueCertificats(context) {
    final double heightElementsEnHaut = 330; // cette valeur a ete determine manuellement, implementation a ameliorer

    return MyCustomCard(
      child: ListView(
          children: [
            Text(
              "Historique des certificats",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color.fromARGB(255, 33, 129, 101),),
            ),
            CardHistoriqueCert(),
            CardHistoriqueCert(),
            CardHistoriqueCert(),
            CardHistoriqueCert(),
            CardHistoriqueCert(),
            CardHistoriqueCert(),
            CardHistoriqueCert(),
          ],
        ),
    );

    // return Container(
    //   padding: EdgeInsets.symmetric(vertical: 24),
    //   height: MediaQuery.of(context).size.height - heightElementsEnHaut,
    //   decoration: ShapeDecoration(
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.only(topLeft: Radius.elliptical(50, 50), topRight: Radius.elliptical(50, 50)),
    //     ),
    //     // color: Colors.amber,
    //     color: Color.fromARGB(255, 230, 244, 231),
    //   ),
    //   child: ListView(
    //     children: [
    //       Text(
    //         "Historique des certificats",
    //         textAlign: TextAlign.center,
    //         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color.fromARGB(255, 33, 129, 101),),
    //       ),
    //       CardHistoriqueCert(),
    //       CardHistoriqueCert(),
    //       CardHistoriqueCert(),
    //       CardHistoriqueCert(),
    //       CardHistoriqueCert(),
    //       CardHistoriqueCert(),
    //       CardHistoriqueCert(),
    //     ],
    //   ),
    // );
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