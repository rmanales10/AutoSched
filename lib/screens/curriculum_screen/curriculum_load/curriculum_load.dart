import 'package:autosched/screens/curriculum_screen/curriculum_load/curriculum_load_controller.dart';
import 'package:autosched/widgets/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CurriculumLoadScreen extends StatefulWidget {
  const CurriculumLoadScreen({super.key});

  @override
  _CurriculumLoadScreenState createState() => _CurriculumLoadScreenState();
}

class _CurriculumLoadScreenState extends State<CurriculumLoadScreen> {
  final _controller = Get.put(CurriculumLoadController());
  List<bool> isExpandedList = List.generate(8, (index) => false);
  @override
  void initState() {
    super.initState();
    _controller.fetchSubjects();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: Row(
        children: [
          Sidebar(
            selectedItem: "Curriculum",
            onItemSelected: (title, route) {
              setState(() {});
              Navigator.pushNamed(context, route);
            },
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      "BSIT-NEW-CURR-21",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Obx(() {
                    // if (_controller.isLoading.value) {
                    //   return Center(child: CircularProgressIndicator());
                    // } else
                    if (_controller.errorMessage.isNotEmpty) {
                      return Center(
                        child: Text(_controller.errorMessage.value),
                      );
                    } else {
                      return _buildSemesterList();
                    }
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String getSemesterString(int index) {
    List<String> years = ['1ST', '2ND', '3RD', '4TH'];
    String year = years[index ~/ 2];
    String semester = (index % 2 == 0) ? '1ST SEMESTER' : '2ND SEMESTER';
    return '$year YEAR - $semester';
  }

  Widget _buildSemesterList() {
    List<String> semesters = [
      "1ST YEAR - 1ST SEMESTER",
      "1ST YEAR - 2ND SEMESTER",
      "2ND YEAR - 1ST SEMESTER",
      "2ND YEAR - 2ND SEMESTER",
      "3RD YEAR - 1ST SEMESTER",
      "3RD YEAR - 2ND SEMESTER",
      "4TH YEAR - 1ST SEMESTER",
      "4TH YEAR - 2ND SEMESTER",
    ];

    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: List.generate(semesters.length, (index) {
            return Column(
              children: [
                // Semester Header
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isExpandedList[index] = !isExpandedList[index];
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10),
                    height: 50,
                    decoration: BoxDecoration(color: const Color(0xFF0D0B45)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 40),
                          child: SizedBox(
                            width: 300,
                            child: Text(
                              semesters[index],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/addsubcur');
                          },
                          icon: Stack(
                            alignment: Alignment.center,
                            children: [
                              Icon(
                                Icons.add_circle,
                                color: Colors.green,
                                size: 35,
                              ),
                              Icon(Icons.add, color: Colors.white, size: 25),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Subject List (shown when expanded)
                if (isExpandedList[index]) ...[
                  _buildSubjectHeader(),
                  ..._controller.subjects
                      .where((subject) {
                        String semesterString = getSemesterString(index);
                        List<String> parts = semesterString.split(' - ');
                        String yearLevel = parts[0];
                        String semester = parts[1];

                        print('Semester String: $semesterString');
                        print('Year Level: $yearLevel');
                        print('Semester: $semester');
                        print('Subject Year Level: ${subject['year_level']}');
                        print('Subject Semester: ${subject['semester']}');

                        bool matches =
                            subject['year_level'].toString().toUpperCase() ==
                                yearLevel &&
                            subject['semester'].toString().toUpperCase() ==
                                semester;

                        print('Matches: $matches');

                        return matches;
                      })
                      .map((subject) => _buildSubjectRow(subject)),
                ],
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _buildSubjectHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              "ID",
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              "SUBJECT CODE",
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              "DESCRIPTIVE TITLE",
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              "LEC",
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              "LAB",
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              "CREDIT",
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubjectRow(Map<String, dynamic> subject) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              subject["id"]?.toString() ?? "",
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              subject["subject_code"] ?? "",
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              subject["descriptive_title"] ?? "",
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              subject["lec"]?.toString() ?? "",
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              subject["lab"]?.toString() ?? "",
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              subject["credit"]?.toString() ?? "",
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
