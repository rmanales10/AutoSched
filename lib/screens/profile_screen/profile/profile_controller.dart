import 'package:autosched/screens/auth_screens/login/login.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfileController extends GetxController {
  final _errorMessage = ''.obs;
  final _isSuccess = false.obs;
  final _currentUser = Rx<Map<String, dynamic>>({});
  final _currentProfileUser = Rx<Map<String, dynamic>>({});
  bool _hasFetchedData = false;

  String get errorMessage => _errorMessage.value;
  bool get isSuccess => _isSuccess.value;
  Map<String, dynamic> get currentUser => _currentUser.value;
  Map<String, dynamic> get currentProfileUser => _currentProfileUser.value;

  final _connect = GetConnect();
  final _storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    if (!_hasFetchedData) {
      getCurrentUser();
    }
  }

  Future<void> getCurrentUser() async {
    if (_hasFetchedData && _currentUser.value.isNotEmpty) {
      return; // Return cached data if already fetched
    }

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

      if (response.status.hasError) {
        _errorMessage.value = 'Server error occurred';
        return;
      }

      final data = response.body;
      if (data['status'] == 'success') {
        _currentUser.value = data['data'][0];
        _isSuccess.value = true;
        _hasFetchedData = true; // Mark as fetched
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
    _hasFetchedData = false; // Reset fetch flag on logout
    _storage.remove('user_id');
    Get.offAll(LoginScreen());
  }
}
