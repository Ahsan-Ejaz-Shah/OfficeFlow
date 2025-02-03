import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CustomPieChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Pie Chart
          SizedBox(
            height: 300,
            width: 300,
            child: PieChart(
              PieChartData(
                sections: getSections(),
                centerSpaceRadius: 50, // Creates a donut chart
                sectionsSpace: 2, // Space between sections
              ),
            ),
          ),
          // Labels and Arrows
          Positioned(
            top: 50, // Adjust position
            left: 60,
            child: Row(
              children: [
                _buildLabel(
                  Colors.lightBlue,
                  'Supplies',
                  '50%',
                ),
              ],
            ),
          ),
          Positioned(
            top: 100,
            left: 220,
            child: _buildLabel(
              Colors.pinkAccent,
              'Utilities',
              '20%',
            ),
          ),
          Positioned(
            bottom: 100,
            left: 200,
            child: _buildLabel(
              Colors.yellow,
              'Travel',
              '20%',
            ),
          ),
          Positioned(
            bottom: 50,
            right: 80,
            child: _buildLabel(
              Colors.redAccent,
              'Misc',
              '20%',
            ),
          ),
          Positioned(
            top: 190,
            left: 100,
            child: _buildLabel(
              Colors.amber,
              'Gift',
              '10%',
            ),
          ),
        ],
      ),
    );
  }

  // Reusable method to build labels
  Widget _buildLabel(Color color, String title, String percentage) {
    return Row(
      children: [
        Container(
          height: 12,
          width: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 5),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            Text(
              percentage,
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }
}

List<PieChartSectionData> getSections() {
  return [
    PieChartSectionData(
      color: Colors.lightBlue, // Supplies
      value: 50,
      title: '',
      radius: 60,
    ),
    PieChartSectionData(
      color: Colors.pinkAccent, // Utilities
      value: 20,
      title: '',
      radius: 50,
    ),
    PieChartSectionData(
      color: Colors.yellow, // Travel
      value: 20,
      title: '',
      radius: 50,
    ),
    PieChartSectionData(
      color: Colors.redAccent, // Misc
      value: 20,
      title: '',
      radius: 50,
    ),
    PieChartSectionData(
      color: Colors.amber, // Gift
      value: 10,
      title: '',
      radius: 40,
    ),
  ];
}
