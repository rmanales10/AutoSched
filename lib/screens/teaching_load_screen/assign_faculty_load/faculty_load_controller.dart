import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class FacultyLoadController extends GetxController {
  final _storage = GetStorage();
  final _connect = GetConnect();
  final RxList<String> facultyList = RxList<String>();
  final RxList<String> loadData = RxList<String>();

  // final List<List<String>> facultyLoadData = [
  //   [
  //     "SUBJECT CODE",
  //     "DESCRIPTIVE TITLE",
  //     "LEC",
  //     "LAB",
  //     "CREDIT",
  //     "FACULTY",
  //     "SECTION",
  //   ],
  //   ["IT111", "Introduction to Computing", "2", "1", "3", "", ""],
  //   ["IT112", "Computer Programming 1", "2", "1", "3", "", ""],
  //   ["PurCom", "Purposive Communication", "2", "1", "3", "", ""],
  //   ["IT113", "Computer Programming 2", "2", "1", "3", "", ""],
  //   ["IT114", "Data Structures & Algorithms", "2", "1", "3", "", ""],
  //   ["IT115", "Operating Systems", "2", "1", "3", "", ""],
  //   ["IT116", "Computer Networks", "2", "1", "3", "", ""],
  //   ["IT113", "Computer Programming 2", "2", "1", "3", "", ""],
  //   ["IT114", "Data Structures & Algorithms", "2", "1", "3", "", ""],
  //   ["IT115", "Operating Systems", "2", "1", "3", "", ""],
  //   ["IT116", "Computer Networks", "2", "1", "3", "", ""],
  // ];

  Future<void> fetchFaculty() async {
    try {
      final userId = await _storage.read('user_id');

      if (userId == null) {
        Get.snackbar('Error', 'User ID not found. Please login again.');
        return;
      }

      final response = await _connect.post(
        'http://localhost/autosched/backend_php/api/get_faculty.php',
        {'user_id': userId},
      );
      if (response.body['status'] == 'success') {
        response.body['data'].forEach((faculty) {
          facultyList.add('${faculty['first_name']} ${faculty['last_name']}');
        });
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> fetchLoad() async {
    try {
      final response = await _connect.get(
        'http://localhost/autosched/backend_php/api/get_faculty_load.php',
      );
      // print(response.body);
      final data = response.body['data'];
      for (var entry in data) {
        var value = entry.values.map((e) => e.toString()).toList();
        loadData.addAll(value);
        print(value);
      }

      print(loadData);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}
