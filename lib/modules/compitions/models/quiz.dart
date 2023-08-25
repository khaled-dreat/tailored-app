// ignore_for_file: public_member_api_docs, sort_constructors_first


class Competition {
  final String id;
  final String name;
  final String image;

 // final List<Question> questions;

 // final List<Player> players;
 // final bool arePlayersReady;

  Competition({
    required this.id,
    required this.name,
    required this.image,
   // required this.questions,
  //  required this.players,
   //  this.arePlayersReady=false,
  });

    factory Competition.fromJson(Map<String, dynamic> json) {
    return Competition(
      id: json['id'] as String,
      name: json['name'] as String,
      image: json['image'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
    };
  }

}
