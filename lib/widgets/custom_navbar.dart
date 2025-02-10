import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomBottomNavBar extends StatelessWidget {
  final Function(int) onItemTapped;
  final int selectedIndex;

  CustomBottomNavBar({
    required this.onItemTapped,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 2.0,
      color: Color.fromRGBO(114, 49, 153, 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(FontAwesomeIcons.home, "Home", 0),
          _buildNavItem(FontAwesomeIcons.borderAll, "Category", 1),
          const SizedBox(width: 48), // Space for FAB
          _buildNavItem(FontAwesomeIcons.fileLines, "Summary", 2),
          _buildNavItem(FontAwesomeIcons.cog, "Setting", 3),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () => onItemTapped(index),
      autofocus: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: selectedIndex == index
                ? Color.fromRGBO(248, 189, 0, 1)
                : Colors.white,
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: selectedIndex == index
                  ? Color.fromRGBO(248, 189, 0, 1)
                  : Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
