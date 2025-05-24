import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gestion_certificats/page/habitant/acceuil_hab.dart';
import 'package:gestion_certificats/widgets/header.dart';
import 'package:gestion_certificats/utils/db_service.dart';

class CreationCompte extends StatefulWidget {
  const CreationCompte({super.key});

  @override
  State<StatefulWidget> createState() => _CreationCompteState();
}

class _CreationCompteState extends State<CreationCompte> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          MyCustomHeader(),
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
  DatabaseService dbService = DatabaseService();
  Map<String, dynamic>? donnees;
  String? profil;

  bool messageEnvoye = false;
  final FocusScopeNode _node = FocusScopeNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final numberController = TextEditingController();
  final codeController = TextEditingController();

  // FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseAuth auth = FirebaseAuth.instanceFor(app: Firebase.app(), persistence: Persistence.LOCAL);
  String _verifId = '';

  @override
  void initState() {
    super.initState();
    _routeConditional();
    
  }
  _routeConditional() async {
    User? user = FirebaseAuth.instance.currentUser;
    String route = '';
    if(user != null) {
      try {
        Map<String, dynamic> donnees = await dbService.getCurrentUserData();
        
        if(donnees['profil'] == "Administrateur") {
          route = '/acceuil-habitant';
        } else if(donnees['profil'] == "Administrateur") {
          route = '/acceuil-admin';
        } else {
          route = '/connexion';
        }
      } catch (e) {
        route = '/inscription';
        Navigator.of(context).pushReplacementNamed(route);
      }

      Navigator.of(context).pushReplacementNamed(route);
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.

    numberController.dispose();
    codeController.dispose();
    _node.dispose();

    super.dispose();

  }
  
  @override
  Widget build(BuildContext context) {
    return  Form(
      key: _formKey,
      child: FocusScope(
        node: _node,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            !messageEnvoye ? _numTextField() : _codeTextField(),
            const SizedBox(height: 30),
            !messageEnvoye ? _boutonConfirmer() : _boutonCreation(),
          ],
        ),
      ),
    );
  }

  Future<void> _codeValidator() async {    
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: _verifId,
      smsCode: codeController.text,
    );
    debugPrint('Signing in!!!');
    try {
        await auth.signInWithCredential(credential);
        debugPrint('Sign-in success');
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => AcceuilHabitant()),
          (route) => false
        );
    } catch (e) {
      debugPrint('Sign-in failed: $e');
      showDialog(context: context, builder: (context) {
          return AlertDialog(content: Text("Echec de la connexion"),);
        },
      );
      Navigator.of(context).pop();
    }
  }

  Future<void> _numberValidator() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "+221 ${numberController.text}",
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          debugPrint('Le numéro de téléphone fourni est invalide.');
        }
      },
      codeSent: (String verificationId, int? resendToken) async {
        setState(() {
          _verifId = verificationId;
          messageEnvoye = true;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
  
  _numTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Pour vous connecter, veuillez fournir votre numéro de téléphone",
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 40,),
        Text(
          "Numéro de téléphone", 
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 33, 129, 101)),
          textAlign: TextAlign.start,
        ),
        SizedBox(height: 10),
        TextFormField(
          validator: (value) {
            if (value!.isEmpty || 
              !RegExp(r"^7[8765]{1}[0-9]{7}$").hasMatch(value)) {
              return "Veuillez saisir un numéro de téléphone valide";
            }
            return null;
          },
          controller: numberController,
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          maxLength: 9,
          onEditingComplete: _node.nextFocus,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(255, 33, 129, 101), width: 2),
              borderRadius: BorderRadius.circular(15),
            ),
            hintText: "7x 123 45 67",
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
            prefixIcon: const Icon(Icons.phone_outlined)
            // prefixIcon: Text("+221",)
          ),
        ),
        SizedBox(height: 10,),
        Text(
          "* Un message vous sera envoyé avec un code de connexion au numéro de téléphone fourni.",
          style: TextStyle(color: Colors.blueGrey),
        ),
      ]
    );
  }
  
  _codeTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Veuillez remplir le champ ci-dessous avec le code recu par sms",
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20,),
        Text('Code', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 33, 129, 101)),),
        SizedBox(height: 10),
        TextFormField(
          validator: (value) {
            if (value!.isEmpty || 
              !RegExp(r"^[0-9]{1}[0-9]{5}$").hasMatch(value)) {
              return "Veuillez saisir un code valide";
            }
            return null;
          },
          controller: codeController,
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          maxLength: 6,
          onEditingComplete: _node.nextFocus,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(255, 33, 129, 101), width: 2),
              borderRadius: BorderRadius.circular(15),
            ),
            hintText: "123456",
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
          ),
        ),
      ]
    );
  }
  
  _boutonCreation() {
    return ElevatedButton(
      // onPressed: _codeValidator,
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          _codeValidator();
        }
      },
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(vertical: 14),
        backgroundColor: Colors.green,
      ),
      child: const Text(
        "Se connecter",
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }
  
  _boutonConfirmer() {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          // ScaffoldMessenger.of(context).showSnackBar(
          //   const SnackBar(content: Text('Processing Data')),
          // );
          _numberValidator();
        }
      },
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(vertical: 14),
        backgroundColor: Colors.green,
      ),
      child: const Text(
        "Confirmer numéro",
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }
}