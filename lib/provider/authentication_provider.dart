import 'package:business_app/models/UserModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  // final FirestoreService _firestoreService = FirestoreService();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  bool _viewPassword = false;
  bool _isLoading = false;
  bool _isLogged = false;

  bool get viewPassword => _viewPassword;
  bool get isLoading => _isLoading;
  bool get isLogged => _isLogged;

  void toggleViewPassword() {
    _viewPassword = !_viewPassword;
    debugPrint("CLICKED TOGGLE EYE");
    notifyListeners();
  }

  void showLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  void setLogged(bool isLogged) {
    _isLogged = isLogged;
    notifyListeners();
  }

// google sign in
  Future<User?> signInWithGoogle() async {
    try {
      debugPrint("sign in start");
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        debugPrint('USER IS NULL');
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      // user details add to firebase
      if (user != null) {
        String? email = user.email;
        String? phone = user.phoneNumber;
        String? name = user.displayName;

        {
          // await addUserToFirebase(user, email!, phone!, name!);
        }
      }

      return user;
    } catch (e) {
      debugPrint("ERROR GOT : $e");
      return null;
    }
  }

// logout
  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }

  Future<void> createUserAccount(
    String password,
    String name,
    String email,
    String phoneNumber,
  ) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: "test@gmail.com",
        password: "password",
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'network-request-failed') {
        // Handle network error
        print('Network error: ${e.message}');
      } else {
        // Handle other errors
        print('Error: ${e.message}');
      }
    }

    // try {
    //   print("Started");

    //   await FirebaseAuth.instance
    //       .createUserWithEmailAndPassword(email: email, password: password);
    //   print("Started");

    //   final userInstance = UserModel(
    //       email: email,
    //       name: name,
    //       id: FirebaseAuth.instance.currentUser!.uid,
    //       phoneNumber: phoneNumber);

    //   final userData = userInstance.toJson();

    //   await FirebaseFirestore.instance
    //       .collection("users")
    //       .doc(FirebaseAuth.instance.currentUser!.uid)
    //       .set(userData);
    // } catch (error) {
    //   if (error is FirebaseAuthException) {
    //     // FirebaseAuthException
    //     print("uuuuu");
    //     print(error);
    //     // Get.snackbar("Authentication Error", error.message!);
    //   } else {
    //     print("aaaaaa");
    //     // General error
    //     print(error);
    //     // Get.snackbar("Something went wrong", "Error occurred: $error");
    //   }
    // }
  }

// // add user into firebase
//   Future<void> addUserToFirebase(
//       User user, String email, String name, String phoneNumber) async {
//     try {
//       final userModel = UserModel(
//           email: email, name: name, id: user.uid, phoneNumber: phoneNumber);

//       // convert usermodel into map
//       final Map<String, dynamic> userData = userModel.toMap();

//       await _firebaseFirestore.collection("users").doc(user.uid).set(userData);
//       Get.snackbar("Sucess", "Account created");
//     } catch (e) {
//       Get.snackbar("Error", "Message: $e");
//     }
//   }

  Future<void> signUpWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Handle successful sign-up, navigate to the next screen, etc.
      print('User signed up: ${userCredential.user!.uid}');
    } catch (e) {
      // Handle sign-up errors, display an error message, etc.
      print('Sign-up error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign-up failed: $e')),
      );
    }
  }
}
