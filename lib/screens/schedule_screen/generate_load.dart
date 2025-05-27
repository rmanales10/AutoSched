import 'package:autosched/screens/schedule_screen/generate_load_controller.dart';
import 'package:autosched/widgets/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math';
import 'package:get_storage/get_storage.dart';

class GenerateLoadScreen extends StatefulWidget {
  const GenerateLoadScreen({super.key});

  @override
  State<GenerateLoadScreen> createState() => _GenerateLoadScreenState();
}

class _GenerateLoadScreenState extends State<GenerateLoadScreen> {
  String selectedSemester = 'First Semester';
  String selectedAcademicYear = '2023-2024';
  bool includePreferences = true;
  bool optimizeConflicts = true;
  final GenerateLoadController controller = Get.put(GenerateLoadController());
  final box = GetStorage();
  @override
  void initState() {
    super.initState();
    controller.fetchSubjects();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: Row(
        children: [
          Sidebar(
            selectedItem: 'Schedule',
            onItemSelected: (title, route) {
              Navigator.pushNamed(context, route);
            },
          ),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 150,
                  vertical: 50,
                ),
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 1, color: Colors.grey.shade400),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 30,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Generate Schedule',
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildSection('Schedule Parameters', [
                        _buildDropdown(
                          'Semester',
                          selectedSemester,
                          ['First Semester', 'Second Semester', 'Summer'],
                          (value) {
                            setState(() {
                              selectedSemester = value!;
                            });
                          },
                        ),
                        const SizedBox(height: 20),
                        _buildDropdown(
                          'Academic Year',
                          selectedAcademicYear,
                          ['2023-2024', '2024-2025', '2025-2026'],
                          (value) {
                            setState(() {
                              selectedAcademicYear = value!;
                            });
                          },
                        ),
                      ]),
                      const SizedBox(height: 30),
                      _buildSection('Generation Options', [
                        _buildSwitch(
                          'Include Faculty Preferences',
                          includePreferences,
                          (value) {
                            setState(() {
                              includePreferences = value;
                            });
                          },
                        ),
                        const SizedBox(height: 15),
                        _buildSwitch(
                          'Optimize for Conflicts',
                          optimizeConflicts,
                          (value) {
                            setState(() {
                              optimizeConflicts = value;
                            });
                          },
                        ),
                      ]),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          _buildButton(
                            "Generate",
                            const Color(0xFF010042),
                            Colors.white,
                            () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => const GeneratedLoadScreen(),
                                ),
                              );
                            },
                          ),
                          const SizedBox(width: 20),
                          _buildButton(
                            "Cancel",
                            Color.fromARGB(255, 243, 20, 4),
                            Colors.white,
                            () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF010042),
          ),
        ),
        const SizedBox(height: 20),
        ...children,
      ],
    );
  }

  Widget _buildDropdown(
    String label,
    String value,
    List<String> items,
    Function(String?) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              items:
                  items.map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSwitch(String label, bool value, Function(bool) onChanged) {
    return Row(
      children: [
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: const Color(0xFF010042),
        ),
        const SizedBox(width: 10),
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}

class GeneratedLoadScreen extends StatelessWidget {
  const GeneratedLoadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GenerateLoadController controller = Get.find();
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: Row(
        children: [
          Sidebar(
            selectedItem: 'Schedule',
            onItemSelected: (title, route) {
              Navigator.pushNamed(context, route);
            },
          ),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 50),
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 1, color: Colors.grey.shade400),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 30,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Generated Schedule',
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Obx(() {
                        final subjects = controller.subjects;
                        final scheduleData = generateScheduleDataWithIds(
                          subjects,
                        );
                        return buildScheduleTable(scheduleData);
                      }),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          _buildButton(
                            "Accept",
                            const Color(0xFF010042),
                            Colors.white,
                            () {
                              final box = GetStorage();
                              final userId = box.read('user_id');
                              final subjects = controller.subjects;
                              final scheduleData = generateScheduleDataWithIds(
                                subjects,
                              );
                              final rows = convertToScheduleRowsWithUser(
                                scheduleData,
                                userId,
                              );
                              controller.saveSchedule(rows);
                            },
                          ),
                          const SizedBox(width: 20),
                          _buildButton(
                            "Regenerate",
                            Colors.white,
                            const Color(0xFF010042),
                            () {},
                            borderColor: const Color(0xFF010042),
                          ),
                          const Spacer(),
                          _buildButton(
                            "Cancel",
                            Color.fromARGB(255, 243, 20, 4),
                            Colors.white,
                            () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildButton(
  String text,
  Color bgColor,
  Color textColor,
  VoidCallback onPressed, {
  Color? borderColor,
}) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      width: 180,
      height: 45,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(30),
        border:
            borderColor != null
                ? Border.all(color: borderColor, width: 1)
                : null,
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );
}

final List<String> days = ['M', 'T', 'W', 'Th', 'F'];
final List<String> lecTimeSlots = [
  '7:00 AM - 9:00 AM',
  '9:00 AM - 11:00 AM',
  '11:00 AM - 1:00 PM',
  '1:00 PM - 3:00 PM',
  '3:00 PM - 5:00 PM',
  '5:00 PM - 7:00 PM',
];
final List<String> labTimeSlots = [
  '7:00 AM - 10:00 AM',
  '10:00 AM - 1:00 PM',
  '1:00 PM - 4:00 PM',
  '4:00 PM - 7:00 PM',
];

Map<String, String> getRandomSchedule({required bool isLab}) {
  final random = Random();
  final day = days[random.nextInt(days.length)];
  final time =
      isLab
          ? labTimeSlots[random.nextInt(labTimeSlots.length)]
          : lecTimeSlots[random.nextInt(lecTimeSlots.length)];
  return {'day': day, 'time': time};
}

List<Map<String, dynamic>> generateScheduleDataWithIds(List<dynamic> subjects) {
  final random = Random();
  List<Map<String, dynamic>> data = [];
  // Track assigned slots: e.g., 'T 10:00 AM - 1:00 PM/LEC-ROOM'
  final Set<String> assignedSlots = {};

  for (var subject in subjects) {
    bool hasLab = subject['lab'] != null && subject['lab'] != '0';
    bool hasLec = subject['lec'] != null && subject['lec'] != '0';
    String? labDay;
    String? lecDay;
    String? labSlot;
    String? lecSlot;

    // If both lab and lec, assign lab first, then lec on a different day
    if (hasLab && hasLec) {
      // 1. Assign lab slot
      List<String> possibleLabSlots = [];
      for (var day in days) {
        for (var time in labTimeSlots) {
          final slot = '$day $time/LAB-ROOM';
          if (!assignedSlots.contains(slot)) {
            possibleLabSlots.add(slot);
          }
        }
      }
      if (possibleLabSlots.isNotEmpty) {
        labSlot = possibleLabSlots[random.nextInt(possibleLabSlots.length)];
        assignedSlots.add(labSlot);
        labDay = labSlot.split(' ')[0];
        data.add({
          "subject_id": subject['id'],
          "code": subject['subject_code'],
          "subject_title": subject['descriptive_title'],
          "lec": '0',
          "lab": subject['lab'].toString(),
          "credit": subject['credit'].toString(),
          "section": 'BSIT 3D',
          "schedule_room": labSlot,
          "faculty": 'TBA',
        });
      }
      // 2. Assign lec slot, but not on labDay
      List<String> possibleLecSlots = [];
      for (var day in days) {
        if (day == labDay) continue;
        for (var time in lecTimeSlots) {
          final slot = '$day $time/LEC-ROOM';
          if (!assignedSlots.contains(slot)) {
            possibleLecSlots.add(slot);
          }
        }
      }
      if (possibleLecSlots.isNotEmpty) {
        lecSlot = possibleLecSlots[random.nextInt(possibleLecSlots.length)];
        assignedSlots.add(lecSlot);
        lecDay = lecSlot.split(' ')[0];
        data.add({
          "subject_id": subject['id'],
          "code": subject['subject_code'],
          "subject_title": subject['descriptive_title'],
          "lec": subject['lec'].toString(),
          "lab": '0',
          "credit": subject['credit'].toString(),
          "section": 'BSIT 3D',
          "schedule_room": lecSlot,
          "faculty": 'TBA',
        });
      }
    } else if (hasLab) {
      // Only lab
      List<String> possibleLabSlots = [];
      for (var day in days) {
        for (var time in labTimeSlots) {
          final slot = '$day $time/LAB-ROOM';
          if (!assignedSlots.contains(slot)) {
            possibleLabSlots.add(slot);
          }
        }
      }
      if (possibleLabSlots.isNotEmpty) {
        labSlot = possibleLabSlots[random.nextInt(possibleLabSlots.length)];
        assignedSlots.add(labSlot);
        data.add({
          "subject_id": subject['id'],
          "code": subject['subject_code'],
          "subject_title": subject['descriptive_title'],
          "lec": '0',
          "lab": subject['lab'].toString(),
          "credit": subject['credit'].toString(),
          "section": 'BSIT 3D',
          "schedule_room": labSlot,
          "faculty": 'TBA',
        });
      }
    } else if (hasLec) {
      // Only lec
      List<String> possibleLecSlots = [];
      for (var day in days) {
        for (var time in lecTimeSlots) {
          final slot = '$day $time/LEC-ROOM';
          if (!assignedSlots.contains(slot)) {
            possibleLecSlots.add(slot);
          }
        }
      }
      if (possibleLecSlots.isNotEmpty) {
        lecSlot = possibleLecSlots[random.nextInt(possibleLecSlots.length)];
        assignedSlots.add(lecSlot);
        data.add({
          "subject_id": subject['id'],
          "code": subject['subject_code'],
          "subject_title": subject['descriptive_title'],
          "lec": subject['lec'].toString(),
          "lab": '0',
          "credit": subject['credit'].toString(),
          "section": 'BSIT 3D',
          "schedule_room": lecSlot,
          "faculty": 'TBA',
        });
      }
    }
  }
  return data;
}

Widget buildScheduleTable(List<Map<String, dynamic>> scheduleData) {
  const tableHeaderStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 13,
    color: Color(0xFF010042),
  );

  const tableCellStyle = TextStyle(fontSize: 12);

  return Card(
    elevation: 4,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          // Header Row
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFFE3E6F3),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: 1000, // Reduced width
                child: Row(
                  children: const [
                    SizedBox(
                      width: 100,
                      child: _TableHeaderCell('CODE', tableHeaderStyle),
                    ),
                    SizedBox(
                      width: 200,
                      child: _TableHeaderCell(
                        'SUBJECT TITLE',
                        tableHeaderStyle,
                      ),
                    ),
                    SizedBox(
                      width: 60,
                      child: _TableHeaderCell('Lec', tableHeaderStyle),
                    ),
                    SizedBox(
                      width: 60,
                      child: _TableHeaderCell('Lab', tableHeaderStyle),
                    ),
                    SizedBox(
                      width: 60,
                      child: _TableHeaderCell('Credit', tableHeaderStyle),
                    ),
                    SizedBox(
                      width: 100,
                      child: _TableHeaderCell('SECTION', tableHeaderStyle),
                    ),
                    SizedBox(
                      width: 200,
                      child: _TableHeaderCell(
                        'SCHEDULE/ROOM',
                        tableHeaderStyle,
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      child: _TableHeaderCell('FACULTY', tableHeaderStyle),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Data Rows
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: 1000, // Reduced width
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: scheduleData.length,
                itemBuilder: (context, index) {
                  final row = scheduleData[index];
                  return Container(
                    decoration: BoxDecoration(
                      color:
                          index % 2 == 0
                              ? Colors.white
                              : const Color(0xFFF6F8FC),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 100,
                          child: _TableCell(row['code'], tableCellStyle),
                        ),
                        SizedBox(
                          width: 200,
                          child: _TableCell(
                            row['subject_title'],
                            tableCellStyle,
                          ),
                        ),
                        SizedBox(
                          width: 60,
                          child: _TableCell(row['lec'], tableCellStyle),
                        ),
                        SizedBox(
                          width: 60,
                          child: _TableCell(row['lab'], tableCellStyle),
                        ),
                        SizedBox(
                          width: 60,
                          child: _TableCell(row['credit'], tableCellStyle),
                        ),
                        SizedBox(
                          width: 100,
                          child: _TableCell(row['section'], tableCellStyle),
                        ),
                        SizedBox(
                          width: 200,
                          child: _TableCell(
                            row['schedule_room'],
                            tableCellStyle,
                          ),
                        ),
                        SizedBox(
                          width: 100,
                          child: _TableCell(row['faculty'], tableCellStyle),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

class _TableHeaderCell extends StatelessWidget {
  final String text;
  final TextStyle style;

  const _TableHeaderCell(this.text, this.style);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: Text(text, style: style, overflow: TextOverflow.ellipsis),
    );
  }
}

class _TableCell extends StatelessWidget {
  final String text;
  final TextStyle style;

  const _TableCell(this.text, this.style);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: Text(text, style: style, overflow: TextOverflow.ellipsis),
    );
  }
}

List<Map<String, dynamic>> convertToScheduleRowsWithUser(
  List<Map<String, dynamic>> scheduleData,
  dynamic userId,
) {
  return scheduleData.map((row) {
    return {
      "user_id": userId,
      "subject_id": row["subject_id"],
      "code": row["code"],
      "subject_title": row["subject_title"],
      "lec": row["lec"],
      "lab": row["lab"],
      "credit": row["credit"],
      "section": row["section"],
      "schedule_room": row["schedule_room"],
      "faculty": row["faculty"],
    };
  }).toList();
}
