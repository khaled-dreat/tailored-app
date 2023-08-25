class Profile {
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  bool? emailVerified;
  String? avatar;
  List<Friend>? friends;

  Profile(
      {this.id,
        this.email,
        this.firstName,
        this.lastName,
        this.phoneNumber,
        this.emailVerified,
        this.avatar,
        this.friends});

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phoneNumber = json['phone_number'];
    emailVerified = json['email_verified'];
    avatar = json['avatar'];
    if (json['friends'] != null) {
      friends = <Friend>[];
      json['friends'].forEach((v) {
        friends!.add(new Friend.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['phone_number'] = this.phoneNumber;
    data['email_verified'] = this.emailVerified;
    data['avatar'] = this.avatar;
    if (this.friends != null) {
      data['friends'] = this.friends!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Friend {
  int? id;
  String? firstName;
  String? lastName;
  String? avatar;
  String? relationType;

  Friend(
      {this.id, this.firstName, this.lastName, this.avatar, this.relationType});

  Friend.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    avatar = json['avatar'];
    relationType = json['relation_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['avatar'] = this.avatar;
    data['relation_type'] = this.relationType;
    return data;
  }
}
