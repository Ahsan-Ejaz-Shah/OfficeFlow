import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:officeflow/controller/app_controller.dart';

class HomeScreenTotalExpenseContainer extends StatelessWidget {
  const HomeScreenTotalExpenseContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AppController>();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(left: width * 0.040),
      child: Align(
        alignment: Alignment.topLeft,
        child: Container(
          height: height * 0.10,
          width: width * 0.50,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: Color.fromRGBO(114, 49, 153, 1),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height * 0.005,
              ),
              Padding(
                padding: EdgeInsets.only(left: width * 0.025),
                child: Text(
                  'Total Monthly Expense',
                  style: GoogleFonts.inter(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontWeight: FontWeight.w500,
                    fontSize: width * 0.040,
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.015,
              ),
              Padding(
                padding: EdgeInsets.only(right: width * 0.025),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Obx(
                    () => Text(
                      ' ${controller.totalMonthlyAmount.value} PKR',
                      style: GoogleFonts.inter(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          fontWeight: FontWeight.w600,
                          fontSize: width * 0.050),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
