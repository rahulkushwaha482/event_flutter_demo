import 'package:event_flutter_test/feature/events/domain/entities/event_entity.dart';
import 'package:event_flutter_test/feature/events/domain/repositories/event_repository.dart';

class EventUseCase {
  final EventRepository repository;

  EventUseCase(this.repository);

  Future<void> call(Event url) async {
    return await repository.fetchEvent(url);
  }
}
