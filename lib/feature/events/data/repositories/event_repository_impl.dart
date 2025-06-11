import 'package:event_flutter_test/feature/events/data/datasources/event_data_source.dart';
import 'package:event_flutter_test/feature/events/domain/entities/event_entity.dart';
import 'package:event_flutter_test/feature/events/domain/repositories/event_repository.dart';

class EventRepositoryImpl implements EventRepository {
  final EventDataSource remoteDataSource;

  EventRepositoryImpl(this.remoteDataSource);

// ToDO: We need to change the lat long here

  @override
  Future<List<Event>> fetchEvent() async {
    final models = await remoteDataSource.fetchEvents();
    return models
        .map((e) => Event(title: e.name, time: e.time, lat: 44.23, lng: 33.33))
        .toList();
  }
}
