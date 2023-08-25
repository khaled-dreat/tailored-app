class Language {
  Language({
    required this.id,
    required this.name,
    required this.code,
  });

  String id;
  String name;
  String code;

  factory Language.fromJson(Map<String, dynamic> json) => Language(
        id: json["id"],
        name: json["name"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
      };
}
