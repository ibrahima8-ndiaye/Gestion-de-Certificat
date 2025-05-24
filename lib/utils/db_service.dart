import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

class DatabaseService {
  User? userCourant = FirebaseAuth.instance.currentUser;
  
  Future<String?> addUser({
    required nomComplet,
    required profil, 
    required dateDeNaissance, 
    required lieuDeNaissance, 
    required cni, 
    // required password,
  }) async {
    try {
      User? userCourant = FirebaseAuth.instance.currentUser;
      CollectionReference users = FirebaseFirestore.instance.collection(('users'));
      await users.doc(userCourant?.uid).set({
        "nom": nomComplet,
        "profil": profil,
        "date_de_naissance": dateDeNaissance,
        "lieu_de_naissance": lieuDeNaissance,
        "cni": cni,
        "numero_tel": userCourant!.phoneNumber,
        // "password": password,
      }, SetOptions(merge: true));

      return "Succes";
    } catch(e) {
      return "Erreur en ajoutant les donnees utilisateurs: $e";
    }
  }

  Future<Map<String, dynamic>> getCurrentUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection("users")
        .doc(user?.uid).get();
      if(snapshot.exists) {
        return snapshot.data() as Map<String, dynamic>;
      } else {
        throw("Donnees inaccessibles");
      }
    } catch(e) {
      print('\nErreur rencontrer en recuperant les donnees:$e\n');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getUserData(String userId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
        .collection("users").doc(userId).get();
      if(snapshot.exists) {
        return snapshot.data() as Map<String, dynamic>;
      } else {
        throw("Donnees inaccessibles");
      }
    } catch(e) {
      print('\nErreur rencontrer en recuperant les donnees:$e\n');
      rethrow;
    }
  }
}
