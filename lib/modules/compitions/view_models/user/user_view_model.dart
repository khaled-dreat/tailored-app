// import 'dart:async';
// import 'dart:developer';
// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:movie_app/view_models/user/user_provider.dart';
// import 'package:provider/provider.dart';

// import '../../models/user_model.dart';

// class UserViewModel with ChangeNotifier {
//   final UserProvider _userProvider;
//   UserViewModel(this._userProvider) {
//     initCurrentUserData();
//   }
//   bool isFetchingUserData = false;

//   static provider(context, {listen = false}) =>
//       Provider.of<UserViewModel>(context, listen: listen);

//   bool? isOnline = false;
//   User? user;

//   Stream? stream;
//   bool get isMe => currentUser.userId != _userProvider.currentUserId;

//   User get currentUser => _userProvider.currentUser;

//   Future<void> initCurrentUserData() async {
//      toggleisFetching();
//     await _userProvider.initcurrentUserData();
//      toggleisFetching();
//   }

//   toggleisFetching() {
//     isFetchingUserData = !isFetchingUserData;
//     log('toggleisFetching is $isFetchingUserData');
//     notifyListeners();
//   }

//   Future<void> getUserData(userId) async {
//     try {
//       final doc = await _userProvider.getUserInfo(userId);
//       user = User.fromJson(doc);
//     } catch (e) {
//       log('the error when get user data is :$e');
//     }
//   }

//   Stream<DocumentSnapshot<Map<String, dynamic>>> getUserStatus(userId) async* {
//     try {
//       final stream = _userProvider.getUserInfoStream(userId);
//       yield* stream;
//     } catch (e) {
//       log('this error when getUserStatus $e');
//       yield* const Stream.empty();
//     }
//   }

//   void initUserStatus(
//       AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
//     try {
//       final data = snapshot.data;
//       final user = User.fromJson(data);
//         isOnline = user.status['isOnline'];
//     } catch (e) {
//       log('here is the error $e');
//     }
//   }

//   Future<void> createUserInfo(String email, String userName) async {
//     await _userProvider.createUserInfo(email, userName);
//     notifyListeners();
//   }

//   Future<void> setUserActiveStatus(String userId, bool isActive) async {
//     await _userProvider.setUserActiveStatus(userId, isActive);
//     notifyListeners();
//   }

//   Future<void> updateProfile({
//     required String userName,
//     required String userId,
//     required String bio,
//     required File? image,
//   }) async {
//     await _userProvider.updateProfile(
//         userName: userName, bio: bio, image: image, userId: userId);
//     notifyListeners();
//   }
// }
