import 'package:autosched/widgets/sidebar.dart';
import 'package:flutter/material.dart';

class CurriculumLoadScreen extends StatefulWidget {
  const CurriculumLoadScreen({super.key});

  @override
  _CurriculumLoadScreenState createState() => _CurriculumLoadScreenState();
}

class _CurriculumLoadScreenState extends State<CurriculumLoadScreen> {
  List<bool> isExpandedList = List.generate(8, (index) => false);
  final List<List<Map<String, String>>> semesterSubjects = [
    // 1st Year - 1st Semester
    [
      {
        "id": "002",
        "code": "IT112",
        "title": "Computer Programming 1",
        "lec": "2.0",
        "lab": "1.0",
        "credit": "3.0",
      },
      {
        "id": "002",
        "code": "IT112",
        "title": "Computer Programming 1",
        "lec": "2.0",
        "lab": "1.0",
        "credit": "3.0",
      },
      {
        "id": "002",
        "code": "IT112",
        "title": "Computer Programming 1",
        "lec": "2.0",
        "lab": "1.0",
        "credit": "3.0",
      },
      {
        "id": "002",
        "code": "IT112",
        "title": "Computer Programming 1",
        "lec": "2.0",
        "lab": "1.0",
        "credit": "3.0",
      },
    ],
    // Other semesters (empty for now)
    [], [], [], [], [], [], [],
  ];

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
                  _buildSemesterList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
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
                  ...semesterSubjects[index].map(
                    (subject) => _buildSubjectRow(subject),
                  ),
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

  Widget _buildSubjectRow(Map<String, String> subject) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(subject["id"] ?? "", textAlign: TextAlign.center),
          ),
          Expanded(
            flex: 2,
            child: Text(subject["code"] ?? "", textAlign: TextAlign.center),
          ),
          Expanded(
            flex: 4,
            child: Text(subject["title"] ?? "", textAlign: TextAlign.center),
          ),
          Expanded(
            flex: 1,
            child: Text(subject["lec"] ?? "", textAlign: TextAlign.center),
          ),
          Expanded(
            flex: 1,
            child: Text(subject["lab"] ?? "", textAlign: TextAlign.center),
          ),
          Expanded(
            flex: 1,
            child: Text(subject["credit"] ?? "", textAlign: TextAlign.center),
          ),
        ],
      ),
    );
  }
}
