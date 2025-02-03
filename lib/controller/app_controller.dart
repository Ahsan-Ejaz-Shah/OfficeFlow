import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

import 'package:intl/intl.dart';
import 'package:officeflow/api_services.dart';
import 'package:officeflow/app_screens/main_screen.dart';

import 'package:officeflow/models/category.dart';
import 'package:officeflow/models/category_summary.dart';
import 'package:officeflow/models/expense.dart';

class AppController extends GetxController {
  var categories = <Category>[].obs;
  var expenses = <Expense>[].obs;
  final totalSummaryAmount = 0.0.obs;
  var categorySummary = <CategorySummary>[].obs;

  var selectedCategory = ''.obs;
  var selectedDate = ''.obs;
  var selectedTime = ''.obs;
  int? selectedCategoryId;
  RxBool isViewingDetails = false.obs;
  RxDouble totalTodayAmount = 0.0.obs;
  RxDouble totalWeeklyAmount = 0.0.obs;
  RxDouble totalMonthlyAmount = 0.0.obs;
  RxDouble totalYearlyAmount = 0.0.obs;
  var userName = ''.obs;
  var userEmail = ''.obs;
  Rx<File?> userImage = Rx<File?>(null);
  var selectedDateTimeController = Rx<DateTime?>(null);
  var startDate = Rx<DateTime?>(null);
  var endDate = Rx<DateTime?>(null);
  RxInt selectedIndex = 0.obs;
  var formattedStartDate = ''.obs;
  var formattedEndDate = ''.obs;
  var isLoading = false.obs;
  var isLoggedIn = false.obs;
  var isChecked = false.obs;
  var obscureText = true.obs;
  var obscureTextSec = true.obs;
  var obscureTextThird = true.obs;
  var currentPage = 0.obs;
  var emailValidationMsg = ''.obs;
  var passwordValidationMsg = ''.obs;
  var regEmailValidationMsg = ''.obs;
  var regPasswordValidationMsg = ''.obs;
  var nameValidationMsg = ''.obs;
  var totalExpense = 0.obs;
  Rx<dynamic> selectedImage = Rx<dynamic>(null);
  final ImagePicker picker = ImagePicker();
  final apiService = ApiServices();

  final emailAddressController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final regEmailController = TextEditingController();
  final regPassController = TextEditingController();
  final confirmPassController = TextEditingController();
  final userProfilePassController = TextEditingController();
  final newCategoryController = TextEditingController();
  final expenseAmountController = TextEditingController();
  final expenseTitleController = TextEditingController();
  final expenseDescriptionController = TextEditingController();

  final storage = GetStorage();

  @override
  void dispose() {
    emailAddressController.dispose();
    passwordController.dispose();
    nameController.dispose();
    regEmailController.dispose();
    regPassController.dispose();
    super.dispose();
  }

