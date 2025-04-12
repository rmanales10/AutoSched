import 'package:get/get.dart';

class EditDesignationController extends GetxController {
  final _isLoading = false.obs;
  final _errorMessage = ''.obs;
  final _isSuccess = false.obs;

  bool get isLoading => _isLoading.value;
  String get errorMessage => _errorMessage.value;
  bool get isSuccess => _isSuccess.value;

  Future<void> editDesignation({
    required int id,
    required String designation,
    required String officeDepartment,
    required String time,
  }) async {
    _isLoading.value = true;
    _errorMessage.value = '';
    _isSuccess.value = false;

    try {
      final response = await GetConnect()
          .post('http://localhost/autosched/backend_php/api/update_row.php', {
            'table_name': 'designation_list',
            'id_column': 'id',
            'id_value': id,
            'designation': designation,
            'office_or_department': officeDepartment,
            'time_release': time,
          });

      if (response.status.hasError) {
        throw Exception('Failed to update designation');
      }

      final body = response.body;
      if (body['status'] == 'success') {
        _isSuccess.value = true;
      } else {
        throw Exception(body['message'] ?? 'Unknown error occurred');
      }
    } catch (e) {
      _errorMessage.value = e.toString();
    } finally {
      _isLoading.value = false;
    }
  }
}
