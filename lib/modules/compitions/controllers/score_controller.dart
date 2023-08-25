import 'package:get/get.dart';

import '../API/api_client.dart';

class ScoreController extends GetxController {
  sendMyScoreToFirebase() {}
  sendMyScoreToBackend(matchId, score) async {
    await submitMatch(matchId, score);
  }
}