  Future<void> pickImage(BuildContext context,
      {required ImageSource source}) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
    }
    Navigator.pop(context);
  }

  void onItemTapped(int index) {
    selectedIndex.value = index;
  }

  Future<void> pickDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      selectedDate.value =
          "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
      addExpenseSelectedDateTime();
    }
  }

  // Function to pick time
  Future<void> pickTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      selectedTime.value = pickedTime.format(context);
      addExpenseSelectedDateTime();
    }
  }

  Future<void> fetchSummaryData() async {
    try {
      final result = await apiService.fetchCategorySummary();
      categorySummary.assignAll(result['categories']);
      totalSummaryAmount.value = result['totalAmount'];
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch summary: $e',
          backgroundColor: Get.theme.colorScheme.error);
    }
  }

  Future<void> updateUserProfile(
    String name,
    String email,
    File? imageFile,
  ) async {
    try {
      final response =
          await apiService.updateUserProfile(name, email, imageFile);

      if (response.statusCode == 200) {
        userName.value = name;
        userEmail.value = email;
        if (imageFile != null) {
          selectedImage.value = imageFile;
          storage.write('userImage', imageFile.path);
        }
        storage.write('userName', name);
        storage.write('userEmail', email);
        Get.snackbar(
          'Success',
          'Profile updated successfully!',
          backgroundColor: Colors.green,
        );
      } else {
        Get.snackbar(
          'Error',
          'Failed to update profile: ${response.body}',
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An error occurred: $e',
        backgroundColor: Colors.red,
      );
    }
  }

  void addExpenseSelectedDateTime() {
    if (selectedDate.value.isNotEmpty && selectedTime.value.isNotEmpty) {
      try {
        DateTime date = DateFormat('yyyy-MM-dd').parse(selectedDate.value);
        TimeOfDay time = TimeOfDay(
          hour: int.parse(selectedTime.value.split(":")[0]),
          minute: int.parse(selectedTime.value.split(":")[1]),
        );

        selectedDateTimeController.value = DateTime(
          date.year,
          date.month,
          date.day,
          time.hour,
          time.minute,
        );
      } catch (e) {
        selectedDateTimeController.value = null;
      }
    }
  }

  Future<void> dateTimePicker(BuildContext context,
      {required bool isStart}) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime(DateTime.now().year + 1),
    );

    if (pickedDate != null) {
      if (isStart) {
        startDate.value = pickedDate;
        formattedStartDate.value = DateFormat('yyyy-MM-dd').format(pickedDate);

        // Clear end date if it is before the start date
        if (endDate.value != null && endDate.value!.isBefore(pickedDate)) {
          endDate.value = null;
          formattedEndDate.value = '';
        }
      } else {
        if (startDate.value != null && pickedDate.isBefore(startDate.value!)) {
          Get.back();
          Get.snackbar(
            "Invalid Date",
            "End date cannot be before the start date.",
            backgroundColor: Colors.red,
          );
        } else {
          endDate.value = pickedDate;
          formattedEndDate.value = DateFormat('yyyy-MM-dd').format(pickedDate);
        }
      }
    }
  }

  Future<void> fetchFilterExpenses(
      {required DateTime fromDate, required DateTime toDate}) async {
    try {
      List<Expense> fetchedExpenses = await apiService.fetchFilterExpenses(
          fromDate: fromDate, toDate: toDate);

      expenses.value = fetchedExpenses;

      if (fetchedExpenses.isEmpty) {
        Get.snackbar("No Results", "No expenses found for the selected dates.",
            backgroundColor: Colors.yellow);
      } else {
        Get.snackbar("Success", "Expenses filter successfully!",
            backgroundColor: Colors.green);
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch expenses: $e",
          backgroundColor: Colors.red);
    }
  }

  void toggleObscureText() {
    obscureText.value = !obscureText.value;
  }

  void toggleConfirmObscureText() {
    obscureTextSec.value = !obscureTextSec.value;
  }

  void toggleUserActionObscureText() {
    obscureTextThird.value = !obscureTextThird.value;
  }

  void clearValidationMessages() {
    regEmailValidationMsg.value = '';
    regPasswordValidationMsg.value = '';
    nameValidationMsg.value = '';
    emailValidationMsg.value = '';
    passwordValidationMsg.value = '';
  }

  void isCheckBoxChecked(bool? value) {
    if (value != null) {
      isChecked.value = value;
    }
  }

  String? validateEmail(String? email, {bool isRegistration = false}) {
    if (email == null || email.isEmpty) {
      if (isRegistration) {
        regEmailValidationMsg.value = 'Email is Required';
      } else {
        emailValidationMsg.value = 'Email is Required';
      }
      return null;
    }
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!emailRegex.hasMatch(email)) {
      if (isRegistration) {
        regEmailValidationMsg.value =
            'The email must be a valid email address.';
      } else {
        emailValidationMsg.value = 'Enter a valid email address';
      }
      return null;
    }
    if (isRegistration) {
      regEmailValidationMsg.value = '';
    } else {
      emailValidationMsg.value = '';
    }
    return null;
  }

  Future<void> loadUserDetails() async {
    userName.value = storage.read('userName') ?? '';
    userEmail.value = storage.read('userEmail') ?? '';
    String? storedImagePath = storage.read('userImage');

    if (storedImagePath != null && storedImagePath.isNotEmpty) {
      if (storedImagePath.startsWith('http') ||
          storedImagePath.startsWith('https')) {
        selectedImage.value = storedImagePath;
      } else {
        selectedImage.value = File(storedImagePath);
      }
    }

    totalTodayAmount.value = storage.read('today_totalAmount') ?? 0.0;
    totalWeeklyAmount.value = storage.read('weekly_totalAmount') ?? 0.0;
    totalMonthlyAmount.value = storage.read('monthly_totalAmount') ?? 0.0;
    totalYearlyAmount.value = storage.read('yearly_totalAmount') ?? 0.0;
  }

  Future<void> signIn() async {
    if (emailAddressController.text.isEmpty ||
        passwordController.text.isEmpty) {
      Get.snackbar("Error", "Email and Password are required!",
          backgroundColor: Colors.red);
      return;
    }

    isLoading.value = true;
    try {
      final response = await apiService.signIn(
        emailAddressController.text.trim(),
        passwordController.text.trim(),
      );

      if (response.containsKey('data') &&
          response['data'].containsKey('user')) {
        final userData = response['data']['user'];

        final userNameFromApi = userData['name'] ?? "Unknown";
        final userEmailFromApi = userData['email'] ?? "Unknown";
        final userImageFromApi = userData['image'] ?? "";

        storage.write('userName', userNameFromApi);
        storage.write('userEmail', userEmailFromApi);
        storage.write('userImage', userImageFromApi);

        userName.value = userNameFromApi;
        userEmail.value = userEmailFromApi;

        emailAddressController.clear();
        passwordController.clear();
        isLoading.value = false;

        Get.off(() => MainScreen());
      } else {
        isLoading.value = false;
        Get.snackbar("Error", response['message'] ?? "Login failed",
            backgroundColor: Colors.red);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(), backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> changePass(
      String currentPass, String newPass, String confirmPass) async {
    try {
      final success =
          await apiService.changePassword(currentPass, newPass, confirmPass);

      if (success) {
        Get.snackbar("Success", "Password changed successfully",
            backgroundColor: Colors.lightGreen);
      } else {
        Get.snackbar("Error", "Failed to change password",
            backgroundColor: Colors.red);
      }
    } catch (e) {
      Get.snackbar("", e.toString(), backgroundColor: Colors.red);
    }
  }

  Future<void> signUp() async {
    if (nameController.text.isEmpty ||
        regEmailController.text.isEmpty ||
        regPassController.text.isEmpty ||
        confirmPassController.text.isEmpty) {
      Get.snackbar("Error", "All fields are required!",
          backgroundColor: Colors.red);
      return;
    }

    if (regPassController.text != confirmPassController.text) {
      Get.snackbar("Error", "Passwords do not match!",
          backgroundColor: Colors.red);
      return;
    }

    isLoading.value = true;
    try {
      final response = await apiService.signUp(
        nameController.text,
        regEmailController.text,
        regPassController.text,
        confirmPassController.text,
      );

      if (response.containsKey('success') && response['success'] == true) {
        Get.snackbar("Success", response['message'] ?? "Sign Up successful!",
            backgroundColor: Colors.green);

        nameController.clear();
        regEmailController.clear();
        regPassController.clear();
        confirmPassController.clear();
        isLoading.value = false;
      } else {
        Get.snackbar("Error", response['message'] ?? "Failed to sign up",
            backgroundColor: Colors.red);
      }
    } catch (e) {
      Get.snackbar("", e.toString(), backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteExpense(String expenseId) async {
    try {
      final success = await apiService.deleteExpense(expenseId);

      if (success) {
        Get.snackbar("Success", "Expense deleted successfully!",
            backgroundColor: Colors.lightGreen);

        isLoading.value = true;
        await fetchTodayExpenses();
        await fetchWeeklyExpenses();
        await fetchMonthlyExpenses();
        await fetchYearlyExpenses();
      } else {
        Get.snackbar("Error", "Failed to delete expense",
            backgroundColor: Colors.red);
        isLoading.value = false;
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(), backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchTodayExpenses() async {
    isLoading.value = true;
    try {
      final result = await apiService.fetchTodayExpenses();
      expenses.assignAll(result['expenses']);
      totalTodayAmount.value = result['totalAmount'];

      await storage.write('today_totalAmount', result['totalAmount']);
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch today\'s expenses: $e',
          backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchWeeklyExpenses() async {
    isLoading.value = true;
    try {
      final result = await apiService.fetchWeeklyExpenses();
      expenses.assignAll(result['expenses']);
      totalWeeklyAmount.value = result['totalAmount'];

      await storage.write('weekly_totalAmount', result['totalAmount']);
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch weekly expenses: $e',
          backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchMonthlyExpenses() async {
    isLoading.value = true;
    try {
      final result = await apiService.fetchMonthlyExpenses();
      expenses.assignAll(result['expenses']);
      totalMonthlyAmount.value = result['totalAmount'];

      await storage.write('monthly_totalAmount', result['totalAmount']);
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch monthly expenses: $e',
          backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchYearlyExpenses() async {
    isLoading.value = true;
    try {
      final result = await apiService.fetchYearlyExpenses();
      expenses.assignAll(result['expenses']);
      totalYearlyAmount.value = result['totalAmount'];

      await storage.write('yearly_totalAmount', result['totalAmount']);
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch yearly expenses: $e',
          backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> editExpense(
    int id,
    String title,
    String amount,
    DateTime dateTime,
    int categoryId,
  ) async {
    isLoading.value = true;
    try {
      final success = await apiService.updateExpense(
          id, title, amount, dateTime, categoryId);

      if (success) {
        await fetchTodayExpenses();
        await fetchWeeklyExpenses();
        await fetchMonthlyExpenses();
        await fetchYearlyExpenses();
        Get.snackbar("Success", "Expense updated successfully",
            backgroundColor: Colors.lightGreen);
      } else {
        Get.snackbar("Error", "Failed to update expense",
            backgroundColor: Colors.red);
      }
    } catch (e) {
      Get.snackbar("", e.toString(), backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> saveExpense(BuildContext context) async {
    isLoading.value = true;
    try {
      if (selectedDateTimeController.value == null) {
        throw Exception("Please select a valid date and time.");
      }
      if (selectedCategoryId == null) {
        throw Exception("Please select a valid category.");
      }

      final success = await apiService.addExpense(
        expenseTitleController.text.trim(),
        expenseAmountController.text.trim(),
        selectedDateTimeController.value!,
        selectedCategoryId!,
      );

      if (success) {
        Get.snackbar("Success", "Expense saved successfully",
            backgroundColor: Colors.lightGreen);
        expenseTitleController.clear();
        expenseAmountController.clear();
        expenseDescriptionController.clear();
        selectedDateTimeController.value = null;
      } else {
        Get.snackbar("Error", "Failed to save expense",
            backgroundColor: Colors.red);
      }
    } catch (e) {
      Get.snackbar("", e.toString(), backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> editCategory(
      int id, String newName, BuildContext context) async {
    isLoading.value = true;
    try {
      final success = await apiService.updateCategory(id, newName);

      if (success) {
        await fetchCategories();
        Get.snackbar("Success", "Category updated successfully",
            backgroundColor: Colors.lightGreen);
      } else {
        Get.snackbar("Error", "Failed to update category",
            backgroundColor: Colors.red);
      }
    } catch (e) {
      Get.snackbar("", e.toString(), backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteCategories(
    int id,
  ) async {
    isLoading.value = true;
    try {
      final success = await apiService.deleteCategory(id);

      if (success) {
        await fetchCategories();
        Get.snackbar("Success", "Category deleted successfully",
            backgroundColor: Colors.lightGreen);
      } else {
        Get.snackbar("Error", "Failed to delete category",
            backgroundColor: Colors.red);
      }
    } catch (e) {
      Get.snackbar("", e.toString(), backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchCategories() async {
    isLoading.value = true;
    try {
      final fetchedCategories = await apiService.fetchCategory();
      categories.assignAll(fetchedCategories);
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch categories: $e",
          backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addCategory(BuildContext context) async {
    isLoading.value = true;
    try {
      final response =
          await apiService.addCategory(newCategoryController.text.trim());

      if (response['success'] == true) {
        await fetchCategories();
        isLoading.value = false;
        Get.snackbar(
          "Success",
          response['message'] ?? "Category added successfully",
          backgroundColor: Colors.lightGreen,
        );
      } else {
        isLoading.value = false;
        Get.snackbar(
          "Error",
          response['message'] ?? "Failed to add category",
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      Get.snackbar(
        "",
        e.toString(),
        backgroundColor: Colors.red,
      );
    } finally {
      isLoading.value = false;
    }
  }

  String? validatePassword(String? password, {bool isRegistration = false}) {
    if (password == null || password.isEmpty) {
      if (isRegistration) {
        regPasswordValidationMsg.value = 'Password is required';
      } else {
        passwordValidationMsg.value = 'Password is required';
      }
      return null;
    }
    if (password.length < 6) {
      String error = 'Password must contain at least 6 characters.';
      if (isRegistration) {
        regPasswordValidationMsg.value = error;
      }

      return null;
    }

    if (isRegistration) {
      regPasswordValidationMsg.value = '';
    } else {
      passwordValidationMsg.value = '';
    }
    return null;
  }

  String? validateName(String? name) {
    if (name == null || name.isEmpty) {
      nameValidationMsg.value = 'Name is required';
      return null;
    }
    nameValidationMsg.value = '';
    return null;
  }
}
