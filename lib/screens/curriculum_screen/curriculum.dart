import 'package:autosched/widgets/sidebar.dart';
import 'package:flutter/material.dart';

class CurriculumScreen extends StatefulWidget {
  const CurriculumScreen({super.key});

  @override
  _CurriculumScreenState createState() => _CurriculumScreenState();
}

class _CurriculumScreenState extends State<CurriculumScreen> {
  String selectedItem = "Curriculum"; // Default selected item

  // Sample data
  final List<List<String>> curriculumData = [
    ["ID", "CURRICULUM NAME", "PROGRAM", "ACTIONS"],
    ["0021", "BSIT-NEW-CURR-21", "BSIT", ""],
    ["0022", "BSIT-NEW-CURR-22", "BSIT", ""],
    ["0021", "BSIT-NEW-CURR-21", "BSIT", ""],
    ["0022", "BSIT-NEW-CURR-22", "BSIT", ""],
    ["0021", "BSIT-NEW-CURR-21", "BSIT", ""],
    ["0022", "BSIT-NEW-CURR-22", "BSIT", ""],
    ["0021", "BSIT-NEW-CURR-21", "BSIT", ""],
    ["0022", "BSIT-NEW-CURR-22", "BSIT", ""],
    ["0021", "BSIT-NEW-CURR-21", "BSIT", ""],
    ["0022", "BSIT-NEW-CURR-22", "BSIT", ""],
    ["0021", "BSIT-NEW-CURR-21", "BSIT", ""],
    ["0022", "BSIT-NEW-CURR-22", "BSIT", ""],
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
                      'CURRICULUM LIST',
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 50),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: List.generate(curriculumData.length, (index) {
                          return _buildRow(curriculumData[index], index);
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

  // Function to build each row dynamically
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
          ), // ID (smaller space)
          Expanded(
            flex: 3,
            child: _rowText(values[1], isHeader),
          ), // Curriculum Name
          Expanded(flex: 2, child: _rowText(values[2], isHeader)), // Program
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

  // Actions Column Icons (Only for data rows)
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
