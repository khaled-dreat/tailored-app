import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/match_controller.dart';
import '../../../core/constants.dart';
import '../../../models/match_material.dart';
import 'option.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({
    Key? key,
    // it means we have to pass this
    required this.matchMaterial,
  }) : super(key: key);

  final MatchMaterial matchMaterial;

  @override
  Widget build(BuildContext context) {
    MatchController controller = Get.find<MatchController>();
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      padding: const EdgeInsets.all(kDefaultPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: [
          if (matchMaterial.question.type == 'TEXT') const Spacer(),
          if (matchMaterial.content[0].file != null)
            Image.network(matchMaterial.content[0].file!),
          Text(
            matchMaterial.id,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: kBlackColor),
          ),
          if (matchMaterial.question.type == 'TEXT') const Spacer(),
          if (matchMaterial.question.type != 'TAPPING' &&
              matchMaterial.question.type != 'MULTIPLE_CHOICE')
            TextFormField(
              decoration: InputDecoration(
                hintText: 'write the answer here ..',
                hintStyle: const TextStyle(color: Colors.black),
                filled: true,
                fillColor: Colors.grey.shade300,
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color:
                        Colors.blue, // Change this to your desired border color
                    width: 2.0,
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color:
                        Colors.blue, // Change this to your desired border color
                    width: 2.0,
                  ),
                ),
              ),
            ),
          const SizedBox(height: kDefaultPadding / 2),
          if (matchMaterial.question.type == 'TAPPING' ||
              matchMaterial.question.type == 'MULTIPLE_CHOICE')
            Expanded(
              child: ListView.builder(
                itemCount: matchMaterial.question.options.length,
                itemBuilder: (context, index) => Option(
                  index: index,
                  text: matchMaterial.question.options[index],
                  press: () => controller.checkAnswer(matchMaterial, index),
                ),
              ),
            ),
          // const Spacer(),
          if (matchMaterial.question.type != 'TAPPING' &&
              matchMaterial.question.type != 'MULTIPLE_CHOICE')
            TextButton(onPressed: () {
//TOdo
              controller.nextQuestion();
            }
            , child: const Text('Submit')),
          // const Spacer(),
        ],
      ),
    );
  }
}
