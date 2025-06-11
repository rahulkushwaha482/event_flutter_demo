import 'package:event_flutter_test/feature/events/domain/entities/event_entity.dart';

abstract class EventRepository {
  Future<List<Event>> fetchEvent();
}
