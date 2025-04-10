import 'package:get/get.dart';

class AddDesignationController extends GetxController {
  final _isLoading = false.obs;
  final _errorMessage = ''.obs;
  final _isSuccess = false.obs;

  bool get isLoading => _isLoading.value;
  String get errorMessage => _errorMessage.value;
  bool get isSuccess => _isSuccess.value;

  final _connect = GetConnect();

  Future<void> addDesignation({
    required String designation,
    required String officeOrDepartment,
    required String timeRelease,
  }) async {
    _isLoading.value = true;
    _errorMessage.value = '';
    _isSuccess.value = false;

    try {
      final response = await _connect.post(
        'http://localhost/autosched/backend_php/api/add_row.php',
        {
          'table_name': 'designation_list',
          'columns': {
            'designation': designation,
            'office_or_department': officeOrDepartment,
            'time_release': timeRelease,
          },
        },
      );

      if (response.status.hasError) {
        _errorMessage.value = 'Failed to add designation. Please try again.';
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
