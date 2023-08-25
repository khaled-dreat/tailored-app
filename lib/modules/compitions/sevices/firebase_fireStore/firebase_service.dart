import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../local/cache_helper.dart';
import '../../models/player.dart';

class FirestoreService {
  final CollectionReference _competitionsCollection =
      FirebaseFirestore.instance.collection('competitions');

  final CollectionReference _questionsCollection =
      FirebaseFirestore.instance.collection('questions');

  final CollectionReference _scoresCollection =
      FirebaseFirestore.instance.collection('scores');

  final CollectionReference _matchesCollection =
      FirebaseFirestore.instance.collection('matches');

      late String currentId;
      late var name;
      late var token;

  FirebaseAuth get _auth => FirebaseAuth.instance;
   String matchFirebaseId='';
  setMatchFirebaseId(String id) {
    matchFirebaseId = id;
    log('matchFirebaseId is $id');
  }

  // Method to fetch data from the API and store it in Firestore
  Future<void> storeCompetitionsInFirestore(competitionsData) async {
    // Loop through competitionsData and create Firestore documents
    for (var competition in competitionsData) {
      try {
        await _competitionsCollection.doc(competition['id']).set(competition);
        log('storeCompetitionsInFirestore successful');
      } catch (e) {
        log('storeCompetitionsInFirestore has eror with $e`');
      }
    }
  }

  Future<void> storeQuestionsInFirestore(questionsData) async {
    // Loop through competitionsData and create Firestore documents
    for (var question in questionsData) {
      await _questionsCollection.doc(question['id']).set(question);
    }
  }
//   Future<void> submitScoretoFirebase(score) async {
//     // Loop through competitionsData and create Firestore documents
//  await _matchesCollection.doc(matchFirebaseId).update({
//       'players': FieldValue.arrayUnion([currentUser.toJson()])
//     });

//   }

  // Method to fetch competitions from Firestore
  Stream<QuerySnapshot> getCompetitionsFromFirestore() {
    return _competitionsCollection.snapshots();
  }

  // Method to fetch questions for a specific competition from Firestore
  Stream<QuerySnapshot> getQuestionsForCompetitionFromFirestore(
      String competitionId) {
    return _questionsCollection
        .where('competition_id', isEqualTo: competitionId)
        .snapshots();
  }

  Future<void> submitAnswer(String questionId, String answer) async {
    // final userId = currentId;
    const userId = '';
    await _questionsCollection
        .doc(questionId)
        .collection('answers')
        .add({'user_id': userId, 'answer': answer});
  }

  // Method to listen to real-time updates for a specific competition
  // Stream<DocumentSnapshot> listenToCompetition(String competitionId) {
  //   return _matchesCollection.doc(competitionId).snapshots();
  // }
  Stream<DocumentSnapshot> listenToMatch(String matchId) {
    return _matchesCollection.doc(matchId).snapshots();
  }

  // Method to listen to real-time updates for a specific question
  Stream<DocumentSnapshot> listenToQuestion(String questionId) {
    return _questionsCollection.doc(questionId).snapshots();
  }

  Future joinCompetition(String competitionId) async {
     token = await CacheHelper.getData(key: 'token');
    name = await CacheHelper.getData(key: 'name');
     currentId = CacheHelper.getData(key: 'id').toString();

    
    try {
      if (await checkPlayersReady(competitionId)) {
        var snapshot = await _competitionsCollection.doc(competitionId).get();
        final Player matchCreater =
            Player.fromJson(snapshot['players'][0] as Map<String, dynamic>);
        if (matchCreater.id == currentId) {
          // if (matchCreater.id == '1') {
          return;
        } else {
          
          await _competitionsCollection.doc(competitionId).update({
            'players': FieldValue.arrayRemove(['players']),
          });
          await joinMatch(competitionId, matchCreater);
          
        }
        // return matchStatus =='' ? '':'start now';
        return 'start now';
      } else {
        Player currentUSer = Player(
            id: currentId,
            name:name,
            profileImage: '',
            score: 0);
        // TODO get CurrentUserInfo
        await createMatch(competitionId, currentUSer);

        setMatchFirebaseId(competitionId + currentUSer.id);
        log('joinCompetition successful');

        return 'wait';
      }
    } catch (e) {
      log('joinCompetition has error with $e');
    }
  }

