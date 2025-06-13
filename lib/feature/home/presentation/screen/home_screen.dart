import 'package:event_flutter_test/feature/events/presentation/screen/event_screen.dart';
import 'package:event_flutter_test/feature/home/presentation/provider/bottom_navbar_provider.dart';
import 'package:event_flutter_test/feature/search/presentation/screen/search_screen.dart';
import 'package:event_flutter_test/feature/setting/presentation/screen/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(bottomNavIndexProvider);

    final items = [
      Icons.search,
      Icons.whatshot,
      Icons.circle_outlined,
    ];

    final List<Widget> pages = const [
      SearchScreen(),
      EventScreen(),
      SettingScreen(),
    ];

    return Scaffold(
        body: pages[selectedIndex],
        bottomNavigationBar: Consumer(builder: (context, ref, _) {
          return Container(
            color: Colors.black,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(items.length, (index) {
                final isSelected = index == selectedIndex;
                return GestureDetector(
                  onTap: () =>
                      ref.read(bottomNavIndexProvider.notifier).state = index,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.orange : Colors.transparent,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Icon(
                      items[index],
                      color: Colors.grey,
                      size: 25,
                    ),
                  ),
                );
              }),
            ),
          );
        }));
  }
}
