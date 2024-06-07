import 'package:business_app/animation.dart';
import 'package:business_app/models/UserModel.dart';
import 'package:business_app/pages/home/home.dart';
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

  bool loadButton = false;

  bool get viewPassword => _viewPassword;
  bool get isLoading => _isLoading;
  bool get isLogged => _isLogged;


  void setLoadButton(bool val){
    loadButton = val;
    notifyListeners();
  }

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
  Future<User?> signInWithGoogle(BuildContext context) async {
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

        await createUserAccount("", name!, email!, phone!);

        Navigator.push(context, CustomPageRoute(page: Home()));

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
      print("jjjjjjjjjj");
      // UserCredential userCredential =
      //     await FirebaseAuth.instance.signInWithEmailAndPassword(
      //   email: email,
      //   password: password,
      // );

        final userInstance = UserModel(
          password: password,
          email: email,
          name: name,
          uid: FirebaseAuth.instance.currentUser!.uid,
          phoneNumber: phoneNumber);

          final userData = userInstance.toJson();

          await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(userData).then((val){
            debugPrint("SUCCESSFULL ");
          });


    } on FirebaseAuthException catch (e) {
      if (e.code == 'network-request-failed') {
        // Handle network error
        print('Network error: ${e.message}');
      } else {
        // Handle other errors
        print('Error: ${e.message}');
      }
    }

  }



  Future<void> loginWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
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
