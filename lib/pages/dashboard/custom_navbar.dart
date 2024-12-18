import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/pallete.dart';

class CustomNavbar extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;
  const CustomNavbar(
      {super.key, required this.selectedIndex, required this.onItemSelected});

  @override
  State<CustomNavbar> createState() => _CustomNavbarState();
}

class _CustomNavbarState extends State<CustomNavbar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // padding
      decoration: BoxDecoration(
          // color: Colors.white,
          ),
      child: Container(
        //pad
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(30)),
          border: Border.all(
            color: Pallete.mainFontColor,
            width: 2,
          ),
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          _buildBottomNavItem(Icons.home, 0),
          _buildVerticalDivider(),
          _buildBottomNavItem(Icons.calendar_month, 1),
          _buildVerticalDivider(),
          _buildBottomNavItem(Icons.verified_user_outlined, 2),
        ]),
      ),
    );
  }

  Widget _buildVerticalDivider() {
    return Container(
      height: 30,
      width: 1,
      color: Pallete.mainFontColor,
    );
  }

  Widget _buildBottomNavItem(IconData icon, int index) {
    bool isSelected = widget.selectedIndex == index;
    return GestureDetector(
      onTap: () {
        widget.onItemSelected(index);
      },
      child: Container(
        padding: EdgeInsets.all(12),
        // decoration: BoxDecoration(
        //     color: Pallete.mainFontColor,
        //     borderRadius: BorderRadius.circular(30)),
        child: Icon(
          icon,
          color: isSelected ? Pallete.mainFontColor : Pallete.mainFontColor,
          size: 28,
        ),
      ),
    );
  }
}
