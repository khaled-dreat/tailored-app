// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tailored/modules/home/screen/home.dart';

import '../../controllers/compitition_controller.dart';
import '../../controllers/match_controller.dart';
import '../../core/show_dialog.dart';
import '../../sevices/firebase_fireStore/firebase_service.dart';
import 'components/body.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  MatchController matchController =
      Get.put(MatchController(Get.find<FirestoreService>()),permanent: true);

  @override
  void initState()  {
    initdata();
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // MatchController matchController = Get.find<MatchController>();

    CompitionController compitionController = Get.find<CompitionController>();

    //matchController.initQuestions(quizQuestions);
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: _buildMyAppBar(context, matchController, compitionController),
        body: Obx(()
            // future: matchController
            // .fetchMatchMaterial(compitionController.competitionId),
            {
          // if (snapshot.hasData) {
          //   final data = snapshot.data!.data();

          //   if (data!['isCancelled']) {
          //     showDialogWhenUserCancelMatch(context, 'c1');
          //   }
          // }
          if (matchController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return const Body();
          }
        }));
  }

  AppBar _buildMyAppBar(context, MatchController controller,
      CompitionController compitionController) {
    return AppBar(
      // Fluttter show the back button automatically
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
          onPressed: () {
            ShowDialog.showMyDialog(context,
                title: 'Warning !!',
                discription:
                    'Are you sure you want to leave the quiz, you will lose your score !',
                choiceTrue: 'yes', onChoiceTrue: () async {
              //  await compitionController.cancelMatch('c1', 'currentUser.uid1');
              await controller.removematch();
              Get.offAll(() => const Home());
            }, choiceFalse: 'cancel', onChoiceFalse: () {});
          },
          icon: const Icon(Icons.arrow_back)),
      actions: [
        TextButton(
          onPressed: controller.nextQuestion,
          child: const Text("Skip"),
        )
      ],
    );
  }

  void initdata() async {
    await matchController.fetchMatchMaterial();
    await matchController.getThePlayers();
  }
}

Future<void> showDialogWhenUserCancelMatch(
    BuildContext context, competitionId) {
  CompitionController compitionController = Get.find<CompitionController>();
  return Future.delayed(Duration.zero, () {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Ops'),
          content: const Text('Your friend canccel the match!'),
          actions: [
            TextButton(
              onPressed: () async {
                await compitionController.setAnyOneCancelFalse(competitionId);
                Navigator.pop(context);
                Get.off(() => const Home());
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  });
}
