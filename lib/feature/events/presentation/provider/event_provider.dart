import 'package:dio/dio.dart';
import 'package:event_flutter_test/core/network/dio_client.dart';
import 'package:event_flutter_test/core/utils/location_service.dart';
import 'package:event_flutter_test/feature/events/data/datasources/event_data_source.dart';
import 'package:event_flutter_test/feature/events/data/model/event_model.dart';
import 'package:event_flutter_test/feature/events/domain/usecase/event_usecase.dart';
import 'package:event_flutter_test/feature/events/presentation/provider/event_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:geolocator/geolocator.dart';

import 'package:event_flutter_test/core/network/dio_client.dart';
import 'package:event_flutter_test/core/network/network_info.dart';
import 'package:event_flutter_test/feature/events/data/datasources/event_data_source.dart';
import 'package:event_flutter_test/feature/events/data/repositories/event_repository_impl.dart';
import 'package:event_flutter_test/feature/events/domain/entities/event_entity.dart';

final dioProvider = Provider((ref) => DioClient());
final connectivityProvider = Provider((ref) => Connectivity());
final networkInfoProvider = Provider<NetworkInfo>(
    (ref) => NetworkInfoImpl(ref.watch(connectivityProvider)));
final locationServiceProvider = Provider((ref) => LocationService());

final eventDataSourceProvider =
    Provider((ref) => EventDataSource(ref.watch(dioProvider)));

final eventRepositoryProvider =
    Provider((ref) => EventRepositoryImpl(ref.watch(eventDataSourceProvider)));

final fetchEventsUseCaseProvider =
    Provider((ref) => EventUseCase(ref.watch(eventRepositoryProvider)));

// --- Presentation Layer
final eventNotifierProvider =
    StateNotifierProvider<EventNotifier, AsyncValue<List<Event>>>((ref) {
  return EventNotifier(
    ref.watch(fetchEventsUseCaseProvider),
    ref.watch(networkInfoProvider),
    ref.watch(locationServiceProvider),
  );
});

final selectedLocationProvider = StateProvider<LatLng?>((ref) => null);
