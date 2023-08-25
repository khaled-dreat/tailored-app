// // ignore_for_file: avoid_print

// import 'dart:developer';
// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/foundation.dart';


// class UserProvider with ChangeNotifier {
//   final FirebaseFireStoreService _db = FirebaseFireStoreService();
//   final FirebaseAuthService _auth = FirebaseAuthService();
//   CollectionReference<Map<String, dynamic>> get usersRef =>
//       _db.myFirebase.collection('users');

//   get currentUserId => _auth.currentUser!.uid;

//   User? _currentUser;
//   User get currentUser => _currentUser!;

//   Future<void> initcurrentUserData() async {
//     try {
//       final doc = await getUserInfo(currentUserId);
//       _currentUser = User.fromJson(doc);
//       log('user  ${_currentUser?.userName} initialized successfully ');
//     } catch (e) {
//       log('user  initialized get error with $e ');
//     }
//   }

//   // Future<void> createUserInfo(String email, String userName) async {
//   //   User currentUser = User(
//   //     email: email,
//   //     userName: userName,
//   //     status: {'isOnline': true, 'lastSeen': DateTime.now()},
//   //     imageProfileUrl: '',
//   //     joinedAt: DateTime.now(),
//   //     bio: '',
//   //     userId: _auth.currentUser!.uid,
//   //   );
//   //   await usersRef.doc(_auth.currentUser!.uid).set(currentUser.toJson());
//   // }

//   Future getUserInfo(userId) async {
//     final doc = await usersRef.doc(userId).get();
//     return doc;
//   }

//   Stream<DocumentSnapshot<Map<String, dynamic>>> getUserInfoStream(
//       userId) async* {
//     final doc = usersRef.doc(userId).snapshots();
//     yield* doc;
//   }

//   Future<QuerySnapshot> searchForUser(String searchTerm) async {
//     Query searchQuery = usersRef
//         .where('userName', isGreaterThanOrEqualTo: searchTerm)
//         .limit(50);

//     QuerySnapshot searchResult = await searchQuery.get();
//     return searchResult;
//   }

//   Future<void> setUserActiveStatus(String userId, bool isActive) async {
//     final currentTimeStamp = DateTime.now().millisecondsSinceEpoch;
//     final userStatusRef = usersRef.doc(_auth.currentUser!.uid);

//     if (isActive) {
//       await userStatusRef.update({
//         'isOnline': true,
//         'lastSeen': currentTimeStamp,
//       });
//     } else {
//       await userStatusRef.update({
//         'isOnline': false,
//         'lastSeen': currentTimeStamp,
//       });
//     }
//   }


// }
