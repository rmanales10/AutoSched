import 'package:get/get.dart';

class DesignationListController extends GetxController {
  final RxList<dynamic> designations = <dynamic>[].obs;
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchDesignations();
  }

  Future<void> fetchDesignations() async {
    isLoading.value = true;
    error.value = '';

    try {
      final response = await GetConnect().get(
        'http://localhost/autosched/backend_php/api/get_row.php?table_name=designation_list',
        headers: {'Content-Type': 'application/json'},
      );

      if (response.status.hasError) {
        throw Exception('Failed to fetch designations');
      }

      final body = response.body;
      if (body['status'] == 'success') {
        designations.assignAll(body['data']);
      } else {
        throw Exception(body['message'] ?? 'Unknown error occurred');
      }
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteDesignation({required var id}) async {
    isLoading.value = true;
    error.value = '';
    try {
      final response = await GetConnect().post(
        'http://localhost/autosched/backend_php/api/delete_row.php',
        {'table': 'designation_list', 'value': id},
      );

      if (response.status.hasError) {
        throw Exception('Failed to delete designation');
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
