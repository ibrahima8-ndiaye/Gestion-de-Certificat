
import 'package:steel_crypt/steel_crypt.dart';

// var key = Key.fromSecureRandom(32);
// var iv = IV.fromSecureRandom(16);
// String encryptPassword(String password) {
//   final encrypter = Encrypter(AES(key));

//   final encrypted = encrypter.encrypt(password, iv: iv);
//   final decrypted = encrypter.decrypt(encrypted, iv: iv);

//   print(decrypted); // Lorem ipsum dolor sit amet, consectetur adipiscing elit
//   print(encrypted.base64); // R4PxiU3h8YoIRqVowBXm36ZcCeNeZ4s1OvVBTfFlZRdmohQqOpPQqD1YecJeZMAop/hZ4OxqgC1WtwvX/hP9mw==
//   return encrypted.base64;
// }

// String decryptPassword(String encryptedPassword) {
//   final encrypter = Encrypter(AES(key));
//   final decrypted = encrypter.decrypt64(encryptedPassword, iv: iv);
  
//   print(decrypted);
//   return decrypted;
// }

// final algorithm = Sha256();
var keyGen = CryptKey();
var iv16 = keyGen.genDart(len: 16);
 var passHash = PassCrypt.scrypt();
// Data to be hashed  
// Compute the hash
String encryptPassword(String password) {
  // final data = utf8.encode(password);
  // final hash = await algorithm.hash(data);
  
  // print('Hash: ${hash.bytes}');
  // return hash.bytes;
  print('Password hash (scrypt):');
  var hash3 = passHash.hash(salt: iv16, inp: 'words'); //perform hash
  print(hash3);
  return hash3;
}

decryptPassword(String encryptedPassword) {
  
}

bool verifierPassword(String password, String encryptedPassword) {
  return passHash.check(salt: iv16, plain: password, hashed: encryptedPassword);
  // final hash = encryptPassword(password);
  // return hash == encryptedPassword;
}

// Future<bool> verifierPassword(String password, String encryptedPassword) async {
//   // Map<String, dynamic>? donnees = await DatabaseService().getUserCourant();
//   // if(donnees != null) {
//   // String decryptedPassword = decryptPassword(donnees['password']);
//   String decryptedPassword = decryptPassword(encryptedPassword);
//   return decryptedPassword == password;
// }