  Future createMatch(competitionId, Player currentUser) async {
    try {
      await _competitionsCollection.doc(competitionId).update({
        'players': FieldValue.arrayUnion([currentUser.toJson()])
      });
      setMatchFirebaseId(competitionId + currentUser.id);
      await _matchesCollection.doc(competitionId + currentUser.id).set({
        'competition': competitionId,
        'players': [currentUser.toJson()],
        'isCancelled': false,
        'winner': ''
      });
      log('createMatch successful');
    } catch (e) {
      log('createMatch has error with $e');
    }
  }

  Future joinMatch(competitionId, Player matchCreater) async {
    setMatchFirebaseId(competitionId + matchCreater.id);
    Player p2 = Player(
        id: currentId,
        name:name,
        profileImage: '',
        score: 12);
    try {
      await _matchesCollection.doc(competitionId + matchCreater.id).update({
        'players': FieldValue.arrayUnion([p2.toJson()])
      });
      log('joinMatch successful');
    } catch (e) {
      log('joinMatch has eror with $e');
    }
  }

  Future<void> storeTheScore(String competitionId) async {
    try {
      final userId = currentId;
      await _scoresCollection.doc(userId).update({
        'myScore': FieldValue.arrayUnion([userId])
      });
      log('joinCompetition successful');
    } catch (e) {
      log('joinCompetition has error with $e');
    }
  }

  Future<int> getNumberOfPlayers(String competitionId) async {
    try {
      final competitionDoc =
          await _competitionsCollection.doc(competitionId).get();
      if (competitionDoc.exists) {
        final participants = competitionDoc['players'] as List<dynamic>;
        log('num of players ${participants.length}');
        return participants.length;
      } else {
        return 0;
      }
    } catch (e) {
      return 0;
    }
  }

  Future<List<Player>> getThePlayers() async {

    log('matchFirebaseId when get the plers is $matchFirebaseId');
    final matchDoc = await _matchesCollection.doc(matchFirebaseId).get();
    if (matchDoc.exists) {
      final playersData = matchDoc['players'] as List;
      var players = playersData.map((e) => Player.fromJson(e)).toList();
      return players;
    } else {
      throw Exception('Competition not found');
    }
  }

  Future<bool> checkPlayersReady(competitionId) async {
    // Check if there are at least two players in the waiting room
    return await getNumberOfPlayers(competitionId) > 0;//TODO
  }

  // Start the quiz when two players are ready
  Future<void> startQuiz(competitionId) async {
    try {
      if (await checkPlayersReady(competitionId)) {
        final userId = currentId;
        QuerySnapshot snapshot = await _competitionsCollection.limit(1).get();
        snapshot.docs[0].data();
        await removeUserFromCompetition(competitionId, userId);
      }
      log('start the quiz is successful');
    } catch (e) {
      log('start the quiz has error with $e');
    }
  }

  Future<void> removeUserFromCompetition(
      String competitionId, String userId) async {
    try {
      await _competitionsCollection.doc(competitionId).update({
        'players': FieldValue.arrayRemove([userId]),
      });
    } catch (e) {
      log('error when remove users with $e');
    }
  }

  Future<void> removematch() async {
    try {
      log(matchFirebaseId);
      await _matchesCollection.doc(matchFirebaseId).delete();
      log('removematch su');
    } catch (e) {
      log('error when removematch with $e');
    }
  }

  Future<void> cancelMatch(String competitionId, userId) async {
    try {
      await _competitionsCollection
          .doc(competitionId)
          .update({'anyoneCancelled': true});
      await _competitionsCollection.doc(competitionId).update({
        'players': FieldValue.arrayRemove([userId]),
      });

      log('cancel match successful');
    } catch (e) {
      log('error when cancel match');
    }
  }

  Future<void> setAnyOneCancelFalse(
    String competitionId,
  ) async {
    try {
      await _competitionsCollection
          .doc(competitionId)
          .update({'anyoneCancelled': false});

      log('cancel match successful');
    } catch (e) {
      log('error when cancel match');
    }
  }
}
