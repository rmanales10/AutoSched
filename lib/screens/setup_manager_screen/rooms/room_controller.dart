import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class RoomController extends GetxService {
  final _connect = GetConnect();
  final _storage = GetStorage();

  final rooms = <Map<String, dynamic>>[].obs;
  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final isSuccess = false.obs;

  Future<void> fetchRooms() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final userId = _storage.read('user_id');
      final response = await _connect.get(
        'http://localhost/autosched/backend_php/api/get_rooms.php',
        query: {'user_id': userId},
      );

      if (response.status.hasError) {
        throw Exception('Failed to load rooms');
      }

      if (response.body['status'] == 'success') {
        rooms.assignAll(List<Map<String, dynamic>>.from(response.body['data']));
        isSuccess.value = true;
      } else {
        throw Exception(response.body['message'] ?? 'Failed to load rooms');
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
