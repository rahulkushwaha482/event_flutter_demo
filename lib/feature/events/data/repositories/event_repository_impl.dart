import 'package:event_flutter_test/core/constants/location_constant.dart';
import 'package:event_flutter_test/feature/events/data/datasources/event_data_source.dart';
import 'package:event_flutter_test/feature/events/domain/entities/event_entity.dart';
import 'package:event_flutter_test/feature/events/domain/repositories/event_repository.dart';

class EventRepositoryImpl implements EventRepository {
  final EventDataSource remoteDataSource;

  EventRepositoryImpl(this.remoteDataSource);

// ToDO: We need to change the lat long here

  @override
  Future<List<Event>> fetchEvent() async {
    // final fixedLocations = [
    //   [28.6139, 77.2090],
    //   [12.9716, 77.5946],
    //   [19.0760, 72.8777],
    //   [13.0827, 80.2707],
    // ];
    final models = await remoteDataSource.fetchEvents();

    return List.generate(models.length, (index) {
      final e = models[index];
      //
      // final location = fixedLocations[index];
      final location = LocationConstant.fixedEventLocations[index];

      return Event(
        name: e.name,
        time: e.time,
        lat: location[0],
        lng: location[1],
      );
    });
  }
}
