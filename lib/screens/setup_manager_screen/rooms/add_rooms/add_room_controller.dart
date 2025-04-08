import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AddRoomController extends GetxController {
  final _connect = GetConnect();
  final _storage = GetStorage();
  final _isLoading = false.obs;
  final _errorMessage = ''.obs;
  final _isSuccess = false.obs;

  bool get isLoading => _isLoading.value;
  String get errorMessage => _errorMessage.value;
  bool get isSuccess => _isSuccess.value;

  Future<void> addRoom({
    required String roomNumber,
    required String roomName,
    required String roomType,
    required String description,
  }) async {
    _isLoading.value = true;
    _errorMessage.value = '';
    _isSuccess.value = false;

    // Retrieve user_id from storage
    final userId = _storage.read('user_id');

    if (userId == null) {
      _isLoading.value = false;
      _errorMessage.value = 'User ID not found in storage.';
      Get.snackbar('Error', _errorMessage.value);
      return;
    }

    final response = await _connect
        .post('http://localhost/autosched/backend_php/api/add_rooms.php', {
          'user_id': userId,
          'room_number': roomNumber,
          'room_name': roomName,
          'room_type': roomType,
          'description': description,
        });

    _isLoading.value = false;

    if (response.statusCode == 200) {
      final responseBody = response.body;
      if (responseBody['status'] == 'success') {
        Get.snackbar('Success', 'Room added successfully. ID: $roomNumber');
        _isSuccess.value = true;
      } else {
        _errorMessage.value = responseBody['message'] ?? 'Failed to add room.';
        Get.snackbar('Error', _errorMessage.value);
      }
    } else {
      _errorMessage.value = response.statusText ?? 'An error occurred';
    }
  }
}
