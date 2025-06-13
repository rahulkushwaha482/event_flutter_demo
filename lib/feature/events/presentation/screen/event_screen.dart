import 'package:event_flutter_test/core/constants/location_constant.dart';
import 'package:event_flutter_test/feature/events/presentation/provider/event_provider.dart';
import 'package:event_flutter_test/feature/events/presentation/widgets/bottom_sheet_widget.dart';
import 'package:event_flutter_test/feature/events/presentation/widgets/build_nav_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class EventScreen extends ConsumerWidget {
  const EventScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventsAsync = ref.watch(eventNotifierProvider);
    final selectedLocation = ref.watch(selectedLocationProvider);

    final markers = <Marker>{};

    eventsAsync.whenOrNull(data: (events) {
      for (int i = 0; i < events.length; i++) {
        final position = LocationConstant.fixedLocations[i];
        markers.add(
          Marker(
            markerId: MarkerId(events[i].name),
            position: position,
            icon: selectedLocation == position
                ? AssetMapBitmap('assets/map_logo.png', width: 55, height: 80)
                : BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueRed),
            infoWindow: InfoWindow(title: events[i].name),
          ),
        );
      }
    });

    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LocationConstant.fixedLocations[0],
              zoom: 10,
            ),
            markers: markers,
          ),
          if (eventsAsync.isLoading)
            const Center(child: CircularProgressIndicator()),
          if (eventsAsync.hasError)
            Center(
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Error loading events: ${eventsAsync.asError!.error}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            ),
          Align(
            alignment: Alignment.bottomCenter,
            child: EventBottomSheet(),
          ),
        ],
      ),
    );
  }
}
