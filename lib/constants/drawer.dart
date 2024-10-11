import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/pallete.dart';

// todo drawer logic

class DrawerPage extends StatelessWidget {
  const DrawerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.white,
          ),
          Column(
            children: [
              AppBar(
                title: const Text('Drawer Header'),
                leading: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the drawer
                  },
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      width: double.infinity,
                      color: Pallete.mainFontColor,
                      height: 200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset('assets/images/userprofile.png'),
                          const SizedBox(height: 10),
                          const Text(
                            'Sumedh Vyas',
                            style: TextStyle(fontSize: 22, color: Colors.white),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'user123456@gmail.com',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    Expanded(child: Container()),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Function to open the drawer
void showDrawer(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return const Material(
        type: MaterialType.transparency, // Transparent background
        child: FractionallySizedBox(
          widthFactor: 1.0, // Full screen width
          heightFactor: 1.0, // Full screen height
          child: DrawerPage(), // Your DrawerPage widget
        ),
      );
    },
  );
}
