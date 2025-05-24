import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gestion_certificats/page/habitant/acceuil_hab.dart';
import 'package:gestion_certificats/widgets/header.dart';
import 'package:gestion_certificats/page/auth/inscription.dart';
import 'package:gestion_certificats/utils/authentification.dart';
import 'package:gestion_certificats/utils/db_service.dart';

class CreationCompte2 extends StatefulWidget {
  const CreationCompte2({super.key});

  @override
  State<StatefulWidget> createState() => _CreationCompte2State();
}

class _CreationCompte2State extends State<CreationCompte2> {

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // SizedBox(height: 20,),
          MyCustomHeader(),
          SizedBox(height: 50,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 12),
            child: Column(
              children: [
                MyCustomForm(),
                SizedBox(height: 20,),
              ],
            ),
          ),
        ],
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isNewUser = false;
  // User? user = FirebaseAuth.instance.currentUser;

  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _isNewUser();
  }

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }
  
  _isNewUser() async {
    var data = await DatabaseService().getCurrentUserData();
    print("inside _isNewUser, password: ${data['password']}");
      // return data['password'] != null;
      setState(() {
        isNewUser = false;
      });
    }

  @override
  Widget build(BuildContext context) {    
    return  Form(
      key: _formKey,
      child: FocusScope(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isNewUser ? "Veuillez fournir un code PIN." : "Veuillez saisir votre code PIN",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20,),
                Text(
                  "Code PIN", 
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 33, 129, 101)),
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 10),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty || 
                      !RegExp(r"^[0-9]{1}[0-9]{3}$").hasMatch(value)) {
                      // !RegExp(r"^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*\W)(?!.* ).{8,16}$").hasMatch(value)) {
                      return "Veuillez saisir un code valide";
                    }
                    return null;
                  },
                  controller: passwordController,
                  onTapOutside: (event) {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  maxLength: 4,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color.fromARGB(255, 33, 129, 101), width: 2),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    hintText: "1234",
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
                    prefixIcon: const Icon(Icons.password_outlined)
                  ),
                ),
                SizedBox(height: 10),
                isNewUser ? Text(
                  "* Notez que le code fourni vous sera redemandé à chaque reconnexion",
                  style: TextStyle(color: Colors.blueGrey),
                ) : SizedBox.shrink(),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  User? user = FirebaseAuth.instance.currentUser;
                  if(isNewUser) {
                    FirebaseFirestore.instance.collection("users").doc(user?.uid).set({
                      "password": encryptPassword(passwordController.text),
                    });
                    Navigator.push(context, 
                      MaterialPageRoute(builder: (context) => Inscription())
                    );
                  } else {
                    _verifierPassword();
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(vertical: 14),
                backgroundColor: Colors.green,
              ),
              child: const Text(
                "Confirmer",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _verifierPassword() async {
    Map<String, dynamic>? donnees = await DatabaseService().getCurrentUserData();
    var encryptedPassword = donnees['password'];
    debugPrint("\nencrypted password: $encryptedPassword\n");

    // bool isPasswordVerifie = decryptPassword(encryptedPassword) == passwordController.text;
    bool isPasswordVerifie = verifierPassword(passwordController.text, encryptedPassword);
    if (isPasswordVerifie) {
      debugPrint("Mot de passe correct");
      showDialog(context: context, builder: (context) {
        return AlertDialog.adaptive(content: Text("Mot de passe correct"),);
      });
      Navigator.push(context, 
        MaterialPageRoute(builder: (context) => AcceuilHabitant())
      );
    }
    }
}