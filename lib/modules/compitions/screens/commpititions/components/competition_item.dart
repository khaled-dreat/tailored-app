import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/compitition_controller.dart';
import '../../../core/constants.dart';
import '../../../models/quiz.dart';
import 'list_of_players.dart';

class CompetitionItem extends StatelessWidget {
  CompetitionItem({
    Key? key,
    required this.competition,
    required this.onTap,
    required this.isWitting,
  }) : super(key: key);
  void Function()? onTap;
  Competition competition;
  bool isWitting;
  
  @override
  Widget build(BuildContext context) {
    CompitionController competitionController = Get.find<CompitionController>();

    return InkWell(
      onTap:onTap ,
      
      child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(kDefaultPadding * 0.75),
        margin: const EdgeInsets.all(kDefaultMargin * 0.75),
        decoration: BoxDecoration(
          border: Border.all(),
          gradient: kPrimaryGradient,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        child: Column(
          children: [
            Text(competition.name),
            const Divider(
              color: Colors.white,
            ),
            Image.network(competition.image,),
            const SizedBox(
              width: 20,
            ),
            ListOfPlayers(quiz: competition),
             if(isWitting)    const SizedBox(
              width: 20,
            ),
           if(isWitting) const Text('waitting for another player ')
            // if (competition.players.length < 2)
            //   Text(
            //       'waitting for ${competition.players.isEmpty ? 'players' : 'a player'} ..'),
          ],
        ),
      ),
    );
  }
}
