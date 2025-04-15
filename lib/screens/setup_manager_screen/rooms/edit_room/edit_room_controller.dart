import 'package:get/get.dart';

class EditRoomController extends GetxController {
  final RxList<dynamic> rooms = <dynamic>[].obs;
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;

  Future<void> editRoom({
    required int id,
    required String roomNumber,
    required String roomName,
    required String roomType,
    required String description,
  }) async {
    isLoading.value = true;
    error.value = '';

    try {
      final response = await GetConnect()
          .post('http://localhost/autosched/backend_php/api/update_row.php', {
            'table_name': 'rooms',
            'id_column': 'room_id',
            'id_value': id,
            'room_number': roomNumber,
            'room_name': roomName,
            'room_type': roomType,
            'description': description,
          });

      if (response.status.hasError) {
        throw Exception('Failed to update room');
      }

      final body = response.body;
      if (body['status'] == 'success') {
        // Subject updated successfully
        Get.snackbar('Success', 'Room updated successfully');
      } else {
        throw Exception(body['message'] ?? 'Unknown error occurred');
      }
    } catch (e) {
      error.value = e.toString();
      Get.snackbar('Error', 'Failed to update room: ${error.value}');
    } finally {
      isLoading.value = false;
    }
  }
}
