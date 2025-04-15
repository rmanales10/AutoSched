import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CreateCurriculumController extends GetxController {
  final _connect = GetConnect();
  final _storage = GetStorage();
  RxBool isSuccess = false.obs;
  RxString errorMessage = ''.obs;

  Future<void> createCurriculum({
    required String campus,
    required String program,
    required String major,
    required String name,
    required String description,
    required String notes,
  }) async {
    try {
      final userId = _storage.read('user_id');
      final response = await _connect.post(
        'http://localhost/autosched/backend_php/api/add_row.php',
        {
          'table_name': 'curriculum',
          'columns': {
            'user_id': userId,
            'campus': campus,
            'program': program,
            'major': major,
            'name': name,
            'description': description,
            'notes': notes,
          },
        },
      );

      if (response.status.hasError) {
        errorMessage.value = 'Failed to add curriculum';
        throw Exception('Failed to add curriculum');
      }

      final responseBody = response.body;
      if (responseBody['status'] != 'success') {
        isSuccess.value = false;
        errorMessage.value =
            responseBody['message'] ?? 'Unknown error occurred';
        throw Exception(errorMessage.value);
      }

      isSuccess.value = true;
      errorMessage.value = '';
    } catch (e) {
      isSuccess.value = false;
      errorMessage.value = 'An error occurred: $e';
      throw Exception(errorMessage.value);
    }
  }
}
