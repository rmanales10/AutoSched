import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class FacultyController extends GetxController {
  final GetConnect connect = GetConnect();
  final GetStorage storage = GetStorage();

  // Reactive variable to store faculty data
  final RxList<Map<String, dynamic>> facultyData = <Map<String, dynamic>>[].obs;

  Future<void> fetchFacultyData() async {
    try {
      final userId = storage.read('user_id');

      if (userId == null) {
        Get.snackbar('Error', 'User ID not found. Please login again.');
        return;
      }

      // Send request to PHP backend
      final response = await connect.post(
        'http://localhost/autosched/backend_php/api/get_row.php?table_name=faculty',
        {'user_id': userId},
      );

      if (response.status.hasError) {
        Get.snackbar('Error', 'Failed to fetch faculty data');
        return;
      }

      final responseBody = response.body;

      if (responseBody['status'] == 'success') {
        facultyData.value = List<Map<String, dynamic>>.from(
          responseBody['data'],
        );
      } else {
        Get.snackbar(
          'Error',
          responseBody['message'] ?? 'Unknown error occurred',
        );
      }
    } catch (e) {
      Get.snackbar('Error', 'An unexpected error occurred: $e');
    }
  }
}
