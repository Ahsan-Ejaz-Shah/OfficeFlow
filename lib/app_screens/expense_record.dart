import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:officeflow/app_screens/main_screen.dart';
import 'package:officeflow/controller/app_controller.dart';

import 'package:officeflow/widgets/custom_elevated_button.dart';
import 'package:officeflow/widgets/filter_search_container.dart';
import 'package:officeflow/widgets/tab_bar.dart';

class ExpenseRecord extends StatefulWidget {
  const ExpenseRecord({super.key});

  @override
  State<ExpenseRecord> createState() => _ExpenseRecordState();
}

class _ExpenseRecordState extends State<ExpenseRecord> {
  AppController controller = Get.find<AppController>();
  @override
  void initState() {
    controller.fetchTodayExpenses();
    controller.fetchWeeklyExpenses();
    controller.fetchMonthlyExpenses();
    controller.fetchYearlyExpenses();
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
          controller.isViewingDetails.value = false;
          return true;
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: height * 0.15,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(114, 49, 153, 1),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: width * 0.040,
                      bottom: height * 0.015,
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.off(() => MainScreen());
                            controller.isViewingDetails.value = false;
                          },
                          child: const FaIcon(
                            FontAwesomeIcons.chevronLeft,
                            color: Color.fromRGBO(255, 255, 255, 1),
                          ),
                        ),
                        SizedBox(width: width * 0.01),
                        Text(
                          'Expense Records',
                          style: GoogleFonts.inter(
                            fontSize: width * 0.050,
                            color: const Color.fromRGBO(255, 255, 255, 1),
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                              useSafeArea: true,
                              context: context,
                              builder: (context) {
                                return Padding(
                                  padding: EdgeInsets.only(left: width * 0.080),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(width * 0.040),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            TextButton(
                                              onPressed: () {
                                                controller.startDate.value =
                                                    null;
                                                controller.endDate.value = null;
                                                controller.formattedStartDate
                                                    .value = '';
                                                controller.formattedEndDate
                                                    .value = '';
                                              },
                                              child: Text(
                                                'Clear filters',
                                                style: GoogleFonts.inter(
                                                  color: Color.fromRGBO(
                                                      255, 3, 3, 1),
                                                  decoration:
                                                      TextDecoration.underline,
                                                  decorationColor:
                                                      Color.fromRGBO(
                                                          255, 3, 3, 1),
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        'Start Date',
                                        style: GoogleFonts.inter(
                                            fontWeight: FontWeight.w300,
                                            color: Color.fromRGBO(0, 0, 0, 1),
                                            fontSize: width * 0.050),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          controller.dateTimePicker(context,
                                              isStart: true);
                                        },
                                        child: Obx(
                                          () => FilterSearchContainer(
                                            pickedDate: controller
                                                    .formattedStartDate
                                                    .value
                                                    .isEmpty
                                                ? "Select Start Date"
                                                : controller
                                                    .formattedStartDate.value,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: height * 0.030,
                                      ),
                                      Text(
                                        'End Date',
                                        style: GoogleFonts.inter(
                                            fontWeight: FontWeight.w300,
                                            color: Color.fromRGBO(0, 0, 0, 1),
                                            fontSize: width * 0.050),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          controller.dateTimePicker(context,
                                              isStart: false);
                                        },
                                        child: Obx(
                                          () => FilterSearchContainer(
                                            pickedDate: controller
                                                    .formattedEndDate
                                                    .value
                                                    .isEmpty
                                                ? "Select End Date"
                                                : controller
                                                    .formattedEndDate.value,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: height * 0.030,
                                      ),
                                      Center(
                                        child: SizedBox(
                                          width: width * 0.35,
                                          child: CustomElevatedButton(
                                            text: 'Save',
                                            onPressed: () {
                                              if (controller.startDate.value ==
                                                      null ||
                                                  controller.endDate.value ==
                                                      null) {
                                                Get.snackbar("Error",
                                                    "Please select both start and end dates.",
                                                    backgroundColor:
                                                        Colors.red);
                                                return;
                                              }

                                              // Pass DateTime objects to fetchFilterExpenses
                                              controller.fetchFilterExpenses(
                                                fromDate:
                                                    controller.startDate.value!,
                                                toDate:
                                                    controller.endDate.value!,
                                              );
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          icon: const FaIcon(
                            FontAwesomeIcons.filter,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: width * 0.025,
                  right: width * 0.025,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: height * 0.78,
                        child: TabBarExample(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
