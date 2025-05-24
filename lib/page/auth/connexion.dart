// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:gestion_certificats/widgets/header.dart';
// import 'package:gestion_certificats/page/auth/inscription.dart';
// import 'package:gestion_certificats/page/auth/reinitialisation.dart';

// class Connexion extends StatefulWidget {
//   const Connexion({super.key});

//   @override
//   State<StatefulWidget> createState() => _ConnexionState();
// }

// class _ConnexionState extends State<Connexion> {

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           // SizedBox(height: 20,),
//           MyCustomHeader(),
//           SizedBox(height: 50,),
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 12),
//             child: Column(
//               children: [
//                 MyCustomForm(),
//                 SizedBox(height: 20,),
//                 _bottomRow(context)
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//     _bottomRow(context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         TextButton(
//           onPressed: () {
//             setState(() {
//                 // indexPageCourant = 2;
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => Reinitialisation()),
//                 );
//               });
//           },
//           child: const Text("Mot de passe oublie ?",
//             style: TextStyle(color: Colors.green),
//           ),
//         ),
//         TextButton(
//             onPressed: () {
//               setState(() {
//                 // indexPageCourant = 1;
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => Inscription()),
//                 );
//               });
//             },
//             child: const Text("Creer un compte", style: TextStyle(color: Colors.green),)
//         )
//       ],
//     );
//   }
// }

// class MyCustomForm extends StatefulWidget {
//   const MyCustomForm({super.key});

//   @override
//   State<MyCustomForm> createState() => _MyCustomFormState();
// }

// class _MyCustomFormState extends State<MyCustomForm> {
//   final FocusScopeNode _node = FocusScopeNode();
//   final GlobalKey _formKey = GlobalKey();
//   String _verifId = '';
//   bool messageEnvoye = false;

//   final numberController = TextEditingController();
//   final passwordController = TextEditingController();
//   final codeController = TextEditingController();

//   FirebaseAuth auth = FirebaseAuth.instance;

//   @override
//   void dispose() {
//     numberController.dispose();
//     passwordController.dispose();
//     codeController.dispose();
//     _node.dispose();

//     super.dispose();
//   }
  
//   @override
//   Widget build(BuildContext context) {
//     return  Form(
//       key: _formKey,
//       child: FocusScope(
//         node: _node,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//           TextFormField(
//             controller: numberController,
//             onTapOutside: (event) {
//               FocusManager.instance.primaryFocus?.unfocus();
//             },
//             maxLength: 9,
//             onEditingComplete: _node.nextFocus,
//             keyboardType: TextInputType.phone,
//             decoration: InputDecoration(
//                 labelText: "Votre numero de telephone",
//                 hintText: "7x 123 45 67",
//                 border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(18),
//                     borderSide: BorderSide.none
//                 ),
//                 fillColor: Colors.green.withValues(alpha: 0.1),
//                 filled: true,
//                 prefixIcon: const Icon(Icons.phone)),
//           ),
//           TextFormField(
//             controller: passwordController,
//             onTapOutside: (event) {
//               FocusManager.instance.primaryFocus?.unfocus();
//             },
//             onEditingComplete: _node.nextFocus,
//             decoration: InputDecoration(
//               labelText: "Votre mot de passe",
//               border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(18),
//                   borderSide: BorderSide.none),
//               fillColor: Colors.green.withValues(alpha: 0.1),
//               filled: true,
//               prefixIcon: const Icon(Icons.password),
//             ),
//             obscureText: true,
//           ),
//             const SizedBox(height: 30),
//             ElevatedButton(
//               onPressed: () {
//                 _numberValidator();
//                 // Navigator.push(
//                 //   context,
//                 //   MaterialPageRoute(builder: (context) => AcceuilHabitant()),
//                 // );
//               },
//               style: ElevatedButton.styleFrom(
//                 shape: const StadiumBorder(),
//                 padding: const EdgeInsets.symmetric(vertical: 14),
//                 backgroundColor: Colors.green,
//               ),
//               child: const Text(
//                 "Connexion",
//                 style: TextStyle(fontSize: 20, color: Colors.white),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//   _numTextField() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           "Pour créer un compte veuillez fournir votre numéro de téléphone",
//           textAlign: TextAlign.center,
//         ),
//         SizedBox(height: 20,),
//         Text(
//           "Numéro de téléphone", 
//           style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 33, 129, 101)),
//           textAlign: TextAlign.start,
//         ),
//         SizedBox(height: 10),
//         TextFormField(
//           validator: (value) {
//             if (value!.isEmpty || 
//               !RegExp(r"^7[8765]{1}[0-9]{7}$").hasMatch(value)) {
//               return "Veuillez saisir un numéro de téléphone valide";
//             }
//             return null;
//           },
//           controller: numberController,
//           onTapOutside: (event) {
//             FocusManager.instance.primaryFocus?.unfocus();
//           },
//           maxLength: 9,
//           onEditingComplete: _node.nextFocus,
//           keyboardType: TextInputType.phone,
//           decoration: InputDecoration(
//             focusedBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: Color.fromARGB(255, 33, 129, 101), width: 2),
//               borderRadius: BorderRadius.circular(15),
//             ),
//             hintText: "7x 123 45 67",
//             hintStyle: TextStyle(
//               color: Color.fromARGB(180, 33, 129, 101),
//               fontFamily: "Roboto",
//             ),
//             border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(15),
//                 borderSide: BorderSide.none
//             ),
//             fillColor: Colors.green.withValues(alpha: 0.1),
//             filled: true,
//             prefixIcon: const Icon(Icons.phone_outlined)
//             // prefixIcon: Text("+221",)
//           ),
//         ),
//         Text(
//           "* Un message vous sera envoyé avec un code de connexion au numéro de téléphone fourni.",
//           style: TextStyle(color: Colors.blueGrey),
//         ),
//       ]
//     );
//   }

//   Future<void> _numberValidator() async {
//     await FirebaseAuth.instance.verifyPhoneNumber(
//       // phoneNumber: '+221 771234567',
//       phoneNumber: "+221 ${numberController.text}",
//       verificationCompleted: (PhoneAuthCredential credential) {
//         if (credential.smsCode == codeController.text) {
//           showDialog(context: context, builder: (context) {
//               return AlertDialog(content: Text("Le numero est vérifié ${credential.smsCode}"),);
//             },
//           );
//         }
//       },
//       verificationFailed: (FirebaseAuthException e) {
//         showDialog(context: context, builder: (context) {
//             return AlertDialog(content: Text("Verification echoue: $e"),);
//           },
//         );
//       },
//       codeSent: (String verificationId, int? resendToken) async {
//         setState(() {
//           _verifId = verificationId;
//           messageEnvoye = true;
//         });

//         showDialog(context: context, builder: (context) {
//             return AlertDialog(content: Text("Le code a ete envoye"),);
//           },
//         );
//       },
//       codeAutoRetrievalTimeout: (String verificationId) {},
//     );
//   }  
// }