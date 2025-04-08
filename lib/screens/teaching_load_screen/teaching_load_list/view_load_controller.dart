import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ViewLoadController extends GetxController {
  final _isLoading = false.obs;
  final _errorMessage = ''.obs;
  final _teachingLoads = <Map<String, dynamic>>[].obs;

  bool get isLoading => _isLoading.value;
  String get errorMessage => _errorMessage.value;
  List<Map<String, dynamic>> get teachingLoads => _teachingLoads;

  final _connect = GetConnect();
  final _storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    fetchTeachingLoads();
  }

  Future<void> fetchTeachingLoads() async {
    _isLoading.value = true;
    _errorMessage.value = '';

    try {
      final userId = _storage.read('user_id');
      if (userId == null) {
        _errorMessage.value = 'User ID not found';
        return;
      }

      final response = await _connect.get(
        'http://localhost/autosched/backend_php/api/get_teaching_load.php?user_id=$userId',
      );
      if (response.status.hasError) {
        _errorMessage.value = 'Server error occurred';
        return;
      }

      final responseData = response.body;
      if (responseData['status'] == 'success') {
        _teachingLoads.assignAll(
          List<Map<String, dynamic>>.from(responseData['data']),
        );
        // log(teachingLoads as String);
      } else {
        _errorMessage.value =
            responseData['message'] ?? 'Failed to fetch teaching loads';
      }
    } catch (e) {
      _errorMessage.value = 'An error occurred: $e';
    } finally {
      _isLoading.value = false;
    }
  }

  Map<String, dynamic>? getTeachingLoadById(int id) {
    return _teachingLoads.firstWhereOrNull(
      (load) => load['teaching_load_id'] == id,
    );
  }

  void refreshTeachingLoads() {
    fetchTeachingLoads();
  }
}
