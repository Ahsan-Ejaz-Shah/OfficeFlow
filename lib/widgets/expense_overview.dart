import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExpenseOverview extends StatelessWidget {
  final double totalValue; // Total value to display in the center
  final String currency; // Currency unit
  final List<Map<String, dynamic>> data; // Dynamic chart data

  const ExpenseOverview({
    super.key,
    required this.totalValue,
    required this.currency,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Container(
      height: height * 0.25,
      child: Stack(
        alignment: Alignment.center,
        children: [
          PieChart(
            PieChartData(
              centerSpaceRadius: width * 0.17,
              sections: _generateChartSections(width),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                totalValue.toString(),
                style: GoogleFonts.inter(
                  color: Color.fromRGBO(236, 18, 214, 1),
                  fontWeight: FontWeight.w600,
                  fontSize: width * 0.060,
                ),
              ),
              Text(
                currency,
                style: GoogleFonts.inter(
                  color: Color.fromRGBO(0, 0, 0, 1),
                  fontWeight: FontWeight.w600,
                  fontSize: width * 0.030,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> _generateChartSections(double width) {
    return data.map((entry) {
      return PieChartSectionData(
        color: entry['color'],
        value: entry['value'],
        showTitle: false,
        radius: width * 0.052,
      );
    }).toList();
  }
}
