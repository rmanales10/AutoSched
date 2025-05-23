import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class FacultyLoadController extends GetxController {
  final _connect = GetConnect();
  final _storage = GetStorage();

  final RxList<List<String>> loadData = <List<String>>[].obs;
  final RxList<List<String>> loadId = <List<String>>[].obs;
  final RxList<String> facultyList = <String>[].obs;
  final RxList<String> sectionList = <String>[].obs;
  final RxList<Map<String, dynamic>> facultyLoadData =
      <Map<String, dynamic>>[].obs;

  Future<void> fetchLoad() async {
    try {
      final userId = await GetStorage().read('user_id');
      final response = await _connect.post(
        'http://localhost/autosched/backend_php/api/get_row.php?table_name=subjects',
        {'user_id': userId},
      );

      if (response.status.hasError) {
        throw Exception('Failed to fetch load data');
      }

      final data = response.body['data'];
      loadData.clear();
      loadId.clear();

      // Add header row
      loadData.add([
        "SUBJECT CODE",
        "DESCRIPTIVE TITLE",
        "LEC",
        "LAB",
        "CREDIT",
        "FACULTY",
        "SECTION",
      ]);

      // Process and add data rows
      for (var entry in data) {
        loadData.add([
          entry['subject_code']?.toString() ?? '',
          entry['descriptive_title']?.toString() ?? '',
          entry['lec']?.toString() ?? '',
          entry['lab']?.toString() ?? '',
          entry['credit']?.toString() ?? '',
          entry['faculty']?.toString() ?? '',
          entry['section']?.toString() ?? '',
        ]);
        loadId.add([entry['id']?.toString() ?? '']);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch load data: $e');
    }
  }

  Future<void> fetchFaculty() async {
    try {
      final userId = await _storage.read('user_id');

      if (userId == null) {
        throw Exception('User ID not found. Please login again.');
      }

      final response = await _connect.post(
        'http://localhost/autosched/backend_php/api/get_row.php?table_name=faculty',
        {'user_id': userId},
      );

      if (response.status.hasError) {
        throw Exception('Failed to fetch faculty data');
      }

      if (response.body['status'] == 'success') {
        facultyList.clear();
        sectionList.clear();
        Set<String> uniqueSections = <String>{};

        for (var faculty in response.body['data']) {
          String fullName = '${faculty['first_name']} ${faculty['last_name']}';
          if (fullName.trim().isNotEmpty) {
            facultyList.add(fullName);
          }

          if (faculty['department'] != null &&
              faculty['department'].toString().trim().isNotEmpty) {
            uniqueSections.add(faculty['department'].toString());
          }
        }

        sectionList.addAll(uniqueSections);

        // Ensure there's always at least one item in the lists
        if (facultyList.isEmpty) facultyList.add('No faculty available');
        if (sectionList.isEmpty) sectionList.add('No sections available');
      } else {
        throw Exception(
          'Failed to fetch faculty data: ${response.body['message']}',
        );
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    }
  }

  Future<void> updateFacultyLoad(
    String loadId,
    String faculty,
    String section,
  ) async {
    try {
      final userId = await _storage.read('user_id');
      final response = await _connect.post(
        'http://localhost/autosched/backend_php/api/add_row.php',
        {
          'table_name': 'faculty_load',
          'columns': {
            'user_id': userId,
            'subject_id': loadId,
            'faculty': faculty,
            'section': section,
          },
        },
      );

      if (response.status.hasError) {
        throw Exception('Failed to update faculty load');
      }

      if (response.body['status'] != 'success') {
        throw Exception(
          'Failed to update faculty load: ${response.body['message']}',
        );
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to update faculty load: $e');
    }
  }

  Future<void> fetchFacultyLoad(String id) async {
    try {
      final userId = await _storage.read('user_id');

      if (userId == null) {
        throw Exception('User ID not found. Please login again.');
      }

      final response = await _connect.post(
        'http://localhost/autosched/backend_php/api/get_row.php?table_name=faculty_load',
        {'user_id': userId, 'column_name': 'subject_id', 'value': id},
      );

      if (response.status.hasError) {
        throw Exception('Failed to fetch faculty load data');
      }

      if (response.body['status'] == 'success') {
        final data = response.body['data'];

        facultyLoadData.clear();

        for (var entry in data) {
          facultyLoadData.add({
            'id': entry['id']?.toString() ?? '',
            'subject_id': entry['subject_id']?.toString() ?? '',
            'faculty': entry['faculty']?.toString() ?? '',
            'section': entry['section']?.toString() ?? '',
          });
        }

        // You can now use facultyLoadData in your UI or for further processing
        log('Faculty Load Data: $facultyLoadData');
      } else {
        throw Exception(
          'Failed to fetch faculty load data: ${response.body['message']}',
        );
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch faculty load data: $e');
    }
  }
}
