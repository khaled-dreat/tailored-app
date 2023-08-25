
import 'package:flutter/cupertino.dart';

import '../../../models/quiz.dart';

class ListOfPlayers extends StatelessWidget {
  const ListOfPlayers({
    super.key,
    required this.quiz,
  });

  final Competition quiz;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        // ...List.generate(
        //     quiz.players.length,
        //     (index) => PlayerItem(
        //         playerName: quiz.players[index].name,
        //         playerProfileImage: quiz.players[index].profileImage)),
      ],
    );
  }
}
