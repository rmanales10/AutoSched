import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:io';
import 'dart:convert';

class EditProfileController extends GetxController {
  final _errorMessage = ''.obs;
  final _isSuccess = false.obs;
  final _currentUser = Rx<Map<String, dynamic>>({});
  final _isLoading = false.obs;

  String get errorMessage => _errorMessage.value;
  bool get isSuccess => _isSuccess.value;
  bool get isLoading => _isLoading.value;
  Map<String, dynamic> get currentUser => _currentUser.value;

  final _connect = GetConnect();
  final _storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    getCurrentUser();
  }

  Future<void> getCurrentUser() async {
    _isLoading.value = true;
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
      // log(response.body);r

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

      // log('Debug info: ${data['debug']}');
    } catch (e) {
      _errorMessage.value = 'An error occurred: $e';
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> updateOrCreateProfile({
    required String username,
    required String firstName,
    required String lastName,
    required String mobileNumber,
    required String password,
    String? profileImage,
  }) async {
    _isLoading.value = true;
    _errorMessage.value = '';
    try {
      final userId = _storage.read('user_id');
      final Map<String, dynamic> userData = {
        'username': username,
        'firstname': firstName,
        'lastname': lastName,
        'mobile_number': mobileNumber,
        'password': password,
      };

      if (userId != null) {
        userData['user_id'] = userId;
      }

      if (profileImage != null) {
        userData['profile_image'] = 'data:image/jpeg;base64,$profileImage';
      }

      final response = await _connect.post(
        'http://localhost/autosched/backend_php/api/user_profile.php',
        userData,
      );

      if (response.status.hasError) {
        _errorMessage.value = 'Server error occurred';
        return;
      }

      final data = response.body;
      if (data['status'] == 'success') {
        _currentUser.value = data['user'];
        _isSuccess.value = true;
        if (userId == null) {
          _storage.write('user_id', data['user']['user_id']);
          Get.snackbar('Success', 'New profile created successfully');
        } else {
          Get.snackbar('Success', 'Profile updated successfully');
        }
      } else {
        _errorMessage.value =
            data['message'] ?? 'Failed to update/create profile';
        Get.snackbar('Error', _errorMessage.value);
      }
    } catch (e) {
      _errorMessage.value = 'An error occurred: $e';
      Get.snackbar('Error', _errorMessage.value);
    } finally {
      _isLoading.value = false;
    }
  }

  void logout() {
    _currentUser.value = {};
    _isSuccess.value = false;
    _storage.remove('user_id');
  }
}
