import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../home/screen/home.dart';
import '../../controllers/compitition_controller.dart';
import '../../controllers/match_controller.dart';
import '../../core/constants.dart';
import '../welcome/components/custom_button.dart';

class ScoreScreen extends StatelessWidget {
  const ScoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    MatchController matchController = Get.find<MatchController>();
    CompitionController quizController = Get.find<CompitionController>();
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          SvgPicture.asset("assets/icons/bg.svg", fit: BoxFit.fill),
          Column(
            children: [
              const Spacer(flex: 3),
              const Divider(
                color: Colors.white,
              ),
              Text(
                "Scores",
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(color: const Color(0xFF00FFCB)),
              ),
              const Divider(
                color: Colors.white,
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text(
                        matchController.players[0].name,
                        //     "${qnController.correctAnswer * 10}/${qnController.questions.length * 10}",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(color: kSecondaryColor),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        matchController.players[0].score.toString(),
                        // "${_qnController.correctAns * 10}/${_qnController.questions.length * 10}",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(color: kSecondaryColor),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        matchController.players[1].name,
                        // "${_qnController.correctAns * 10}/${_qnController.questions.length * 10}",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(color: kSecondaryColor),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        matchController.players[1].score.toString(),
                        //TODO From FIrebase
                        // "${_qnController.correctAns * 10}/${_qnController.questions.length * 10}",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(color: kSecondaryColor),
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              Text.rich(TextSpan(
                text: 'The winner is ',
                style: const TextStyle(fontSize: 22),
                children: [
                  TextSpan(
                      text: matchController.players[0].score >
                              matchController.players[1].score
                          ? matchController.players[0].name
                          : matchController.players[1].name,
                      style: const TextStyle(color: Color(0xFF00FFCB), fontSize: 25)),
                ],
              )),
              const Spacer(flex: 1),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomButton(
                  text: 'Back to Quizes Screen',
                  onTap: () async {
                    await matchController.removematch();
                    
                    Get.offAll(()=> const Home());
                  },
                ),
              ),
              const Spacer(flex: 3)
            ],
          )
        ],
      ),
    );
  }
}
