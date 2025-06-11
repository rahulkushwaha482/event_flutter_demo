import 'package:event_flutter_test/feature/events/presentation/provider/event_provider.dart';
import 'package:event_flutter_test/feature/events/presentation/widgets/bottom_sheet_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class EventScreen extends ConsumerWidget {
  const EventScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventsAsync = ref.watch(eventProvider);
    final selectedLocation = ref.watch(selectedLocationProvider);

    final List<LatLng> fixedLocations = [
      LatLng(28.6139, 77.2090), // Delhi
      LatLng(12.9716, 77.5946), // Bangalore
      LatLng(19.0760, 72.8777), // Mumbai
      LatLng(13.0827, 80.2707), // Chennai
    ];

    return Scaffold(
      body: Stack(
        children: [
          eventsAsync.when(
            data: (events) {
              final markers = <Marker>{};

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

              return GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: fixedLocations[0],
                  zoom: 10,
                ),
                markers: markers,
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text("Error loading map")),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: EventBottomSheet(),
          )
        ],
      ),
    );
  }
}
