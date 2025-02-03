import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:officeflow/controller/app_controller.dart';

class SummaryPieChart extends StatefulWidget {
  const SummaryPieChart({super.key});

  @override
  State<SummaryPieChart> createState() => _SummaryPieChartState();
}

class _SummaryPieChartState extends State<SummaryPieChart> {
  final controller = Get.find<AppController>();
  @override
  void initState() {
    controller.fetchSummaryData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.categorySummary.isEmpty) {
        return Center(child: CircularProgressIndicator());
      }

      final sections = controller.categorySummary.map((category) {
        return PieChartSectionData(
          title:
              '${category.categoryName}\n${category.percentage.toStringAsFixed(1)}%',
          titleStyle: TextStyle(fontSize: 7),
          color: _getCategoryColor(category.categoryName),
          value: category.amount,
          radius: 60,
        );
      }).toList();

      return PieChart(
        PieChartData(
          centerSpaceRadius: 50,
          titleSunbeamLayout: false,
          sections: sections,
        ),
      );
    });
  }

  // Helper method to generate a color for each category
  Color _getCategoryColor(String categoryName) {
    // You can create a color list and select a color based on the category's position
    List<Color> colors = [
      Color.fromRGBO(189, 249, 249, 1),
      Color.fromRGBO(230, 122, 172, 1),
      Color.fromRGBO(188, 50, 107, 1),
      Color.fromRGBO(221, 206, 16, 1),
      Color.fromRGBO(253, 243, 131, 1),
      Colors.blue, // Additional color
      Colors.green, // Additional color
      Colors.orange, // Additional color
      Colors.purple, // Additional color
    ];

    // Return a color based on the category index, ensuring we don't exceed the list size
    int index = categoryName.hashCode % colors.length; // Generate unique index
    return colors[index];
  }
}
