import 'package:autosched/widgets/sidebar.dart';
import 'package:flutter/material.dart';

class GeneratedScheduleScreen extends StatefulWidget {
  const GeneratedScheduleScreen({super.key});

  @override
  _GeneratedScheduleScreenState createState() => _GeneratedScheduleScreenState();
}

class _GeneratedScheduleScreenState extends State<GeneratedScheduleScreen> {
  String selectedItem = "Generated Schedules";

  final List<List<String>> scheduleData = [
    ["ID", "GENERATED SCHEDULE", "SEMESTER", "ACTIONS"],
    ["0021", "USTP-1ST-SEM-SCHED", "1ST SEMESTER 2023-2024", ""],
    ["0022", "USTP-2ND-SEM-SCHED", "2ND SEMESTER 2023-2024", ""],
    ["0023", "USTP-SUMMER-SCHED", "SUMMER 2023-2024", ""],
    ["0021", "USTP-1ST-SEM-SCHED", "1ST SEMESTER 2023-2024", ""],
    ["0022", "USTP-2ND-SEM-SCHED", "2ND SEMESTER 2023-2024", ""],
    ["0023", "USTP-SUMMER-SCHED", "SUMMER 2023-2024", ""],
    ["0021", "USTP-1ST-SEM-SCHED", "1ST SEMESTER 2023-2024", ""],
    ["0022", "USTP-2ND-SEM-SCHED", "2ND SEMESTER 2023-2024", ""],
    ["0023", "USTP-SUMMER-SCHED", "SUMMER 2023-2024", ""],
    ["0021", "USTP-1ST-SEM-SCHED", "1ST SEMESTER 2023-2024", ""],
    ["0022", "USTP-2ND-SEM-SCHED", "2ND SEMESTER 2023-2024", ""],
    ["0023", "USTP-SUMMER-SCHED", "SUMMER 2023-2024", ""],
    ["0021", "USTP-1ST-SEM-SCHED", "1ST SEMESTER 2023-2024", ""],
    ["0022", "USTP-2ND-SEM-SCHED", "2ND SEMESTER 2023-2024", ""],
    ["0023", "USTP-SUMMER-SCHED", "SUMMER 2023-2024", ""],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Sidebar(
            selectedItem: selectedItem,
            onItemSelected: (title, route) {
              setState(() {
                selectedItem = title;
              });
              Navigator.pushNamed(context, route);
            },
          ),
          Expanded(
            child: Container(
              color: const Color(0xFFF9F9F9),
              padding: const EdgeInsets.all(40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      'SCHEDULES',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: List.generate(scheduleData.length, (index) {
                          return _buildRow(scheduleData[index], index);
                        }),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(List<String> values, int index) {
    bool isHeader = index == 0;
    bool isEvenRow = index % 2 == 0;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      decoration: BoxDecoration(
        color: isEvenRow ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: _rowText(values[0], isHeader),
          ), // ID
          Expanded(
            flex: 3,
            child: _rowText(values[1], isHeader),
          ), // Generated Schedule
          Expanded(
            flex: 2,
            child: _rowText(values[2], isHeader),
          ), // Semester
          Expanded(
            flex: 2,
            child: isHeader ? _rowText(values[3], isHeader) : _actionIcons(),
          ), // Actions
        ],
      ),
    );
  }

  Widget _rowText(String text, bool isHeader) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
        fontSize: 20,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _actionIcons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(
            Icons.content_paste_search_rounded,
            color: Colors.green,
            size: 40,
          ), // View Icon
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.print, color: Colors.green, size: 40), // Print Icon
          onPressed: () {},
        ),
      ],
    );
  }
}
