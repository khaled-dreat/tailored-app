import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

// Base API URL
const String baseUrl = 'https://tailored.meshka.space/api/v1/competition';
const token = 'TOKEN e6ab2a5283ad6bf1edbe15b20aac2ec30d9d4f94';
// Function to handle HTTP requests and responses
Future<dynamic> _apiRequest(String url,
    {String method = 'GET',
    Map<String, dynamic>? body,
    Map<String, String>? headers}) async {
  final response = method == 'GET'
      ? await http.get(Uri.parse(url),
          headers: headers ?? {'Authorization': token})
      : await http.post(Uri.parse(url),
          body: body, headers: headers ?? {'Authorization': token});

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to perform API request');
  }
}

// GET - Competition List
Future<List<dynamic>> getCompetitionListFromApi() async {
  const url = '$baseUrl/';
  return await _apiRequest(url);
}

// GET - Competition Detail
Future<dynamic> getCompetitionDetail(String competitionId) async {
  final url = '$baseUrl/$competitionId';
  return await _apiRequest(url);
}

// POST - Competition Join
Future<dynamic> joinCompetitioByAPI(String competitionId) async {
  final url = '$baseUrl/match/$competitionId';
  return await _apiRequest(url, method: 'POST');
}

// GET - Match Detail
Future<dynamic> getMatchDetail(String matchId) async {
  final url = '$baseUrl/match/$matchId';
  return await _apiRequest(url);
}

// POST - Submit Match
Future<dynamic> submitMatch(String matchId, int score) async {
  final url = '$baseUrl/match/$matchId/submit';
  final body = {'score': score.toString()};
  return await _apiRequest(url, method: 'POST', body: body);
}

// GET - Match Materials
Future<List<dynamic>> getMatchMaterialsFromApi(String competitionId) async {
  log(competitionId);
  const url = 'https://tailored.meshka.space/api/v1/competition/match/3V8WTxAytZzRerN5H4a5bC/materials/';
 // final url = '$baseUrl/match/$competitionId/materials/';

  return await _apiRequest(url);
}

// GET - Match next Material
Future<dynamic> getNextMatchMaterial(String competitionId) async {
  final url = '$baseUrl/$competitionId/materials/next';
  return await _apiRequest(url);
}

// GET - Match Material Detail
Future<dynamic> getNextMatchMaterialDetail(String competitionId) async {
  final url = '$baseUrl/$competitionId/materials/next';
  return await _apiRequest(url);
}

// POST - Submit Match Material
Future<dynamic> submitMatchMaterial(
    String matchId, String materialId, String answer) async {
  final url = '$baseUrl/match/$matchId/materials/$materialId/submit';
  final body = {'answer': answer};
  return await _apiRequest(url, method: 'POST', body: body);
}
