import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:officeflow/api_services.dart';
import 'package:officeflow/controller/app_controller.dart';
import 'package:officeflow/widgets/day_week_month.dart';
import 'package:officeflow/widgets/expense_overview.dart';
import 'package:officeflow/widgets/home_screen_container.dart';
import 'package:officeflow/widgets/home_screen_total_expense_cont.dart';
import 'package:officeflow/widgets/tab_bar.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final apiService = ApiServices();
  AppController controller = Get.find<AppController>();
  @override
  void initState() {
    controller.loadUserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            HomeScreenContainer(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: height * 0.010,
                    ),
                    HomeScreenTotalExpenseContainer(),
                    SizedBox(
                      height: height * 0.005,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: width * 0.045),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Expense Overview',
                          style: GoogleFonts.inter(
                              color: Color.fromRGBO(0, 0, 0, 1),
                              fontWeight: FontWeight.w600,
                              fontSize: width * 0.055),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.030,
                    ),
                    Obx(
                      () => ExpenseOverview(
                        currency: 'YEARLY PKR',
                        data: [
                          {
                            'value': controller.totalTodayAmount.value,
                            'color': Color.fromRGBO(255, 3, 3, 1)
                          },
                          {
                            'value': controller.totalWeeklyAmount.value,
                            'color': Color.fromRGBO(255, 213, 0, 1)
                          },
                          {
                            'value': controller.totalMonthlyAmount.value,
                            'color': Color.fromRGBO(236, 18, 214, 1)
                          },
                          {
                            'value': controller.totalYearlyAmount.value,
                            'color': Color.fromRGBO(114, 49, 153, 1)
                          },
                        ],
                        totalValue: controller.totalYearlyAmount.value,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.030,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        PieChartCategories(
                            color: Color.fromRGBO(255, 3, 3, 1),
                            label: 'Today'),
                        PieChartCategories(
                            color: Color.fromRGBO(255, 213, 0, 1),
                            label: 'Week'),
                        PieChartCategories(
                            color: Color.fromRGBO(236, 18, 214, 1),
                            label: 'Month'),
                        PieChartCategories(
                            color: Color.fromRGBO(114, 49, 153, 1),
                            label: 'Year'),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.010,
                    ),
                    Container(
                      height: height * 0.5,
                      child: TabBarExample(),
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
