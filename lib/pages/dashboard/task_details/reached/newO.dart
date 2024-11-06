import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/custom_dashapp.dart';

class Newo extends StatefulWidget {
  const Newo({super.key, this.task});
  final Map<String, dynamic>? task;

  @override
  State<Newo> createState() => _NewoState();
}

class _NewoState extends State<Newo> {
  Map<String, dynamic>? taskData;
  bool isLoading = true;

  List<Map<String, dynamic>> removedDescriptions = [];

  List<Map<String, dynamic>> removedProducts = []; // List for removed products

  @override
  void initState() {
    setState(() {
      taskData = widget.task;
      isLoading = false;
    });
    super.initState();
  }

  List<bool> isSelected = [];

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    final task = taskData;

    print(task?['checktree_description']);

    // Initialize spareItems and isSelected here
    List<dynamic> spareItems = task?['checktree_description'] ?? [];
    if (isSelected.length != spareItems.length) {
      isSelected = List<bool>.filled(spareItems.length, false);
    }

    return Scaffold(
      appBar: CustomDashApp(title: 'new one '),
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemCount: spareItems.length,
        itemBuilder: (context, index) {
          final item = spareItems[index];

          return Row(
            // crossAxisAlignment: cros,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    value: isSelected[index],
                    onChanged: (newBool) {
                      setState(() {
                        isSelected[index] = newBool ?? false;
                      });
                    },
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item?['item_code'] ?? 'No Item Code',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // Text(" :"),
                ],
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item?['item_name'] ?? 'No Description',
                      style: TextStyle(fontSize: 12),
                      maxLines: null,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
