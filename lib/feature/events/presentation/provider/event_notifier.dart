import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:event_flutter_test/core/error/exception.dart';
import 'package:event_flutter_test/core/network/network_info.dart';
import 'package:event_flutter_test/core/usecase/usecase.dart';
import 'package:event_flutter_test/core/utils/location_service.dart';
import 'package:event_flutter_test/feature/events/domain/entities/event_entity.dart';
import 'package:event_flutter_test/feature/events/domain/usecase/event_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EventNotifier extends StateNotifier<AsyncValue<List<Event>>> {
  final EventUseCase useCase;
  final NetworkInfo networkInfo;
  final LocationService locationService;
  late final StreamSubscription _connectionSubscription;

  EventNotifier(this.useCase, this.networkInfo, this.locationService)
      : super(const AsyncLoading()) {
    _listenToConnection();
  }

  Future<void> loadEvents() async {
    state = const AsyncLoading();
    try {
      final isConnected = await networkInfo.isConnected;
      if (!isConnected) {
        throw NoInternetException;
      }

      final hasLocation = await locationService.ensurePermission();
      if (!hasLocation) {
        throw LocationPermissionException();
      }

      final events = await useCase(NoParams());
      state = AsyncData(events);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  void _listenToConnection() {
    _connectionSubscription = networkInfo.onConnectionChanged.listen((result) {
      if (result != ConnectivityResult.none) {
        loadEvents();
      } else {
        throw NoInternetException;
      }
    });
  }

  @override
  void dispose() {
    _connectionSubscription.cancel();
    super.dispose();
  }
}
