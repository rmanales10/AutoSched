import 'package:get/get.dart';

class EditSubjectController extends GetxController {
  final RxList<dynamic> subjects = <dynamic>[].obs;
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;

  Future<void> fetchSubject(var id) async {
    isLoading.value = true;
    error.value = '';

    try {
      final response = await GetConnect().post(
        'http://localhost/autosched/backend_php/api/get_row.php?table_name=subjects',
        {'column_name': 'id', 'value': id},
      );

      if (response.status.hasError) {
        throw Exception('Failed to fetch campuses');
      }

      final body = response.body;
      if (body['status'] == 'success') {
        subjects.assignAll(body['data']);
      } else {
        throw Exception(body['message'] ?? 'Unknown error occurred');
      }
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> editSubject({
    required String id,
    required String subjectCode,
    required String descriptiveTitle,
    required String labHours,
    required String labUnit,
    required String lectHours,
    required String lecUnit,
    required String credit,
    required String? subjectArea,
    required String? gradeLevel,
    required String? major,
    required String? mode,
    required String? program,
  }) async {
    isLoading.value = true;
    error.value = '';

    try {
      final response = await GetConnect().post(
        'http://localhost/autosched/backend_php/api/update_row.php?table_name=subjects',
        {
          'table_name': 'subjects',
          'id_column': 'id',
          'id_value': id,
          'subject_code': subjectCode,
          'descriptive_title': descriptiveTitle,
          'lab_hrs': labHours,
          'lab': labUnit,
          'lec_hrs': lectHours,
          'lec': lecUnit,
          'credit': credit,
          'subject_area': subjectArea,
          'year_level': gradeLevel,
          'major': major,
          'mode': mode,
          'program': program,
        },
      );

      if (response.status.hasError) {
        throw Exception('Failed to update subject');
      }

      final body = response.body;
      if (body['status'] == 'success') {
        // Subject updated successfully
        Get.snackbar('Success', 'Subject updated successfully');
      } else {
        throw Exception(body['message'] ?? 'Unknown error occurred');
      }
    } catch (e) {
      error.value = e.toString();
      Get.snackbar('Error', 'Failed to update subject: ${error.value}');
    } finally {
      isLoading.value = false;
    }
  }
}
