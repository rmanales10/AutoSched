import 'package:get/get.dart';

class RegistrationController extends GetxController {
  final _isLoading = false.obs;
  final _errorMessage = ''.obs;
  final _isSuccess = false.obs;

  bool get isLoading => _isLoading.value;
  String get errorMessage => _errorMessage.value;
  bool get isSuccess => _isSuccess.value;
  final _apiClient = GetConnect();

  Future<void> registerUser(
    String email,
    String password,
    String accessRole,
  ) async {
    _isLoading.value = true;
    _errorMessage.value = '';
    _isSuccess.value = false;

    try {
      final response = await _apiClient.post(
        'http://localhost/autosched/backend_php/api/register.php',
        {'email': email, 'password': password, 'access_role': accessRole},
      );

      if (response.statusCode == 200) {
        final responseBody = response.body;
        if (responseBody['status'] == 'success') {
          _errorMessage.value =
              responseBody['message'] ??
              'Registration Successful! Please log in now.';
          _isSuccess.value = true;
        } else {
          _errorMessage.value =
              responseBody['message'] ?? 'Registration failed';
        }
      } else {
        _errorMessage.value = 'Server error occurred';
      }
    } catch (e) {
      _errorMessage.value = 'An error occurred: $e';
    } finally {
      _isLoading.value = false;
    }
  }
}
