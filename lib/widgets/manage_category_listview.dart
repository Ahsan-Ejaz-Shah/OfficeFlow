import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:officeflow/controller/app_controller.dart';
import 'package:officeflow/widgets/category_item.dart';
import 'package:officeflow/widgets/custom_elevated_button.dart';

class ManageCategoryListview extends StatefulWidget {
  ManageCategoryListview({super.key});

  @override
  State<ManageCategoryListview> createState() => _ManageCategoryListviewState();
}

class _ManageCategoryListviewState extends State<ManageCategoryListview> {
  final AppController controller = Get.find<AppController>();

  @override
  void initState() {
    super.initState();
    controller.fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ListView.builder(
        itemCount: controller.categories.length,
        itemBuilder: (context, index) {
          dynamic category = controller.categories[index];
          return CategoryItem(
            id: category.id,
            title: category.name,
            onDelete: () => controller.deleteCategories(category.id,),
            onEdit: () => _showEditDialog(
                context, category.id, controller.categories[index].name),
          );
        },
      );
    });
  }

  void _showEditDialog(
      BuildContext context, int categoryId, String currentCategoryName) {
    TextEditingController textController =
        TextEditingController(text: currentCategoryName);
    final width = MediaQuery.of(context).size.width;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        title: Text(
          'Edit Category',
          style: GoogleFonts.inter(
            color: Color.fromRGBO(0, 0, 0, 1),
            fontWeight: FontWeight.w600,
            fontSize: width * 0.050,
          ),
        ),
        content: TextField(
          controller: textController,
          decoration: InputDecoration(
            hintText: 'Enter new category name',
            hintStyle: GoogleFonts.inter(color: Color.fromRGBO(0, 0, 0, 0.45)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
        actions: [
          OutlinedButton(
            onPressed: () {
              Get.back();
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: Color.fromRGBO(114, 49, 153, 1),
              side: BorderSide(
                color: Color.fromRGBO(114, 49, 153, 1),
              ),
            ),
            child: Text('Cancel'),
          ),
          CustomElevatedButton(
            text: 'Save',
            onPressed: () {
              if (textController.text.isNotEmpty) {
                controller.editCategory(categoryId, textController.text, context);
              }
              Get.back();
            },
          ),
        ],
      ),
    );
  }
}
