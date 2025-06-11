import 'package:equatable/equatable.dart';

class Event extends Equatable {
  final String title;
  final String time;
  final double lat;
  final double lng;

  Event(
      {required this.title,
      required this.time,
      required this.lat,
      required this.lng});

  @override
  List<Object?> get props => [title, time, lat, lng];
}
