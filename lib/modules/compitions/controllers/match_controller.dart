import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../API/api_client.dart';
import '../models/match_material.dart';
import '../models/player.dart';
import '../screens/score/score_screen.dart';
import '../sevices/firebase_fireStore/firebase_service.dart';
import 'compitition_controller.dart';

// We use get package for our state management

class MatchController extends GetxController with SingleGetTickerProviderMixin {
  late AnimationController _animationController;

  late Animation _animation;
  Animation get animation => _animation;

  late PageController _pageController;
  PageController get pageController => _pageController;

  late List<MatchMaterial> _matchMaterial;

  List<MatchMaterial> get matchMaterial => _matchMaterial;

  RxBool isLoading = false.obs;
  bool _isAnswered = false;
  RxBool isFinished = false.obs;
  bool get isAnswered => _isAnswered;

  late int _correctAnswer;
  int get correctAnswer => _correctAnswer;

  late int _selectedAnswer;
  int get selectedAnswer => _selectedAnswer;

  final RxInt _questionNumber = 1.obs;
  RxInt get questionNumber => _questionNumber;

  int _numOfCorrectAnswers = 0;
  int get numOfCorrectAnswers => _numOfCorrectAnswers;

  late String winnerId;
  late String matchId;
  final FirestoreService firestoreService;
  MatchController(this.firestoreService);
  //late List<MatchMaterial> matchMaterials;
late var context;
  Future fetchMatchMaterial() async {
    isLoading.value = true;
    try {
      log('competitionId is  $compitionController.competitionId');

      var matchMaterialJson =
          await getMatchMaterialsFromApi('3WQHKyoaBEjuwcjjnYPqJF');
      _matchMaterial =
          matchMaterialJson.map((e) => MatchMaterial.fromJson(e)).toList();
      log('fetchMatchMaterial succse');
    } catch (e) {
      log('fetchMatchMaterial succsewith $e');
      rethrow;
    }

    isLoading.value = false;
  }

  late List<Player> players;
  CompitionController compitionController = Get.find<CompitionController>();

  String get matchIdFirebase => firestoreService.matchFirebaseId;

  @override
  // initQuestions(List<Question> questions) {
  //   _matchMaterial = questions;
  // }

  // called immediately after the widget is allocated memory
  @override
  void onInit() async {
    // await fetchMatchMaterial();
    // await getThePlayers();

    // Our animation duration is 60 s
    _animationController =
        AnimationController(duration: const Duration(seconds: 60), vsync: this);
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController)
      ..addListener(() {
        // update like setState
        update();
      });

    // start our animation
    // Once 60s is completed go to the next qn
    _animationController.forward().whenComplete(nextQuestion);
    _pageController = PageController();

    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    _animationController.dispose();
    _pageController.dispose();
  }

  void checkAnswer(MatchMaterial matchMaterial, int selectedIndex) {
    matchId = matchMaterial.id;
    // because once user press any option then it will run
    _isAnswered = true;
    _correctAnswer = int.parse(matchMaterial.question.answer[0]);
    _selectedAnswer = selectedIndex;

    if (_correctAnswer == _selectedAnswer) _numOfCorrectAnswers++;
    // It will stop the counter
    _animationController.stop();
    update();

    // Once user select an ans after 1s it will go to the next question
    _animationController.stop();
    Future.delayed(const Duration(seconds: 1), () {
      nextQuestion();
    });
  }

  void nextQuestion() async {
    if (_questionNumber.value != _matchMaterial.length) {
      _isAnswered = false;
      _pageController.nextPage(
          duration: const Duration(milliseconds: 250), curve: Curves.ease);

      // Reset the counter
      _animationController.reset();

      // Then start it again
      // Once timer is finish go to the next qn
      _animationController.forward().whenComplete(nextQuestion);
    } else {
      //await submitMatch(matchId, numOfCorrectAnswers * 10);
      // Get package provide us simple way to naviigate another page
      
       Get.offAll(() => const ScoreScreen());

      // SchedulerBinding.instance.addPostFrameCallback((_) {

      //   // add your code here.
      // });
    }
  }

  void updateTheQuestionNum(int index) {
    _questionNumber.value = index + 1;
  }

  Future getThePlayers() async {
    try {
      players = await firestoreService.getThePlayers();
      log('getThePlayers successful');
    } catch (e) {
      log('getThePlayers has an error with $e');
    }
  }

  Future removematch() async {
    try {
      await firestoreService.removematch();
      log('removematch successful');
    } catch (e) {
      log('removematch has an error with $e');
    }
  }
  
}
