import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:officeflow/app_screens/main_screen.dart';
import 'package:officeflow/controller/app_controller.dart';
import 'package:officeflow/widgets/custom_elevated_button.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AppController controller = Get.find<AppController>();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: WillPopScope(
        onWillPop: () async{
          return true;
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
                      GestureDetector(
                        onTap: () {
                          Get.off(() => MainScreen());
                        },
                        child: const FaIcon(
                          FontAwesomeIcons.chevronLeft,
                          color: Color.fromRGBO(255, 255, 255, 1),
                        ),
                      ),
                      SizedBox(width: width * 0.01),
                      Text(
                        'Add Expense',
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
            SizedBox(
              height: height * 0.045,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(left: width * 0.055),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Office Supplies',
                          style: GoogleFonts.inter(
                            color: Color.fromRGBO(114, 49, 153, 1),
                            fontWeight: FontWeight.w700,
                            fontSize: width * 0.060,
                          ),
                        ),
                        SizedBox(
                          height: height * 0.020,
                        ),
                        Container(
                          width: width * 0.9,
                          height: height * 0.065,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(186, 157, 204, 0.13),
                            border: Border.all(
                              color: Color.fromRGBO(114, 49, 153, 1),
                            ),
                            borderRadius: BorderRadius.circular(22),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: Obx(
                              () => DropdownButton(
                                iconSize: 35,
                                iconEnabledColor: Color.fromRGBO(0, 0, 0, 1),
                                dropdownColor: Colors.white,
                                value: controller.selectedCategory.value.isEmpty
                                    ? null
                                    : controller.selectedCategory.value,
                                hint: Padding(
                                  padding: EdgeInsets.only(left: width * 0.035),
                                  child: Text(
                                    "Categories",
                                    style: GoogleFonts.inter(
                                      color: Color.fromRGBO(0, 0, 0, 1),
                                      fontWeight: FontWeight.w600,
                                      fontSize: width * 0.045,
                                    ),
                                  ),
                                ),
                                items: controller.categories.map(
                                  (category) {
                                    return DropdownMenuItem(
                                      value: category.name,
                                      child: Padding(
                                        padding:
                                            EdgeInsets.only(left: width * 0.035),
                                        child: Text(
                                          category.name,
                                          style: GoogleFonts.inter(
                                              color: Color.fromRGBO(0, 0, 0, 1),
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    );
                                  },
                                ).toList(),
                                onChanged: (value) {
                                  controller.selectedCategory.value = value!;
        
                                  controller.selectedCategoryId = controller
                                      .categories
                                      .firstWhere(
                                          (category) => category.name == value)
                                      .id;
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.020,
                        ),
                        Text(
                          'Enter Amount',
                          style: GoogleFonts.inter(
                            color: Color.fromRGBO(0, 0, 0, 1),
                            fontWeight: FontWeight.w600,
                            fontSize: width * 0.055,
                          ),
                        ),
                        SizedBox(
                          height: height * 0.010,
                        ),
                        Container(
                          width: width * 0.9,
                          height: height * 0.065,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(186, 157, 204, 0.13),
                            border: Border.all(
                              color: Color.fromRGBO(114, 49, 153, 1),
                            ),
                            borderRadius: BorderRadius.circular(22),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(left: width * 0.055),
                                  child: TextFormField(
                                    validator: (Value) {
                                      if (controller
                                          .expenseAmountController.text.isEmpty) {
                                        return 'Please enter an amount';
                                      }
                                      return null;
                                    },
                                    controller:
                                        controller.expenseAmountController,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: width * 0.045),
                                child: Text(
                                  'PKR',
                                  style: GoogleFonts.inter(
                                      color: Color.fromRGBO(0, 0, 0, 1),
                                      fontWeight: FontWeight.w600,
                                      fontSize: width * 0.055),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height * 0.045,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Text('Select Date:', style: GoogleFonts.inter(fontWeight: FontWeight.bold),),
                            GestureDetector(
                              onTap: () {
                                controller.pickDate(context);
                              },
                              child: Padding(
                                padding: EdgeInsets.only(right: width * 0.02),
                                child: Container(
                                  height: height * 0.050,
                                  width: width * 0.3,
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(114, 49, 153, 0.45),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Center(
                                    child: Obx(
                                      () => Text(
                                        controller.selectedDate.value.isEmpty
                                            ? 'Select Date'
                                            : controller.selectedDate.value,
                                        style: GoogleFonts.inter(
                                          color: Color.fromRGBO(255, 255, 255, 1),
                                          fontSize: width * 0.040,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                      
                            GestureDetector(
                              onTap: () {
                                controller.pickTime(context);
                              },
                              child: Padding(
                                padding: EdgeInsets.only(right: width * 0.055),
                                child: Container(
                                  height: height * 0.050,
                                  width: width * 0.3,
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(114, 49, 153, 0.45),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Center(
                                    child: Obx(
                                      () => Text(
                                        controller.selectedTime.value.isEmpty
                                            ? 'Select Time'
                                            : controller.selectedTime.value,
                                        style: GoogleFonts.inter(
                                          color: Color.fromRGBO(255, 255, 255, 1),
                                          fontSize: width * 0.040,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.020,
                        ),
                        Container(
                          width: width * 0.9,
                          height: height * 0.070,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(246, 241, 247, 1),
                            borderRadius: BorderRadius.circular(22),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: width * 0.045,
                              right: width * 0.045,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    validator: (Value) {
                                      if (controller
                                          .expenseTitleController.text.isEmpty) {
                                        return 'Please enter title';
                                      }
                                      return null;
                                    },
                                    controller: controller.expenseTitleController,
                                    keyboardType: TextInputType.name,
                                    decoration: InputDecoration(
                                      hintText: 'Title',
                                      hintStyle: GoogleFonts.inter(
                                        color: Color.fromRGBO(0, 0, 0, 0.58),
                                      ),
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                    ),
                                  ),
                                ),
                                FaIcon(
                                  FontAwesomeIcons.t,
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.020,
                        ),
                        Container(
                          width: width * 0.9,
                          height: height * 0.2,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(246, 241, 247, 1),
                            borderRadius: BorderRadius.circular(22),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: width * 0.045,
                              right: width * 0.045,
                            ),
                            child: Row(
                              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    validator: (Value) {
                                      if (controller.expenseDescriptionController
                                          .text.isEmpty) {
                                        return 'Please enter description';
                                      }
                                      return null;
                                    },
                                    controller:
                                        controller.expenseDescriptionController,
                                    onChanged: (value) {
                                      // enteredAmount = value;
                                    },
                                    keyboardType: TextInputType.name,
                                    maxLines: 4,
                                    decoration: InputDecoration(
                                      hintText: 'Notes',
                                      hintStyle: GoogleFonts.inter(
                                        color: Color.fromRGBO(0, 0, 0, 0.58),
                                      ),
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.030,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: width * 0.025),
                          child: SizedBox(
                            height: height * 0.058,
                            width: width * 0.85,
                            child: Obx(
                              () => controller.isLoading.value
                                  ? Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : CustomElevatedButton(
                                      text: 'Save Record',
                                      onPressed: () {
                                        if (_formKey.currentState!.validate() ||
                                            controller.selectedCategory.value
                                                .isNotEmpty) {
                                          controller.saveExpense(context);
                                        } else {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                backgroundColor: Colors.white,
                                                title: Text(
                                                  'Error',
                                                  style: GoogleFonts.inter(),
                                                ),
                                                content: Text(
                                                  'Please Select Category',
                                                  style: GoogleFonts.inter(),
                                                ),
                                                actions: [
                                                  CustomElevatedButton(
                                                      text: 'Okay',
                                                      onPressed: () {
                                                        Get.back();
                                                      }),
                                                ],
                                              );
                                            },
                                          );
                                        }
                                      },
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
