import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import 'package:officeflow/app_screens/sign_in_screen.dart';

import 'package:officeflow/models/category.dart';
import 'package:officeflow/models/category_summary.dart';
import 'package:officeflow/models/expense.dart';

class ApiServices {
  final String baseUrl = "https://office-expense.webexert.us/api";
  final secureStorage = FlutterSecureStorage(aOptions: AndroidOptions(encryptedSharedPreferences: true));
  Future<Map<String, dynamic>> fetchCategorySummary() async {
    final url = Uri.parse('$baseUrl/summary');
    final token = await secureStorage.read(key: 'token_key');

    if (token == null) {
      throw Exception("Token not found. Please log in again.");
    }

    try {
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        print(jsonResponse);
        final double totalAmount =
            (jsonResponse['total_amount'] ?? 0).toDouble();
        print(totalAmount);
        final List<dynamic> data = jsonResponse['categories'] ?? [];
        final List<CategorySummary> categories =
            data.map((category) => CategorySummary.fromJson(category)).toList();

        return {
          'totalAmount': totalAmount,
          'categories': categories,
        };
      } else {
        throw Exception('Failed to fetch summary: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error fetching summary: $e');
    }
  }

  Future<http.Response> updateUserProfile(
    String name,
    String email,
    File? imageFile,
  ) async {
    final url = Uri.parse('$baseUrl/update-profile');

    final token = await secureStorage.read(key: "token_key");
    if (token == null) {
      throw Exception('Token not found. Please log in again.');
    }

    var request = http.MultipartRequest('POST', url);

    request.fields['name'] = name;
    request.fields['email'] = email;

    if (imageFile != null) {
      request.files
          .add(await http.MultipartFile.fromPath('image', imageFile.path));
    }

    request.headers['Authorization'] = 'Bearer $token';

    try {
      http.StreamedResponse streamedResponse = await request.send();

      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        print('Profile updated successfully: ${response.body}');
      } else {
        throw Exception('Failed to update profile: ${response.statusCode}');
      }

      return response;
    } catch (e) {
      print('Error updating profile: $e');
      rethrow;
    }
  }

  Future<bool> changePassword(
      String currentPass, String newPass, String confirmPass) async {
    final token = await secureStorage.read(key: "token_key");
    if (token == null) {
      throw Exception('Token not found. Please log in again.');
    }
    try {
      final url = Uri.parse('$baseUrl/change-password');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'current_password': currentPass,
          'password': newPass,
          'password_confirmation': confirmPass
        }),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteExpense(String expenseId) async {
    final token = await secureStorage.read(key: "token_key");
    if (token == null) {
      throw Exception('Token not found. Please log in again.');
    }
    try {
      final url = Uri.parse('$baseUrl/expenses-delete');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'id': expenseId,
        }),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<Map<String, dynamic>> fetchTodayExpenses() async {
    final url = Uri.parse('$baseUrl/expenses/today');
    return await fetchExpensesFromApi(url);
  }

  Future<Map<String, dynamic>> fetchWeeklyExpenses() async {
    final url = Uri.parse('$baseUrl/expenses/weekly');
    return await fetchExpensesFromApi(url);
  }

  Future<Map<String, dynamic>> fetchMonthlyExpenses() async {
    final url = Uri.parse('$baseUrl/expenses/monthly');
    return await fetchExpensesFromApi(url);
  }

  Future<Map<String, dynamic>> fetchYearlyExpenses() async {
    final url = Uri.parse('$baseUrl/expenses/yearly');
    return await fetchExpensesFromApi(url);
  }

  Future<Map<String, dynamic>> fetchExpensesFromApi(Uri url) async {
    final token = await secureStorage.read(key: "token_key");
    if (token == null) {
      throw Exception('Token not found. Please log in again.');
    }

    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);

      final double totalAmount = (jsonResponse['total_amount'] ?? 0).toDouble();

      final List<dynamic> data = jsonResponse['data'] ?? [];
      final List<Expense> expenses =
          data.map((expense) => Expense.fromJson(expense)).toList();

      return {
        'totalAmount': totalAmount,
        'expenses': expenses,
      };
    } else {
      throw Exception('Failed to load expenses: ${response.body}');
    }
  }

  Future<bool> addExpense(
      String title, String amount, DateTime dateTime, int categoryId) async {
    try {
      final url = Uri.parse('$baseUrl/expenses');

      final token = await secureStorage.read(key: "token_key");
      if (token == null) {
        throw Exception('Token not found. Please log in again.');
      }

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'title': title,
          'amount': amount,
          'date_time': dateTime.toIso8601String(),
          'category_id': categoryId,
        }),
      );

      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateExpense(int id, String title, String amount,
      DateTime dateTime, int categoryId) async {
    final url = Uri.parse('$baseUrl/expenses-update');

    final token = await secureStorage.read(key: "token_key");
    if (token == null) {
      throw Exception('Token not found. Please log in again.');
    }

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'id': id,
        'title': title,
        'amount': amount,
        'date_time': dateTime.toIso8601String(),
        'category_id': categoryId,
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<Expense>> fetchFilterExpenses(
      {required DateTime fromDate, required DateTime toDate}) async {
    try {
      final fromDateIso = fromDate.toIso8601String();
      final toDateIso = toDate.toIso8601String();
      final url = Uri.parse(
          '$baseUrl/expenses/search?from_date=$fromDateIso&to_date=$toDateIso');
      final token = await secureStorage.read(key: "token_key");
      if (token == null) {
        throw Exception('Token not found. Please log in again.');
      }
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body)['data'];

        return data.map((json) => Expense.fromJson(json)).toList();
      } else {
        throw Exception("Failed to fetch filter expenses.");
      }
    } catch (e) {
      throw Exception(
        "Something went wrong: $e",
      );
    }
  }

  Future<Map<String, dynamic>> signIn(String email, String password) async {
    try {
      final url = Uri.parse("$baseUrl/login");

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'email': email, 'password': password}),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (responseData.containsKey('data') &&
            responseData['data'].containsKey('token')) {
          final token = responseData['data']['token'];

          await secureStorage.write(key: "token_key", value: token);

          return responseData;
        } else {
          return {'success': false, 'message': "Token missing in response."};
        }
      } else {
        return {
          'success': false,
          'message': responseData['message'] ?? "Unknown error occurred."
        };
      }
    } catch (e) {
      return {'success': false, 'message': "Request failed: ${e.toString()}"};
    }
  }

  Future<bool> updateCategory(
    int categoryId,
    String newName,
  ) async {
    final url = Uri.parse('$baseUrl/update-category');

    final token = await secureStorage.read(key: "token_key");
    if (token == null) {
      throw Exception('Token not found. Please log in again.');
    }

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'id': categoryId, 'name': newName}),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<Category>> fetchCategory() async {
    final url = Uri.parse('$baseUrl/categories');

    final token = await secureStorage.read(key: "token_key");
    if (token == null) {
      throw Exception('Token not found. Please log in again.');
    }
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body)['data'];
        return data.map((json) => Category.fromJson(json)).toList();
      } else {
        final error = jsonDecode(response.body);
        throw Exception(error['message']);
      }
    } catch (e) {
      throw Exception('Failed To Fetch Categories: $e');
    }
  }

  Future<bool> deleteCategory(int id) async {
    final url = Uri.parse('$baseUrl/delete-category');

    final token = await secureStorage.read(key: "token_key");
    if (token == null) {
      throw Exception("Token not found. Please log in again.");
    }

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'id': id,
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future addCategory(String name) async {
    final url = Uri.parse('$baseUrl/add-category');

    final token = await secureStorage.read(key: "token_key");
    if (token == null) {
      throw Exception('Token not found. Please log in again.');
    }
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'name': name}),
      );

      if (response.statusCode == 201) {
        final responseData = jsonDecode(response.body);

        return responseData;
      } else {
        final error = jsonDecode(response.body);
        throw Exception(error['message']);
      }
    } catch (e) {
      throw Exception('Failed To Update Categories: $e');
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await secureStorage.read(key: "token_key");
    if (token == null) {
      return false;
    }
    return true;
  }

  Future<Map<String, dynamic>> signUp(
      String name, String email, String password, String confirmPass) async {
    try {
      final url = Uri.parse("$baseUrl/register");

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
          'password_confirmation': confirmPass,
        }),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (responseData.containsKey('data') &&
            responseData['data'].containsKey('token')) {
          final token = responseData['data']['token'];

          await secureStorage.write(key: "token_key", value: token);
          print("Token stored: $token");

          final storedToken = await secureStorage.read(key: "token_key");
          if (storedToken != null) {
            Get.off(() => SignInScreen());
          }

          return {'success': true, 'message': "Signup successful"};
        } else {
          return {
            'success': false,
            'message': "Unexpected response: Token missing."
          };
        }
      } else {
        return {
          'success': false,
          'message': responseData['message'] ?? "Unknown error occurred."
        };
      }
    } catch (e) {
      return {'success': false, 'message': "Request failed: ${e.toString()}"};
    }
  }

  Future<void> logout() async {
    final storage = GetStorage();
    storage.erase();
    await secureStorage.deleteAll();

    Get.offAll(() => SignInScreen());
  }
}
