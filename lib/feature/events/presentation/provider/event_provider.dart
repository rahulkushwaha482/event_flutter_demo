import 'package:dio/dio.dart';
import 'package:event_flutter_test/feature/events/data/datasources/event_data_source.dart';
import 'package:event_flutter_test/feature/events/data/model/event_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

final dioProvider = Provider((ref) => Dio());

final eventProvider = FutureProvider<List<EventModel>>((ref) async {
  final dio = ref.read(dioProvider);
  final dataSource = EventDataSource(dio);
  return await dataSource.fetchEvents();
});

final selectedLocationProvider = StateProvider<LatLng?>((ref) => null);
