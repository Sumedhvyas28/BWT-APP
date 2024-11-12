import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/custom_dashapp.dart';
import 'package:flutter_application_1/constants/pallete.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LookForSymptoms extends StatefulWidget {
  const LookForSymptoms({super.key, this.task});
  final List<dynamic>? task;

  @override
  State<LookForSymptoms> createState() => _LookForSymptomsState();
}

class _LookForSymptomsState extends State<LookForSymptoms> {
  List<dynamic>? taskData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    taskData = widget.task;
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomDashApp(title: 'Symptoms'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.search, color: Pallete.mainFontColor)),
                Text(
                  'LOOK UP KNOWN SYMPTOMS',
                  style: TextStyle(
                    fontSize: 18,
                    color: Pallete.mainFontColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            isLoading
                ? Center(
                    child: LoadingAnimationWidget.waveDots(
                      color: Pallete.mainFontColor,
                      size: 70,
                    ),
                  )
                : Expanded(
                    child: (taskData != null && taskData!.isNotEmpty)
                        ? _buildTasks(taskData!)
                        : Center(
                            child: const Text(
                              'No symptoms available',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildTasks(List<dynamic> taskData) {
    return ListView.builder(
      itemCount: taskData.length,
      itemBuilder: (context, index) {
        final task = taskData[index];
        final symptomCode = task['symptom_code'] ?? 'No symptom code available';
        final resolution = task['resolution'] ?? 'No resolution available';
        final imagePath = 'assets/images/first_1.png';

        return Padding(
          padding: EdgeInsets.all(8),
          child: Card(
            color: Colors.white,
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Symptoms',
                    style: TextStyle(
                      color: Pallete.mainFontColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        symptomCode,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Resolutions',
                    style: TextStyle(
                      color: Pallete.mainFontColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        resolution,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Attached image',
                    style: TextStyle(
                      color: Pallete.mainFontColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  imagePath.isNotEmpty
                      ? Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Image.asset(
                            imagePath,
                            fit: BoxFit.cover,
                            height: 200,
                          ),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
