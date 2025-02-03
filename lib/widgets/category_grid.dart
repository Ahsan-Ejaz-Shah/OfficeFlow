import 'dart:async';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:officeflow/controller/app_controller.dart';
import 'package:officeflow/widgets/custom_elevated_button.dart';

class CategoryGrid extends StatefulWidget {
  @override
  State<CategoryGrid> createState() => _CategoryGridState();
}

class _CategoryGridState extends State<CategoryGrid> {
  final AppController controller = Get.find<AppController>();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    controller.fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            color: Color.fromRGBO(0, 0, 0, 0.25),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
            top: height * 0.015, left: width * 0.045, right: width * 0.045),
        child: Obx(
          () => controller.isLoading.value
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4, // Number of items per row
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount:
                      controller.categories.length + 1, // +1 for the "+" button
                  itemBuilder: (context, index) {
                    if (index == controller.categories.length) {
                    
                      return GestureDetector(
                        onTap: () => _showAddCategoryDialog(context),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.purple,
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.add,
                              size: 30,
                              color: Colors.purple,
                            ),
                          ),
                        ),
                      );
                    }

                    // Category Item
                    final category = controller.categories[index];
                    return Container(
                      decoration: BoxDecoration(
                        color: category.color.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(category.icon, color: category.color, size: 28),
                          SizedBox(height: 5),
                          Text(
                            category.name,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }

  // Dialog to add a new category
  void _showAddCategoryDialog(BuildContext context) {
    //final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    showDialog(
      context: context,
      builder: (context) {
        return Form(
          key: _formKey,
          child: AlertDialog(
            backgroundColor: Colors.white,
            title: Row(
              children: [
                Image.asset(
                  'assets/images/createcategory-logo.png',
                ),
                Text(
                  "Create New Category",
                  style: GoogleFonts.inter(
                      color: Color.fromRGBO(0, 0, 0, 1),
                      fontWeight: FontWeight.w600,
                      fontSize: width * 0.050),
                ),
                Spacer(),
              ],
            ),
            content: TextFormField(
              validator: (Value) {
                if (controller.newCategoryController.text.isEmpty) {
                  return "Please Enter Category Name";
                }
                return null;
              },
              controller: controller.newCategoryController,
              decoration: InputDecoration(
                hintText: "Name Your Category",
                hintStyle:
                    GoogleFonts.inter(color: Color.fromRGBO(0, 0, 0, 0.45)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            actions: [
              Center(
                child: SizedBox(
                  width: width * 0.9,
                  child: controller.isLoading.value
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : CustomElevatedButton(
                          text: 'Create New',
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              if (controller
                                  .newCategoryController.text.isNotEmpty) {
                                controller.addCategory(context);
                                Timer(
                                  Duration(seconds: 1),
                                  controller.fetchCategories,
                                );

                                controller.newCategoryController.clear();
                                Navigator.pop(context);
                              }
                            }
                          },
                        ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
