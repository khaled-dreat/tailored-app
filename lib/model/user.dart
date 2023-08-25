class User {
  int? id;
  String? name;
  String? avatar;
  String? phone;
  String? power;
  dynamic? bio;
  int? blocked;
  String? email;

  User(
      {this.id,
        this.name,
        this.avatar,
        this.phone,
        this.power,
        this.bio,
        this.blocked,
        this.email});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = "${'${json['first_name']}' ' ${json['last_name']}'}";
    avatar = json['avatar'];
    phone = json['phone'];
    power = json['power'];
    bio = json['bio'];
    blocked = json['blocked'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['avatar'] = this.avatar;
    data['phone'] = this.phone;
    data['power'] = this.power;
    data['bio'] = this.bio;
    data['blocked'] = this.blocked;
    data['email'] = this.email;
    return data;
  }
}
