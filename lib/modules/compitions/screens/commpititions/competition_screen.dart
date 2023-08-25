import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

import '../../controllers/compitition_controller.dart';
import '../../core/constants.dart';
import '../quiz/quiz_screen.dart';
import 'components/competition_item.dart';

class CompetitionsList extends StatefulWidget {
  const CompetitionsList({super.key});

  @override
  State<CompetitionsList> createState() => _CompetitionsListState();
}

class _CompetitionsListState extends State<CompetitionsList> {
  CompitionController competitionController = Get.find<CompitionController>();

  String matchId = '';
  bool iswitting = false;

  @override
  Widget build(BuildContext ctx) {
    return Obx(() {
      return Stack(
        children: [
          if (competitionController.isLoading.value)
            const Center(child: CircularProgressIndicator()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                    stream: matchId == ''
                        ? null
                        : competitionController.getMatchStatus(
                            competitionController.matchIdFirebase),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (matchId != '') {
                          var data = snapshot.data!.data();
                          if (data!['players'].cast<List>().length == 2) {
                            SchedulerBinding.instance
                                .addPostFrameCallback((_) {
                              Get.to(
                                () => const QuizScreen(),
                              );
                              // add your code here.
                            });
                          }
                        }
                      }
                      if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                            child: CircularProgressIndicator());
                      } else {
                        return Expanded(
                          child: ListView.builder(
                              itemCount:
                                  competitionController.competitions.length,
                              itemBuilder: (context, index) {
                                return CompetitionItem(
                                    isWitting: iswitting,
                                    onTap: () async {
                                      await competitionController
                                          .joinCompetition(
                                              competitionController
                                                  .competitions[index].id,
                                              ctx
                                              // competitionController
                                              // .emptyCompetitions[index].id,
                                              );
                                      setState(() {
                                        iswitting = !iswitting;
                                        matchId = competitionController
                                            .competitions[index].id;
                                      });
                                      //Get.to(QuizScreen(quizQuestions: quizQuestions11));
                                    },
                                    competition: competitionController
                                        .competitions[index]);
                              }),
                        );
                      }
                    }),
              ],
            ),
          ),
        ],
      );
    });
  }
}
