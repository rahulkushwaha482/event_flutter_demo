import 'package:event_flutter_test/feature/events/presentation/provider/event_provider.dart';
import 'package:event_flutter_test/feature/events/presentation/widgets/bottom_sheet_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class EventScreen extends ConsumerWidget {
  const EventScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventsAsync = ref.watch(eventNotifierProvider);
    final selectedLocation = ref.watch(selectedLocationProvider);

    final List<LatLng> fixedLocations = [
      LatLng(28.6139, 77.2090),
      LatLng(12.9716, 77.5946),
      LatLng(19.0760, 72.8777),
      LatLng(13.0827, 80.2707),
    ];

    final markers = <Marker>{};

    eventsAsync.whenOrNull(data: (events) {
      for (int i = 0; i < events.length; i++) {
        final position = fixedLocations[i];
        markers.add(
          Marker(
            markerId: MarkerId(events[i].name),
            position: position,
            icon: selectedLocation == position
                ? BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueOrange)
                : BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueRed),
            infoWindow: InfoWindow(title: events[i].name),
          ),
        );
      }
    });

    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: fixedLocations[0],
              zoom: 10,
            ),
            markers: markers,
          ),
          if (eventsAsync.isLoading)
            const Center(child: CircularProgressIndicator()),
          if (eventsAsync.hasError)
            Center(
              child: Container(
                color: Colors.white.withOpacity(0.8),
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
