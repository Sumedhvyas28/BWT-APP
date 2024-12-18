import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/pallete.dart';
import 'package:go_router/go_router.dart';

class StarterPage extends StatefulWidget {
  const StarterPage({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  State<StarterPage> createState() => _StarterPageState();
}

class _StarterPageState extends State<StarterPage> {
  int selectedIndex = 0;

  void _goToBranch(int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: widget.navigationShell,
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(
          bottom: 20,
          left: 20,
          right: 20,
        ),
        padding: const EdgeInsets.symmetric(vertical: 10),
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: Pallete.mainFontColor,
            width: 2,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavItem(CupertinoIcons.home, 0),
            _buildDivider(),
            _buildNavItem(CupertinoIcons.calendar_today, 1),
            _buildDivider(),
            _buildNavItem(CupertinoIcons.person_fill, 2),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
        _goToBranch(selectedIndex);
      },
      child: Icon(
        icon,
        color: selectedIndex == index ? Pallete.mainFontColor : Colors.black,
        size: 32,
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      width: 3,
      height: 30,
      color: Pallete.mainFontColor,
    );
  }
}
