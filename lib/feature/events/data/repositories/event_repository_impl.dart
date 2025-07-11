import 'package:event_flutter_test/core/constants/location_constant.dart';
import 'package:event_flutter_test/feature/events/data/datasources/event_data_source.dart';
import 'package:event_flutter_test/feature/events/domain/entities/event_entity.dart';
import 'package:event_flutter_test/feature/events/domain/repositories/event_repository.dart';

class EventRepositoryImpl implements EventRepository {
  final EventDataSource remoteDataSource;

  EventRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Event>> fetchEvent() async {
    final models = await remoteDataSource.fetchEvents();

    return List.generate(models.length, (index) {
      final e = models[index];
      //
      final location = LocationConstant.fixedLocations[index];

      return Event(
        name: e.name,
        time: e.time,
        lat: location.latitude,
        lng: location.longitude,
      );
    });
  }
}
