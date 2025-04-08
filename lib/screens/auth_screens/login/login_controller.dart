import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  final _isLoading = false.obs;
  final _errorMessage = ''.obs;
  final _isSuccess = false.obs;
  final _currentUser = Rx<Map<String, dynamic>>({});

  bool get isLoading => _isLoading.value;
  String get errorMessage => _errorMessage.value;
  bool get isSuccess => _isSuccess.value;
  Map<String, dynamic> get currentUser => _currentUser.value;

  final _connect = GetConnect();
  final _storage = GetStorage();

  Future<void> login(String email, String password) async {
    _isLoading.value = true;
    _errorMessage.value = '';

    try {
      final response = await _connect.post(
        'http://localhost/autosched/backend_php/api/login.php',
        {'email': email, 'password': password},
        headers: {'Content-Type': 'application/json'},
      );

      if (response.status.hasError) {
        _errorMessage.value = 'Server error occurred';
        return;
      }

      final data = response.body;
      if (data['status'] == 'success') {
        _isSuccess.value = true;
        _errorMessage.value = data['message'] ?? 'Login Successfully!';
        _currentUser.value = data['user'];

        // Save the user ID to storage
        if (data['user'] != null && data['user']['id'] != null) {
          _storage.write('user_id', data['user']['id'].toString());
        }

        // print(response.body);
      } else {
        _errorMessage.value = data['message'] ?? 'Login failed';
      }
    } catch (e) {
      _errorMessage.value = 'An error occurred: $e';
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> getCurrentUser() async {
    try {
      final userId = _storage.read('user_id');
      if (userId == null) {
        _errorMessage.value = 'No user logged in';
        return;
      }

      final response = await _connect.get(
        'http://localhost/autosched/backend_php/api/get_current_user.php',
        query: {'user_id': userId},
      );

      if (response.status.hasError) {
        _errorMessage.value = 'Server error occurred';
        return;
      }

      final data = response.body;
      if (data['status'] == 'success') {
        _currentUser.value = data['user'];
      } else {
        _errorMessage.value = data['message'] ?? 'Failed to get current user';
      }
    } catch (e) {
      _errorMessage.value = 'An error occurred: $e';
    }
  }

  void logout() {
    _currentUser.value = {};
    _isSuccess.value = false;
    _storage.remove('user_id');
  }
}
