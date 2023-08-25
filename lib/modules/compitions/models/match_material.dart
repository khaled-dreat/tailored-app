class MatchMaterial {
  String id;
  List<Content> content;
  Question question;

  MatchMaterial({
    required this.id,
    required this.content,
    required this.question,
  });
  factory MatchMaterial.fromJson(Map<String, dynamic> json) {
    return MatchMaterial(
      id: json['id'] as String,
      content: (json['content'] as List<dynamic>)
          .map((contentJson) =>
              Content.fromJson(contentJson as Map<String, dynamic>))
          .toList(),
      question: Question.fromJson(json['question'] as Map<String, dynamic>),
    );
  }
}

class Content {
  String id;
  String type;
  String text;
  String? file;

  Content({
    required this.id,
    required this.type,
    required this.text,
    this.file,
  });
  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(
      id: json['id'] as String,
      type: json['type'] as String,
      text: json['text'] as String,
      file: json['file'] as String?,
    );
  }
}

class Question {
  String id;
  String type;
  List<String> answer;
  List<String> options;

  Question({
    required this.id,
    required this.type,
    required this.answer,
    required this.options,
  });
  factory Question.fromJson(Map json) {
    return Question(
      id: json['id'],
      type: json['type'],
      answer: List.from(json['answer']),
      options: List.from(json['options']),
    );
  }
}
