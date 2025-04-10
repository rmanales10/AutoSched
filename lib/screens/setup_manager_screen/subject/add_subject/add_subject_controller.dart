import 'package:get/get.dart';

class AddSubjectController extends GetxController {
  final _connect = GetConnect();

  Future<void> addSubject({
    required String subjectCode,
    required String descriptiveTitle,
    required int lec,
    required String lecHrs,
    required int lab,
    required String labHrs,
    required int credit,
    required String subjectArea,
    required String yearLevel,
    required String program,
    required String major,
    required String mode,
  }) async {
    try {
      final response = await _connect.post(
        'http://localhost/autosched/backend_php/api/add_row.php',
        {
          'table_name': 'subjects',
          'columns': {
            'subject_code': subjectCode,
            'descriptive_title': descriptiveTitle,
            'lec': lec,
            'lec_hrs': lecHrs,
            'lab': lab,
            'lab_hrs': labHrs,
            'credit': credit,
            'subject_area': subjectArea,
            'year_level': yearLevel,
            'program': program,
            'major': major,
            'mode': mode,
          },
        },
      );

      if (response.status.hasError) {
        throw Exception('Failed to add subject');
      }

      final responseBody = response.body;
      if (responseBody['status'] != 'success') {
        throw Exception(responseBody['message'] ?? 'Unknown error occurred');
      }
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }
}
