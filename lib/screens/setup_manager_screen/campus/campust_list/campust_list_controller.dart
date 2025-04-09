import 'package:get/get.dart';

class CampustListController extends GetxController {
  final RxList<dynamic> campuses = <dynamic>[].obs;
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCampuses();
  }

  Future<void> fetchCampuses() async {
    isLoading.value = true;
    error.value = '';

    try {
      final response = await GetConnect().get(
        'http://localhost/autosched/backend_php/api/get_campus.php',
        headers: {'Content-Type': 'application/json'},
      );

      if (response.status.hasError) {
        throw Exception('Failed to fetch campuses');
      }

      final body = response.body;
      if (body['status'] == 'success') {
        campuses.assignAll(body['data']);
      } else {
        throw Exception(body['message'] ?? 'Unknown error occurred');
      }
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteCampuses({required var campusId}) async {
    isLoading.value = true;
    error.value = '';
    try {
      final response = await GetConnect().post(
        'http://localhost/autosched/backend_php/api/delete_campus.php',
        {'campus_id': campusId},
      );

      if (response.status.hasError) {
        throw Exception('Failed to delete campuse');
      }

      final body = response.body;
      if (body['status'] == 'success') {
      } else {
        throw Exception(body['message'] ?? 'Unknown error occurred');
      }
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
