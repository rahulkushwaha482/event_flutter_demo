class EventModel {
  final String name;
  final String time;

  EventModel({required this.name, required this.time});

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      name: json['name'],
      time: json['time'],
    );
  }
}
