import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:journal_app/models/user_models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final Ref ref;

  AuthService(this.ref);

  Future<UserCredential?> signIn(String email, String password) async {
    try {
      bool userExists = await checkUser(email);
      if (!userExists) {
        throw Exception("User does not exist. Please register first.");
      }

      final UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _saveUserState(true);
      return result;
    } on FirebaseAuthException catch (e) {
      throw Exception("Login Failed: $e.message");
    }
  }

  Future<UserCredential?> createUser(
    String username,
    String email,
    String password,
  ) async {
    try {
      final UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await addUserToDB(username, email, password);
      //await _saveUserState(true);
      return result;
    } catch (e) {
      throw Exception("Registration Failed: $e");
    }
  }

  Future<void> logoutUser() async {
    try {
      await _auth.signOut();
      await _saveUserState(false);
    } catch (e) {
      throw Exception("Logout Failed: $e");
    }
  }

  Future<void> addUserToDB(
    String username,
    String email,
    String password,
  ) async {
    try {
      UserModel userModel = UserModel(username: username, email: email);
      await _firestore.collection('users').add(userModel.userModelToMap());
    } catch (e) {
      throw Exception("Registration Failed: $e");
    }
  }

  Future<bool> checkUser(String email) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> user = await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .get();
      if (user.docs.isNotEmpty) {
        return true; // User exists
      } else {
        return false; // User does not exist
      }
    } catch (e) {
      throw Exception("Error in checkUser: $e");
    }
  }

  Future<void> _saveUserState(bool isLoggedIn) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', isLoggedIn);
    } catch (e) {
      throw Exception("Logout Failed: $e");
    }
  }

  Future<bool> _getUserState() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      bool isUserLoggedIn = prefs.getBool('isLoggedIn') ?? false;
      return isUserLoggedIn;
    } catch (e) {
      throw Exception("Logout Failed: $e");
    }
  }
}
