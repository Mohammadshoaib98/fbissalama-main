import 'package:alt_sms_autofill/alt_sms_autofill.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthBase {
  User? get currentUser;

  Stream<User?> authStateChanges();

  Future<User?> loginWithEmailAndPassword(String email, String password);

  Future<User?> signUpWithEmailAndPassword(String email, String password);

  Future<void> addUser(String number, String pos, String password);

  Future<void> initSmsListener();

  Future<void> logout();
}

class Auth implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  @override
  Future<User?> loginWithEmailAndPassword(String email, String password) async {
    final userAuth = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return userAuth.user;
  }

  @override
  Future<User?> signUpWithEmailAndPassword(
      String email, String password) async {
    final userAuth = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return userAuth.user;
  }

  @override
  Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();

  @override
  User? get currentUser => _firebaseAuth.currentUser;

  @override
  Future<void> logout() async => await _firebaseAuth.signOut();

  @override
  Future<void> addUser(String number, String pos, String password) async =>
      await _firestore.collection('users').add({
        'Position': pos,
        'Number': number,
        'Password': password,
      }).then((value) {
        // if (signedInUser!= null) {
      });

  @override
  Future<String?> initSmsListener() async {
    String? commingSms;
    try {
      return commingSms = await AltSmsAutofill().listenForSms;
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }
  
}
