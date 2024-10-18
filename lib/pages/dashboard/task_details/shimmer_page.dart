import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/custom_dashapp.dart';
import 'package:flutter_application_1/pages/dashboard/task_details/task_details.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidgetPage extends StatefulWidget {
  const ShimmerWidgetPage({super.key});

  @override
  State<ShimmerWidgetPage> createState() => _ShimmerWidgetPageState();
}

class _ShimmerWidgetPageState extends State<ShimmerWidgetPage> {
  bool _isLoading = true; // Loading state initially set to true

  @override
  void initState() {
    super.initState();

    // Set a timer for 2 seconds before redirecting to the next page
    Future.delayed(const Duration(seconds: 2), () {
      // Redirect to the next page after 2 seconds
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const TaskDetails()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomDashApp(title: 'Task Details'),
      body: _isLoading
          ? _buildShimmerEffect()
          : Container(), // Shimmer effect is displayed
    );
  }

  // Shimmer effect widgets
  Widget _buildShimmerEffect() {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        // First row with text and square image shimmer
        _buildTextWithImageShimmer(),
        const SizedBox(height: 60),

        // Two parallel shimmer cards
        Row(
          children: [
            Expanded(child: _buildParallelCardShimmer()),
            const SizedBox(width: 16),
            Expanded(child: _buildParallelCardShimmer()),
          ],
        ),
        const SizedBox(height: 20),

        // Full-width shimmer card
        _buildFullWidthCardShimmer(),
        const SizedBox(height: 40),

        _buildFullWidthCardShimmer(),
        _buildFullWidthCardShimmer(),
        const SizedBox(height: 20),
        _buildFullWidthCardShimmer(),
      ],
    );
  }

  // Shimmer widget for text and image
// Shimmer widget for text and image
  Widget _buildTextWithImageShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Expanded(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[300],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left side with 3 lines of text
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 16,
                      width: double.infinity,
                      color: Colors.grey[300], // Line 1
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 16,
                      width: double.infinity,
                      color: Colors.grey[300], // Line 2
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 16,
                      width: double.infinity,
                      color: Colors.grey[300], // Line 3
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              // Right side with a square
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.grey[400]!), // Border for the square
                  color: Colors.grey[300], // Fill color for the square
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Shimmer widget for two parallel cards
  Widget _buildParallelCardShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  // Shimmer widget for full-width card
  Widget _buildFullWidthCardShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}

// Next Page widget to redirect to
class NextPage extends StatelessWidget {
  const NextPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Next Page'),
      ),
      body: Center(
        child: const Text(
          'Welcome to the Next Page!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
