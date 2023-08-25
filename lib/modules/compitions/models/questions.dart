class Question {
  final int id, answer;
  final String question;
  final List<String> options;

  Question(
      {required this.id,
      required this.question,
      required this.answer,
      required this.options});

  // Convert JSON data to Question object
  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      question: json['question'],
      answer: json['answer_index'],
      options: List<String>.from(json['options']),
    );
  }

  // Convert Question object to JSON data
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'answer': answer,
      'options': options,
    };
  }
}

// enum QuestionType {
//   text,
//   multipleChoice,
//   typing,
//    tapping,
// }

// class Question {
//   String id;
//   String type;
//   List<String> answer;
//   List<String> options;

//   Question({
//     required this.id,
//     required this.type,
//     required this.answer,
//     required this.options,
//   });

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'type': type,
//       'answer': answer,
//       'options': options,
//     };
//   }

//   factory Question.fromJson(Map<String, dynamic> json) {
//     return Question(
//       id: json['id'],
//       type: json['type'],
//       answer: List<String>.from(json['answer']),
//       options: List<String>.from(json['options']),
//     );
//   }
// }
