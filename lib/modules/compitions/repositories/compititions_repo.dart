// ignore_for_file: public_member_api_docs, sort_constructors_first

import '../API/api_client.dart';
import '../sevices/firebase_fireStore/firebase_service.dart';

class CompetitionRepo {

  FirestoreService firestoreService;

  CompetitionRepo({
    required this.firestoreService,
  });

  Future<void> fetchCompetitionsFromApiAndStoreInFirestore() async {

    // Fetch competitions from API
    var competitionsData = await getCompetitionListFromApi();

    // Loop through competitionsData and create Firestore documents
    firestoreService.storeCompetitionsInFirestore(competitionsData);
  }

  Future<void> fetchQuestionsFromApiAndStoreInFirestore(
      String competitionId) async {

    // Fetch questions from API
    var questionsData = await getMatchMaterialsFromApi(competitionId);

    // Loop through questionsData and create Firestore documents
    firestoreService.storeQuestionsInFirestore(questionsData);
  }
  
}
