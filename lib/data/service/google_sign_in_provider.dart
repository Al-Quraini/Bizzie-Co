import 'package:bizzie_co/data/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'authentication_service.dart';
import 'firestore_service.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future googleLogin() async {
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;

      bool isNewUser = false;
      _user == googleUser;

      final googleAuth = await googleUser.authentication;

      final credential = auth.GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      final auth.UserCredential authResult =
          await AuthenticationService().firebaseSignIn(credential);

      // if the user exists, this will return null
      final auth.User? user = authResult.user;

      // Here to check isNewUser OR Not
      if (authResult.additionalUserInfo!.isNewUser) {
        if (user != null) {
          isNewUser = true;
          User user = User(
              timestamp: DateTime.now(),
              email: AuthenticationService().getUser()!.email!,
              uid: AuthenticationService().getUser()!.uid,
              numOfConnections: 0);

          // add new use to the database
          await FirestoreService().addUser(user: user);
        } // else just login
      }

      // after loggin, load user data from the database
      await FirestoreService()
          .loadUserData(userUid: AuthenticationService().getUser()!.uid);

      notifyListeners();

      return isNewUser;
    } catch (e) {
      return null;
    }
  }

  Future logout() async {
    if (_user != null) {
      await googleSignIn.disconnect();
      AuthenticationService().userSignOut();
    }
  }
}
