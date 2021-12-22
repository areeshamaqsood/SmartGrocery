import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// import 'back.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'firebase_user_provider.dart';

// import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

// export 'anonymous_auth.dart';
// export 'apple_auth.dart';
export 'email_auth.dart';
export 'google_auth.dart';

// final FirebaseAuth _auth = FirebaseAuth.instance;
// final GoogleSignIn _googleSignIn = GoogleSignIn();

// Future<UserCredential> signInWithGoogle() async {
//   // Trigger the authentication flow
//   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

//   // Obtain the auth details from the request
//   final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

//   // Create a new credential
//   final credential = GoogleAuthProvider.credential(
//     accessToken: googleAuth?.accessToken,
//     idToken: googleAuth?.idToken,
//   );

//   // Once signed in, return the UserCredential
//   return await FirebaseAuth.instance.signInWithCredential(credential);
// }
/// Tries to sign in or create an account using Firebase Auth.
/// Returns the User object if sign in was successful.
// final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();
String name;
String email;
String imageUrl;
Future<UserCredential> signInWithGoogle() async {
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;
  final AuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );
  // final UserCredential authResult = await _auth.signInWithCredential(credential);
  return await FirebaseAuth.instance.signInWithCredential(credential);
  // final User user = authResult.user;
  // assert(user.email != null);
  // assert(user.name != null);
  // name = user.name;
  // email = user.email;
  // if (name.contains(" ")) {
  //   name = name.substring(0, name.indexOf(" "));
  // }
  // assert(!user.isAnonymous);
  // assert(await user.getIdToken() != null);
  // final User currentUser = await _auth.currentUser();
  // assert(user.uid == currentUser.uid);

  // return 'Successfully loggedin: $user';
}

void signOutGoogle() async {
  await googleSignIn.signOut();
}
// Future<User> signInOrCreateAccount(
//     BuildContext context, Future<UserCredential> Function() signInFunc) async {
//   try {
//     final userCredential = await signInFunc();
//     await maybeCreateUser(userCredential.user);
//     return userCredential.user;
//   } on FirebaseAuthException catch (e) {
//     ScaffoldMessenger.of(context).hideCurrentSnackBar();
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Error: ${e.message}')),
//     );
//     return null;
//   }
// }

// Future signOut() => FirebaseAuth.instance.signOut();

// Future resetPassword({String email, BuildContext context}) async {
//   try {
//     await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
//   } on FirebaseAuthException catch (e) {
//     ScaffoldMessenger.of(context).hideCurrentSnackBar();
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Error: ${e.message}')),
//     );
//     return null;
//   }
//   ScaffoldMessenger.of(context).showSnackBar(
//     const SnackBar(content: Text('Password reset email sent!')),
//   );
// }

// String get currentUserEmail => currentUser?.user?.email ?? '';

// String get currentUserUid => currentUser?.user?.uid ?? '';

// String get currentUserDisplayName => currentUser?.user?.displayName ?? '';

// String get currentUserPhoto => currentUser?.user?.photoURL ?? '';

// DocumentReference get currentUserReference => currentUser?.user != null
    // ? UsersRecord.collection.doc(currentUser.user.uid)
    // : null;
