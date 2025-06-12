import 'package:flutter/material.dart';

BottomNavigationBarItem buildNavItem(
    IconData icon, int index, int selectedIndex) {
  bool isSelected = index == selectedIndex;
  return BottomNavigationBarItem(
    icon: Container(
      //  padding: const EdgeInsets.all(8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),

      decoration: BoxDecoration(
        color: isSelected ? Colors.orange : Colors.transparent,
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        size: 26,
        color: Colors.grey,
      ),
    ),
    label: '',
  );
}
