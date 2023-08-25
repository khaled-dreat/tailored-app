class Materials {
  String? id;
  List<Content>? content;
  Question? question;

  Materials({this.id, this.content, this.question});

  Materials.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['content'] != null) {
      content = <Content>[];
      json['content'].forEach((v) {
        content!.add(new Content.fromJson(v));
      });
    }
    question = json['question'] != null
        ? new Question.fromJson(json['question'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.content != null) {
      data['content'] = this.content!.map((v) => v.toJson()).toList();
    }
    if (this.question != null) {
      data['question'] = this.question!.toJson();
    }
    return data;
  }
}

class Content {
  String? id;
  String? type;
  String? text;
  String? file;

  Content({this.id, this.type, this.text, this.file});

  Content.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    text = json['text'];
    file = json['file'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['text'] = this.text;
    data['file'] = this.file;
    return data;
  }
}

class Question {
  String? id;
  String? type;
  List<String>? answer;
  List<String>? options;

  Question({this.id, this.type, this.answer, this.options});

  Question.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    answer = json['answer'].cast<String>();
    options = json['options'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['answer'] = this.answer;
    data['options'] = this.options;
    return data;
  }
}
