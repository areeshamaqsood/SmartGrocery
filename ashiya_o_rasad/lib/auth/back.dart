// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future maybeCreateUser(User user) async {
  // final userRecord = UsersRecord.collection.doc(user.uid);
  // final userExists = await userRecord.get().then((u) => u.exists);
  // if (userExists) {
  //   return;
  // }

  // final userData = createUsersRecordData(
  //   email: user.email,
  //   displayName: user.displayName,
  //   photoUrl: user.photoURL,
  //   uid: user.uid,
  //   createdTime: getCurrentTimestamp,
  // );

  // await userRecord.set(userData);
}
