import 'package:dio/dio.dart';
import 'package:event_flutter_test/feature/events/data/model/event_model.dart';

class EventDataSource {
  final Dio dio;

  EventDataSource(this.dio);

  Future<List<EventModel>> fetchEvents() async {
    final response = await dio
        .get('https://6847d529ec44b9f3493e5f06.mockapi.io/api/v1/events');
    return (response.data as List)
        .map((json) => EventModel.fromJson(json))
        .toList();
  }
}
