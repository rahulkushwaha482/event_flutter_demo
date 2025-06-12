import 'package:event_flutter_test/core/usecase/usecase.dart';
import 'package:event_flutter_test/feature/events/domain/entities/event_entity.dart';
import 'package:event_flutter_test/feature/events/domain/repositories/event_repository.dart';

class EventUseCase implements UseCase<List<Event>, NoParams> {
  final EventRepository repository;

  EventUseCase(this.repository);

  @override
  Future<List<Event>> call(NoParams params) {
    return repository.fetchEvent();
  }
}
