import 'package:autosched/screens/auth_screens/login/login.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfileController extends GetxController {
  final _errorMessage = ''.obs;
  final _isSuccess = false.obs;
  final _currentUser = Rx<Map<String, dynamic>>({});
  final _currentProfileUser = Rx<Map<String, dynamic>>({});

  String get errorMessage => _errorMessage.value;
  bool get isSuccess => _isSuccess.value;
  Map<String, dynamic> get currentUser => _currentUser.value;
  Map<String, dynamic> get currentProfileUser => _currentProfileUser.value;

  final _connect = GetConnect();
  final _storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    getCurrentUser();
  }

  Future<void> getCurrentUser() async {
    try {
      final userId = _storage.read('user_id');
      if (userId == null) {
        _errorMessage.value = 'No user logged in';
        return;
      }

      final response = await _connect.post(
        'http://localhost/autosched/backend_php/api/get_row.php?table_name=users',
        {'user_id': userId},
      );
      // log(response.body);

      if (response.status.hasError) {
        _errorMessage.value = 'Server error occurred';
        return;
      }

      final data = response.body;
      if (data['status'] == 'success') {
        _currentUser.value = data['data'][0];
        _isSuccess.value = true;
        // log('User logged in: ${response.body}');
      } else {
        _errorMessage.value = data['message'] ?? 'Failed to get current user';
      }

      // Print debug information
      // log('Debug info: ${data['debug']}');
    } catch (e) {
      _errorMessage.value = 'An error occurred: $e';
    }
  }

  void logout() {
    _currentUser.value = {};
    _isSuccess.value = false;
    _storage.remove('user_id');
    Get.offAll(LoginScreen());
  }
}
