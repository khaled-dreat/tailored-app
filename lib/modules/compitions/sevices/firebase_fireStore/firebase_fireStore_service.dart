import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/player.dart';

//var quizId = 'upg4RS80S5aLaKpCS11Z';

abstract class FirestoreService1 {
  Stream<DocumentSnapshot<Map<String, dynamic>>> getQuizData(String quizId);
  Future<void> joinWaitingRoom(String quizId, Player player);
  Future<void> exitQuiz(String quizId);
  Future<void> startQuiz();
  Future<void> joinQuiz();
 // FirebaseAuth _f=
 // Future<void> getQuizWinner(String quizId);
}

class QuizWaitingRoom  implements FirestoreService1 {

  FirebaseFirestore get myFirebase => FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get quizesRef =>
      myFirebase.collection('quizes');

  @override
  Stream<DocumentSnapshot<Map<String, dynamic>>> getQuizData(
      String quizId) async* {
    final doc = quizesRef.doc(quizId).snapshots();
    yield* doc;
  }

  @override
  Future<void> joinWaitingRoom(String quizId, Player currentPlayer) async {
    await quizesRef.doc(quizId).update({
      'players': {
        'data.$currentPlayer.userId': currentPlayer.toJson(),
      }
    });
  }

  @override
  Future<void> exitQuiz(String quizId) async {
    await quizesRef.doc(quizId).delete();
  }
  
  @override
  Future<void> joinQuiz() {
    // TODO: implement joinQuiz
    throw UnimplementedError();
  }
  
  @override
  Future<void> startQuiz() {
    // TODO: implement startQuiz
    throw UnimplementedError();
  }
  
}
class QuizWaitingRoom1 {
  final CollectionReference waitingRoomRef =
      FirebaseFirestore.instance.collection('waitingRoom');

  // Join the waiting room
  Future<void> joinWaitingRoom(Player player) async {
    // Add the player to the waiting room collection
    await waitingRoomRef.doc(player.id as String?).set(player.toJson());
  }

  // Check if there are two players in the waiting room
  Future<bool> checkIfTwoPlayersReady() async {
    // Get all the documents in the waiting room collection
    QuerySnapshot snapshot = await waitingRoomRef.get();

    // Check if there are at least two players in the waiting room
    return snapshot.docs.length >= 2;
  }

  // Start the quiz when two players are ready
  Future<void> startQuiz() async {
    // Get the players in the waiting room
    QuerySnapshot snapshot = await waitingRoomRef.limit(2).get();

    // Remove the players from the waiting room
    for (DocumentSnapshot doc in snapshot.docs) {
      await doc.reference.delete();
    }
    
    // Start the quiz with the two players
    Player player1 = Player.fromJson(snapshot.docs[0].data() as Map<String,dynamic>);
    Player player2 = Player.fromJson(snapshot.docs[1].data()as Map<String,dynamic>);
    
    // Start the quiz with player1 and player2
   // await joinPlayersToQuiz(player1, player2);
  }
}

