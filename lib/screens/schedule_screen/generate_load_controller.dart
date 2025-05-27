import 'package:get/get.dart';

class GenerateLoadController extends GetxController
    with StateMixin<List<dynamic>> {
  final GetConnect _getConnect = GetConnect();

  // Observable list for subjects
  var subjects = <dynamic>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchSubjects();
  }

  Future<void> fetchSubjects() async {
    final String apiUrl =
        'http://localhost/autosched/backend_php/api/get_row.php?table_name=subjects';

    final response = await _getConnect.get(apiUrl);

    if (response.statusCode == 200) {
      final body = response.body;
      if (body['status'] == 'success' && body['data'] != null) {
        subjects.value = body['data'];
        change(subjects, status: RxStatus.success());
      } else {
        subjects.clear();
        change(subjects, status: RxStatus.empty());
      }
    } else {
      change(null, status: RxStatus.error('Failed to fetch subjects'));
    }
  }

  Future<void> saveSchedule(List<Map<String, dynamic>> scheduleRows) async {
    final String apiUrl =
        'http://localhost/autosched/backend_php/api/add_row.php';

    for (var row in scheduleRows) {
      final response = await _getConnect.post(apiUrl, {
        "table_name": "schedules",
        "columns": row,
      });

      if (response.statusCode != 200 || response.body['status'] != 'success') {
        // Handle error (show a message, etc.)
        print('Failed to save schedule row: ${response.body}');
      }
    }
  }
}
