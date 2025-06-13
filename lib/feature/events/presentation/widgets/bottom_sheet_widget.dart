import 'package:event_flutter_test/core/constants/location_constant.dart';
import 'package:event_flutter_test/core/utils/date_formatter.dart';
import 'package:event_flutter_test/feature/events/presentation/provider/event_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EventBottomSheet extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventsAsync = ref.watch(eventNotifierProvider);

    return eventsAsync.when(
      data: (events) => Container(
        height: 320,
        decoration: const BoxDecoration(
          color: Colors.black,
        ),
        child: ListView.builder(
          itemCount: events.length,
          itemBuilder: (context, index) {
            final e = events[index];
            return ListTile(
              leading: Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(40),
                ),
                child:
                    Center(child: Icon(Icons.location_on, color: Colors.grey)),
              ),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
              title: Text(
                e.name,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              subtitle: Text(DateFormatter.formatEventDate(e.time),
                  style: TextStyle(color: Colors.white60)),
              onTap: () {
                ref.read(selectedLocationProvider.notifier).state =
                    LocationConstant.fixedLocations[index];
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
