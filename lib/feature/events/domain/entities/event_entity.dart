import 'package:equatable/equatable.dart';

class Event extends Equatable {
  final String name;
  final String time;
  final double lat;
  final double lng;

  Event(
      {required this.name,
      required this.time,
      required this.lat,
      required this.lng});

  @override
  List<Object?> get props => [name, time, lat, lng];
}
