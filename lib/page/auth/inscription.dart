import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gestion_certificats/page/habitant/acceuil_hab.dart';
import 'package:gestion_certificats/widgets/header.dart';
import 'package:gestion_certificats/utils/db_service.dart';
import 'package:intl/intl.dart';

class Inscription extends StatefulWidget {
  const Inscription({super.key});

  @override
  State<StatefulWidget> createState() => _InscriptionState();
}

class _InscriptionState extends State<Inscription> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(
            left: 24,
            right: 24,
            bottom: MediaQuery.of(context).viewInsets.bottom+24
          ),
          // padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom+24),
          child: Column(
            children: [
              MyCustomHeader(),
              SizedBox(height: 20,),
              Text(
                "Veuillez fournir les informations suivantes pour compléter la création de votre compte",
                // style: TextStyle(color: Colors.green, fontSize: 14,),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24,),
              MyCustomForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  State<MyCustomForm> createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  final FocusScopeNode _node = FocusScopeNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  DateTime? selectedDate;// = DateTime(1990);
  TextEditingController dateController = TextEditingController();
  String date = DateFormat('dd/MM/yyyy').format(DateTime.now());
  final nomController = TextEditingController();
  final ldnController = TextEditingController();
  final cniController = TextEditingController();

  FirebaseFirestore db = FirebaseFirestore.instance;
  // var user = <String, dynamic>{};

  @override
  void dispose() {
    _node.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    OutlineInputBorder border = OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide.none);
    var focusedBorder = OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 33, 129, 101), width: 1.5), borderRadius: BorderRadius.circular(15),);
    
    return  Form(
      key: _formKey,
      child: FocusScope(
        node: _node,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Date de naissance', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 33, 129, 101)),),
            SizedBox(height:MediaQuery.of(context).viewInsets.bottom+10),
            ElevatedButton(
              onPressed: () => _selectDate(context),
              child: Text(
                "Choisir la date: $date",
                style: TextStyle(
                  color: Color.fromARGB(255, 33, 129, 101),
                  fontFamily: "Roboto",
                ),
              ),
            ),
            SizedBox(height:MediaQuery.of(context).viewInsets.bottom+20),
            Text('Nom complet', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 33, 129, 101)),),
            SizedBox(height:MediaQuery.of(context).viewInsets.bottom+10),
            TextFormField(
              controller: nomController,
              validator: (value) {
                if (value!.isEmpty || 
                  !RegExp(r"^[A-Z][a-zâôéè]+(?: [A-Z][a-zâôéè]+){1,2}$").hasMatch(value)) {
                  return "Veuillez saisir un nom complet valide";
                }
                return null;
              },
              onTapOutside: (event) {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              onEditingComplete: _node.nextFocus,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                hintText: "Prenom Nom",
                hintStyle: TextStyle(
                  color: Color.fromARGB(180, 33, 129, 101),
                  fontFamily: "Roboto",
                ),
                border: border,
                focusedBorder: focusedBorder,
                fillColor: Colors.green.withValues(alpha: 0.1),
                filled: true,
              ),
            ),
            SizedBox(height:MediaQuery.of(context).viewInsets.bottom+20),
            Text('Lieu de naissance', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 33, 129, 101)),),
            SizedBox(height:MediaQuery.of(context).viewInsets.bottom+10),
            TextFormField(
              controller: ldnController,
              validator: (value) {
                if (value!.isEmpty || 
                  !RegExp(r"\w*\s*^[a-zA-Z,\s\d]*$").hasMatch(value)) {
                  return "Veuillez saisir votre lieu de naissance";
                }
                return null;
              },
              onTapOutside: (event) {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              onEditingComplete: _node.nextFocus,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                focusedBorder: focusedBorder,
                hintText: "Lieu de Naissance",
                hintStyle: TextStyle(
                  color: Color.fromARGB(180, 33, 129, 101),
                  fontFamily: "Roboto",
                ),
                border: border,
                fillColor: Colors.green.withValues(alpha: 0.1),
                filled: true,
              ),
            ),
            SizedBox(height:MediaQuery.of(context).viewInsets.bottom+20),
            Text('Numero d\'identification nationale', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 33, 129, 101)),),
            SizedBox(height:MediaQuery.of(context).viewInsets.bottom+10),
            TextFormField(
              controller: cniController,
              validator: (value) {
                if (value!.isEmpty || 
                  !RegExp(r"^[0-9]{1}[0-9]{12}$").hasMatch(value)) {
                  return "Veuillez saisir un numéro d'identification valide";
                }
                return null;
              },
              onTapOutside: (event) {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              maxLength: 13,
              onEditingComplete: _node.nextFocus,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                focusedBorder: focusedBorder,
                hintText: "x xxxx xxxx xxxxx",
                hintStyle: TextStyle(
                  color: Color.fromARGB(180, 33, 129, 101),
                  fontFamily: "Roboto",
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none
                ),
                fillColor: Colors.green.withValues(alpha: 0.1),
                filled: true,
                // prefixIcon: const Icon(Icons.perm_identity)
              ),
            ),
            SizedBox(height:MediaQuery.of(context).viewInsets.bottom+20),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   const SnackBar(content: Text('Processing Data')),
                  // );

                  DatabaseService dbService = DatabaseService();
                  dbService.addUser(
                    nomComplet: nomController.text,
                    profil: "Habitant",
                    dateDeNaissance: date,
                    lieuDeNaissance: ldnController.text,
                    cni: cniController.text,
                  );
                  
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AcceuilHabitant()));
                }
              },
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(vertical: 14),
                backgroundColor: Colors.green,
              ),
              child: const Text(
                "Inscription",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateController.text = DateFormat('dPikd/MM/yyyy').format(picked);
        date = DateFormat('dd/MM/yyyy').format(picked).split(" ")[0];
      });
    }
  }
}