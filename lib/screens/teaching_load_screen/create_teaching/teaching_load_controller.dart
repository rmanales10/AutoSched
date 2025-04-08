import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class TeachingLoadController extends GetxController {
  final _errorMessage = ''.obs;
  final _isSuccess = false.obs;
  final _isLoading = false.obs;

  String get errorMessage => _errorMessage.value;
  bool get isSuccess => _isSuccess.value;
  bool get isLoading => _isLoading.value;

  final _connect = GetConnect();
  final _storage = GetStorage();

  Future<void> createTeachingLoad({
    required String semester,
    required String program,
    required String major,
    required int year1,
    required int year2,
    required int year3,
    required int year4,
  }) async {
    _isLoading.value = true;
    try {
      final userId = _storage.read('user_id');
      final Map<String, dynamic> data = {
        'user_id': userId,
        'semester': semester,
        'program': program,
        'major': major,
        '1st_year': year1,
        '2nd_year': year2,
        '3rd_year': year3,
        '4th_year': year4,
      };

      final response = await _connect.post(
        'http://localhost/autosched/backend_php/api/create_teaching_load.php',
        data,
      );
      

      if (response.status.hasError) {
        _errorMessage.value = 'Server error occurred';
        Get.snackbar('Error', _errorMessage.value);
        return;
      }

      final responseData = response.body;
      if (responseData['status'] == 'success') {
        _isSuccess.value = true;
        Get.snackbar('Success', 'Teaching load created successfully');
      } else {
        _errorMessage.value =
            responseData['message'] ?? 'Failed to create teaching load';
        Get.snackbar('Error', _errorMessage.value);
      }
    } catch (e) {
      _errorMessage.value = 'An error occurred: $e';
      Get.snackbar('Error', _errorMessage.value);
    } finally {
      _isLoading.value = false;
    }
  }
}
