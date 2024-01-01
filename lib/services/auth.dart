import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wits_bus/models/Users.dart';

import 'Database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Users? _driver(User driver) {
    return driver != null ? Users(uid: driver.uid) : null;
  }

  Stream<Users?> get user {
    return _auth.authStateChanges().map((User? driver) => _driver(driver!));
  }

  Future registerDriver(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);

      User? driver = result.user;

      await DatabaseService(uid: driver!.uid).uploadDriver('anon', 'null');

      return _driver(driver);
    } catch (e) {
      return null;
    }
  }

  Future registerUser(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);

      User? driver = result.user;

      return _driver(driver!);
    } catch (e) {
      print(e);
      return null;
    }
  }



  Future signIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      User? driver = result.user;


      return _driver(driver!);
    } catch (e) {
      print(e);
      return null;
    }
  }


  Sign_in_google() async {
    //begin sign in interactive process

    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    //obtain auth details

    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    //create new cridential for user

    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );


    return await FirebaseAuth.instance.signInWithCredential(credential);


  }


  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
