import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:officeflow/app_screens/expense_record.dart';
import 'package:officeflow/controller/app_controller.dart';

class TabBarExample extends StatefulWidget {
  const TabBarExample({super.key});

  @override
  State<TabBarExample> createState() => _TabBarExampleState();
}

class _TabBarExampleState extends State<TabBarExample>
    with SingleTickerProviderStateMixin {
  final controller = Get.find<AppController>();
  late TabController _tabController;

  @override
  void initState() {
    _fetchExpenses(0);
    _fetchExpenses(1);
    _fetchExpenses(2);
    _fetchExpenses(3);
    _tabController = TabController(length: 4, vsync: this);

    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        _fetchExpenses(_tabController.index);
      }
    });
    super.initState();
  }

  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _fetchExpenses(int index) {
    switch (index) {
      case 0:
        controller.fetchTodayExpenses();
        break;
      case 1:
        controller.fetchWeeklyExpenses();
        break;
      case 2:
        controller.fetchMonthlyExpenses();
        break;
      case 3:
        controller.fetchYearlyExpenses();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Column(
      children: [
        SizedBox(height: height * 0.025),
        Container(
          margin: EdgeInsets.symmetric(horizontal: width * 0.03),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(236, 18, 214, 0.13),
            border: Border.all(
              color: const Color.fromRGBO(236, 18, 214, 1),
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          child: TabBar(
            controller: _tabController,
            dividerColor: Colors.transparent,
            indicatorPadding: EdgeInsets.all(width * 0.015),
            indicatorSize: TabBarIndicatorSize.tab,
            labelStyle: GoogleFonts.inter(
              fontWeight: FontWeight.w700,
            ),
            indicator: BoxDecoration(
              color: const Color.fromRGBO(114, 49, 153, 1),
              borderRadius: BorderRadius.circular(15),
            ),
            labelColor: Colors.white,
            unselectedLabelColor: Colors.black,
            tabs: const [
              Tab(text: 'Today'),
              Tab(text: 'Week'),
              Tab(text: 'Month'),
              Tab(text: 'Year'),
            ],
            onTap: (index) {
              _fetchExpenses(index);
            },
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildTabContent(context, "Today"),
              _buildTabContent(context, "Week"),
              _buildTabContent(context, "Month"),
              _buildTabContent(context, "Year"),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTabContent(BuildContext context, String tabType) {
    final width = MediaQuery.of(context).size.width;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Obx(() {
          if (controller.isViewingDetails.value) {
            return SizedBox.shrink();
          }
          return Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding:
                  EdgeInsets.only(left: width * 0.045, right: width * 0.035),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recent Expenses',
                    style: GoogleFonts.inter(
                        color: const Color.fromRGBO(0, 0, 0, 1),
                        fontWeight: FontWeight.w600,
                        fontSize: width * 0.050),
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () async {
                      controller.isViewingDetails.value = true;
                      final route = await Get.to(() => const ExpenseRecord());
                      if (route != null) {
                        controller.isViewingDetails.value = false;
                      }
                    },
                    child: Text(
                      'View details',
                      style: GoogleFonts.inter(
                        color: const Color.fromRGBO(30, 0, 254, 1),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
        Expanded(
          child: Obx(() {
            if (controller.isLoading.value) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (controller.expenses.isEmpty) {
              return Center(
                child: Text(
                  'No expenses available.',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w400,
                    fontSize: width * 0.045,
                    color: Colors.grey,
                  ),
                ),
              );
            }

            return ListView.separated(
              padding: EdgeInsets.all(width * 0.025),
              //shrinkWrap: true,
              separatorBuilder: (context, index) => SizedBox(height: 5),
              itemCount: controller.expenses.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.all(width * 0.010),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(236, 18, 214, 0.13),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Color.fromRGBO(236, 18, 214, 0.13)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Text(
                          controller.expenses[index].title,
                          style: GoogleFonts.inter(
                              fontSize: width * 0.035,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Text(
                          controller.expenses[index].dateTime,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            fontSize: width * 0.035,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          'PKR ${controller.expenses[index].amount}',
                          textAlign: TextAlign.end,
                          style: GoogleFonts.inter(
                            fontSize: width * 0.035,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.edit,
                          //color: Colors.black,
                        ),
                        onPressed: () {
                          _showEditDialog(
                              context, index, controller.categories[index].id);
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.delete,
                          //color: Colors.black,
                          
                        ),
                        onPressed: () {
                          _showDeleteDialog(context,
                              controller.expenses[index].id.toString());
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          }),
        ),
      ],
    );
  }

  void _showEditDialog(BuildContext context, int index, int id) {
    final width = MediaQuery.of(context).size.width;
    final editExpenseTitleController =
        TextEditingController(text: controller.expenses[index].title);
    final editExpenseAmountController = TextEditingController(
        text: controller.expenses[index].amount.toString());
    // Initialize date and time controllers
    final initialDateTime = DateTime.parse(controller.expenses[index].dateTime);
    final dateController = TextEditingController(
      text: "${initialDateTime.toLocal()}".split(' ')[0], // yyyy-MM-dd
    );
    final timeController = TextEditingController(
      text: TimeOfDay.fromDateTime(initialDateTime)
          .format(context), // hh:mm AM/PM
    );

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        title: Text(
          'Edit Expense',
          style: GoogleFonts.inter(
            color: Color.fromRGBO(114, 49, 153, 1),
            fontSize: width * 0.065,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: editExpenseTitleController,
              decoration: InputDecoration(
                  labelText: 'Title', labelStyle: GoogleFonts.inter()),
            ),
            TextField(
              controller: editExpenseAmountController,
              decoration: InputDecoration(
                  labelText: 'Amount', labelStyle: GoogleFonts.inter()),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: dateController,
              decoration: InputDecoration(
                labelText: 'Date (yyyy-MM-dd)',
                labelStyle: GoogleFonts.inter(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: () async {
                    final pickedDate = await showDatePicker(
                      context: context,
                      initialDate: initialDateTime,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );

                    if (pickedDate != null) {
                      dateController.text =
                          "${pickedDate.toLocal()}".split(' ')[0]; // yyyy-MM-dd
                    }
                  },
                ),
              ),
            ),
            // Time input
            TextField(
              controller: timeController,
              decoration: InputDecoration(
                labelText: 'Time (hh:mm AM/PM)',
                labelStyle: GoogleFonts.inter(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.access_time),
                  onPressed: () async {
                    final pickedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(initialDateTime),
                    );

                    if (pickedTime != null) {
                      timeController.text =
                          pickedTime.format(context); // hh:mm AM/PM
                    }
                  },
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text(
              'Cancel',
              style: GoogleFonts.inter(),
            ),
          ),
          Obx(
            () => controller.isLoading.value
                ? CircularProgressIndicator()
                : TextButton(
                    onPressed: () async {
                      final selectedDate = dateController.text;
                      final selectedTime = timeController.text;

                      if (selectedDate.isNotEmpty && selectedTime.isNotEmpty) {
                        try {
                          DateTime date =
                              DateFormat('yyyy-MM-dd').parse(selectedDate);
                          TimeOfDay time = TimeOfDay(
                            hour: int.parse(selectedTime.split(":")[0]),
                            minute: int.parse(
                                selectedTime.split(":")[1].split(" ")[0]),
                          );

                          DateTime combinedDateTime = DateTime(
                            date.year,
                            date.month,
                            date.day,
                            time.hour,
                            time.minute,
                          );

                          await controller.editExpense(
                              controller.expenses[index].id,
                              editExpenseTitleController.text,
                              editExpenseAmountController.text,
                              combinedDateTime,
                              controller.categories[index].id);
                        } catch (e) {
                          print("Error combining date and time: $e");
                        }
                      }
                    },
                    child: Text('Update', style: GoogleFonts.inter()),
                  ),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, String expenseId) {
    final width = MediaQuery.of(context).size.width;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        title: Text(
          'Delete Expense',
          style: GoogleFonts.inter(
            color: Color.fromRGBO(114, 49, 153, 1),
            fontSize: width * 0.065,
          ),
        ),
        content: Text(
          'Are you sure you want to delete this expense?',
          style: GoogleFonts.inter(
            color: Color.fromRGBO(0, 0, 0, 0.7),
            fontSize: width * 0.045,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text('Cancel', style: GoogleFonts.inter()),
          ),
          TextButton(
            onPressed: () {
              controller.deleteExpense(
                expenseId,
              );

              Get.back();
            },
            child: Text('Delete', style: GoogleFonts.inter(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
