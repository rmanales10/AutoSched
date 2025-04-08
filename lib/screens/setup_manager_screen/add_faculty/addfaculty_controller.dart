import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AddFacultyController extends GetxController {
  final _errorMessage = ''.obs;
  final _isSuccess = false.obs;
  final _isLoading = false.obs;

  String get errorMessage => _errorMessage.value;
  bool get isSuccess => _isSuccess.value;
  bool get isLoading => _isLoading.value;

  final _connect = GetConnect();
  final _storage = GetStorage();

  Future<void> addFaculty({
    required String firstName,
    required String lastName,
    required String email,
    required String mobileNumber,
    required String position,
    required String status,
    required String department,
    required String designation,
    required String constraints,
  }) async {
    _isLoading.value = true;
    _errorMessage.value = '';
    _isSuccess.value = false;

    try {
      final userId = _storage.read('user_id') ?? 'default_user_id';

      final data = {
        'user_id': userId,
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'mobile_number': mobileNumber,
        'position': position,
        'status': status,
        'department': department,
        'designation': designation,
        'constraints': constraints,
      };

      final response = await _connect.post(
        'http://localhost/autosched/backend_php/api/add_faculty.php',
        data,
      );
      if (response.body['status'] == 'success') {
        _isSuccess.value = true;
        Get.snackbar('Success', response.body['message']);
      } else {
        Get.snackbar('Error', response.body['message']);
      }

      // Rest of the code remains the same
    } catch (e) {
      _errorMessage.value = 'An error occurred: ${e.toString()}';
      Get.snackbar('Error', _errorMessage.value);
    } finally {
      _isLoading.value = false;
    }
  }
}
