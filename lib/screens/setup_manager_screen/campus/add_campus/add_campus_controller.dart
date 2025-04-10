import 'package:get/get.dart';

class AddCampusController extends GetxController {
  final _isLoading = false.obs;
  final _errorMessage = ''.obs;
  final _isSuccess = false.obs;

  bool get isLoading => _isLoading.value;
  String get errorMessage => _errorMessage.value;
  bool get isSuccess => _isSuccess.value;

  Future<void> addCampus({
    required String campusName,
    required String campusType,
    required String address,
  }) async {
    _isLoading.value = true;
    _errorMessage.value = '';
    _isSuccess.value = false;

    try {
      final response = await GetConnect().post(
        'http://localhost/autosched/backend_php/api/add_row.php',
        {
          "table_name": "campus_list",
          "columns": {
            "campus_name": campusName,
            "campus_type": campusType,
            "address": address,
          },
        },
      );

      if (response.status.hasError) {
        _errorMessage.value = 'Failed to add campus. Please try again.';
      } else {
        final body = response.body;
        if (body['status'] == 'success') {
          _isSuccess.value = true;
        } else {
          _errorMessage.value = body['message'] ?? 'An unknown error occurred';
        }
      }
    } catch (e) {
      _errorMessage.value = 'An error occurred: $e';
    } finally {
      _isLoading.value = false;
    }
  }
}
