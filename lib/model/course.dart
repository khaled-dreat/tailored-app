import 'package:tailored/model/language.dart';

class Course {
  Course({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.slug,
    required this.sourceLanguage,
    required this.targetLanguage,
  });

  String id;
  String name;
  String? description;
  String? image;
  String slug;
  Language sourceLanguage;
  Language targetLanguage;

  factory Course.fromJson(Map<String, dynamic> json) => Course(
        id: json["id"],
        name: json["name"],
        description: json["description"] ?? "",
        image: json["image"] ?? null,
        slug: json["slug"],
        sourceLanguage: Language.fromJson(json["source_language"]),
        targetLanguage: Language.fromJson(json["target_language"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "image": image,
        "slug": slug,
        "source_language": sourceLanguage.toJson(),
        "target_language": targetLanguage.toJson(),
      };
}
