import 'package:get/get.dart';

class EditCampusController extends GetxController {
  final _isLoading = false.obs;
  final _errorMessage = ''.obs;
  final _isSuccess = false.obs;

  bool get isLoading => _isLoading.value;
  String get errorMessage => _errorMessage.value;
  bool get isSuccess => _isSuccess.value;

  Future<void> editCampus({
    required int campusId,
    required String campusName,
    required String campusType,
    required String address,
  }) async {
    _isLoading.value = true;
    _errorMessage.value = '';
    _isSuccess.value = false;

    try {
      final response = await GetConnect()
          .post('http://localhost/autosched/backend_php/api/update_row.php', {
            'table_name': 'campus_list',
            'id_column': 'id',
            'id_value': campusId,
            'campus_name': campusName,
            'campus_type': campusType,
            'address': address,
          });

      if (response.status.hasError) {
        throw Exception('Failed to update campus');
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
