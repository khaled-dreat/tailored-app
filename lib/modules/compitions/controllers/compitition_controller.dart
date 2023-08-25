import 'dart:developer';

import 'package:get/get.dart';
import 'package:tailored/local/cache_helper.dart';

import '../API/api_client.dart';
import '../core/show_dialog.dart';
import '../models/player.dart';
import '../models/quiz.dart';
import '../screens/quiz/quiz_screen.dart';
import '../sevices/firebase_fireStore/firebase_service.dart';

enum CompitionStatus {
  waitting,
  completed,
  empty,
}

class CompitionController extends GetxController {
  late List<Competition> competitions;
  late List<Competition> waittingForUsersCompetitions;
  bool isWaittingAnotherPlayer = false;
  final RxBool isLoading = true.obs;
  late List<Player> players;
  String get matchIdFirebase => firestoreService.matchFirebaseId;

  String competitionId = '';
  final FirestoreService firestoreService;

  CompitionController(this.firestoreService);
  late String token;
  late String name;
  late String id;
  @override
  void onInit() async {
    await initCompititions();
    super.onInit();
  }

  initCompititions() async {
    token = await CacheHelper.getData(key: 'token');
    name = await CacheHelper.getData(key: 'name');
    id = CacheHelper.getData(key: 'id').toString();

    try {
      isLoading.value = true;
      var competitionsData = await getCompetitionListFromApi();
      firestoreService.storeCompetitionsInFirestore(competitionsData);

      competitions = competitionsData
          .map((compitition) => Competition.fromJson(compitition))
          .toList();

      log('getCompetitionListFromApi Successful');
      isLoading.value = false;
      notifyChildrens();
    } catch (e) {
      log('getCompetitionListFromApi get error with $e');
    }
  }

  getMatchStatus(matchId) {
    return firestoreService.listenToMatch(matchId);
  }

  // Player getTheWinner(Competition quiz) {
  //   if (quiz.players[0].score > quiz.players[1].score) {
  //     return quiz.players[0];
  //   } else {
  //     return quiz.players[1];
  //   }
  // }

  joinCompetition(String compeId, context,) async {
    isLoading.value = true;
    var matchStatus = await firestoreService.joinCompetition(compeId);
    competitionId = compeId;
    if (matchStatus == 'start now') {
      isLoading.value = false;
      await Future.delayed(const Duration(seconds: 1), () async {
        Get.to(() => const QuizScreen());
      });
    } else {
      competitionId = compeId;
      isLoading.value = false;
      ShowDialog.showMyDialog(context,
          title: 'Warning',
          discription: 'please wait until another player join',
          choiceTrue: 'Got it',
          onChoiceTrue: () {});
    }
  }

  cancelMatch(String competitionId, userId) async {
    await firestoreService.cancelMatch(competitionId, userId);
  }

  Future<void> setAnyOneCancelFalse(competitionId) async {
    await firestoreService.setAnyOneCancelFalse(competitionId);
  }
}
