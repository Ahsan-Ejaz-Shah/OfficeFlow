import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:officeflow/controller/app_controller.dart';
import 'package:officeflow/widgets/summary_piechart.dart';

class SummaryScreen extends StatefulWidget {
  const SummaryScreen({super.key});

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  final controller = Get.find<AppController>();
  @override
  void initState() {
    controller.fetchSummaryData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AppController>();

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Column(
          children: [
            Container(
              height: height * 0.15,
              decoration: BoxDecoration(
                color: Color.fromRGBO(114, 49, 153, 1),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: width * 0.045,
                    right: width * 0.055,
                    bottom: height * 0.020,
                  ),
                  child: Row(
                    children: [
                      Text(
                        'Summary',
                        style: GoogleFonts.inter(
                          fontSize: width * 0.050,
                          color: const Color.fromRGBO(255, 255, 255, 1),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: height * 0.5,
                      child: SummaryPieChart(),
                    ),
                    Text(
                      'Total Monthly Expenses',
                      style: GoogleFonts.inter(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontWeight: FontWeight.w700,
                        fontSize: width * 0.055,
                      ),
                    ),
                    Obx(
                      () => Text(
                        'PKR ${controller.totalMonthlyAmount.value}',
                        style: GoogleFonts.inter(
                          color: Color.fromRGBO(114, 49, 153, 1),
                          fontWeight: FontWeight.w700,
                          fontSize: width * 0.055,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
