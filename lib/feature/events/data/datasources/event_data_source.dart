import 'package:event_flutter_test/core/network/dio_client.dart';
import 'package:event_flutter_test/feature/events/data/model/event_model.dart';

class EventDataSource {
  final DioClient dio;

  EventDataSource(this.dio);

  Future<List<EventModel>> fetchEvents() async {
    final response = await dio.get('api/v1/events');
    return (response.data as List)
        .map((json) => EventModel.fromJson(json))
        .toList();
  }
}
