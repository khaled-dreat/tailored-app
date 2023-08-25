class Player {
  final String id;
  final String name;
  final String profileImage;
  final int score;

  Player({
    required this.id,
    required this.name,
    required this.profileImage,
    required this.score,
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      id: json['id'],
      name: json['name'],
      profileImage: json['profileImage'],
      score: json['score'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'profileImage': profileImage,
      'score': score,
    };
  }
}

