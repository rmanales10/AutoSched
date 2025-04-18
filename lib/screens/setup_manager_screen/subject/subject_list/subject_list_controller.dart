import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SubjectListController extends GetxController {
  final _connect = GetConnect();
  final _storage = GetStorage();

  final RxList<Map<String, dynamic>> subjects = <Map<String, dynamic>>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchSubjects();
  }

  Future<void> fetchSubjects() async {
    isLoading(true);
    errorMessage('');

    try {
      final userId = await _storage.read('user_id');
      final response = await _connect.post(
        'http://localhost/autosched/backend_php/api/get_row.php?table_name=subjects',
        {'user_id': userId},
      );

      if (response.status.hasError) {
        errorMessage('Failed to fetch subjects. Please try again.');
      } else {
        final responseBody = response.body;
        if (responseBody['status'] == 'success') {
          subjects.assignAll(
            List<Map<String, dynamic>>.from(responseBody['data']),
          );
        } else {
          errorMessage(responseBody['message'] ?? 'Unknown error occurred');
        }
      }
    } catch (e) {
      errorMessage('An error occurred: $e');
    } finally {
      isLoading(false);
    }
  }

  void refreshSubjects() {
    fetchSubjects();
  }

  Future<void> deleteSubject({required var id}) async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final response = await GetConnect().post(
        'http://localhost/autosched/backend_php/api/delete_row.php',
        {'table': 'subjects', 'value': id},
      );

      if (response.status.hasError) {
        throw Exception('Failed to delete subject');
      }

      final body = response.body;
      if (body['status'] == 'success') {
      } else {
        throw Exception(body['message'] ?? 'Unknown error occurred');
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
