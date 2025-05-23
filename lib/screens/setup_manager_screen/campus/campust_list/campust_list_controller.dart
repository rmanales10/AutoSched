import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

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
      final userId = await GetStorage().read('user_id');
      final response = await GetConnect().post(
        'http://localhost/autosched/backend_php/api/get_row.php?table_name=campus_list',
        {'user_id': userId},
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
        'http://localhost/autosched/backend_php/api/delete_row.php',
        {'table': 'campus_list', 'value': campusId},
      );

      if (response.status.hasError) {
        throw Exception('Failed to delete campus');
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
