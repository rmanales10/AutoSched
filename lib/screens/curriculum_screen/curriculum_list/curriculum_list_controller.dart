import 'package:get/get.dart';

class CurriculumListController extends GetxController {
  final _connect = GetConnect();

  final RxList<Map<String, dynamic>> curriculums = <Map<String, dynamic>>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCurriculums();
  }

  Future<void> fetchCurriculums() async {
    isLoading(true);
    errorMessage('');

    try {
      final response = await _connect.get(
        'http://localhost/autosched/backend_php/api/get_row.php?table_name=curriculum',
      );

      if (response.status.hasError) {
        errorMessage('Failed to fetch curriculums. Please try again.');
      } else {
        final responseBody = response.body;
        if (responseBody['status'] == 'success') {
          curriculums.assignAll(
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

  void refreshCurriculums() {
    fetchCurriculums();
  }
}
