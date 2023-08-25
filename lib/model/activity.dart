class Activity {
  Activity({
      required this.type,
      required this.timestamp,});

  factory Activity.fromJson( json)=> Activity(
    type : json['type'],
    timestamp : json['timestamp']
  );
  String type;
  String timestamp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['timestamp'] = timestamp;
    return map;
  }

}