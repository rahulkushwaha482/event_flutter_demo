import 'package:event_flutter_test/core/utils/date_formatter.dart';
import 'package:event_flutter_test/feature/events/presentation/provider/event_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class EventBottomSheet extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventsAsync = ref.watch(eventNotifierProvider);

    final List<LatLng> fixedLocations = [
      LatLng(28.6139, 77.2090), // Delhi
      LatLng(12.9716, 77.5946), // Bangalore
      LatLng(19.0760, 72.8777), // Mumbai
      LatLng(13.0827, 80.2707), // Chennai
    ];

    return eventsAsync.when(
      data: (events) => Container(
        height: 300,
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: ListView.builder(
          itemCount: events.length,
          itemBuilder: (context, index) {
            final e = events[index];
            return ListTile(
              leading: Icon(Icons.location_on, color: Colors.orange),
              title: Text(e.name, style: TextStyle(color: Colors.white)),
              subtitle: Text(DateFormatter.formatEventDate(e.time),
                  style: TextStyle(color: Colors.white60)),
              onTap: () {
                ref.read(selectedLocationProvider.notifier).state =
                    fixedLocations[index];
              },
            );
          },
        ),
      ),
      loading: () => const CircularProgressIndicator(),
      error: (e, _) => Text("Failed to load events"),
    );
  }
}
