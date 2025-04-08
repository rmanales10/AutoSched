import 'package:autosched/widgets/sidebar.dart';
import 'package:flutter/material.dart';

class SubjectsListScreen extends StatefulWidget {
  final String selectedItem;
  final Function(String, String) onItemSelected;

  const SubjectsListScreen({
    super.key,
    required this.selectedItem,
    required this.onItemSelected,
  });

  @override
  _SubjectsListScreenState createState() => _SubjectsListScreenState();
}

class _SubjectsListScreenState extends State<SubjectsListScreen> {
  late String selectedItem;

  final List<List<String>> subjectsData = [
    ["ID", "SUBJECT CODE", "DESCRIPTIVE TITLE", "LEC", "LAB", "CREDIT", "ACTIONS"],
    ["001", "IT321", "CAPSTONE PROJECT AND RESEARCH 1", "2.0", "1.0", "3.0", ""],
    ["002", "IT112", "Computer Programming 1", "2.0", "1.0", "3.0", ""],
    ["003", "CS101", "Introduction to Computer Science", "3.0", "0.0", "3.0", ""],
    ["004", "MATH101", "College Algebra", "3.0", "0.0", "3.0", ""],
    ["005", "ENG101", "English Composition", "3.0", "0.0", "3.0", ""],
  ];

  @override
  void initState() {
    super.initState();
    selectedItem = widget.selectedItem;
  }

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
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Section
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 30,
                      bottom: 10,
                      left: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'SUBJECTS LIST',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.print,
                                color: Colors.green,
                                size: 50,
                              ),
                              onPressed: () {
                                // Print Action
                              },
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.note_add_rounded,
                                color: Color.fromARGB(255, 1, 0, 66),
                                size: 50,
                              ),
                              onPressed: () {
                                Navigator.pushNamed(context, '/addsubject');
                              },
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: Color.fromARGB(255, 243, 20, 4),
                                size: 50,
                              ),
                              onPressed: () {
                                // Delete Action
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
            
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: List.generate(subjectsData.length, (index) {
                          return _buildRow(subjectsData[index], index);
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
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      decoration: BoxDecoration(
        color: isHeader
            ? Colors.white
            : (isEvenRow ? Colors.white : Colors.transparent),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Expanded(flex: 1, child: _rowText(values[0], isHeader)), // ID
          Expanded(flex: 2, child: _rowText(values[1], isHeader)), // Subject Code
          Expanded(flex: 4, child: _rowText(values[2], isHeader)), // Descriptive Title
          Expanded(flex: 1, child: _rowText(values[3], isHeader)), // LEC
          Expanded(flex: 1, child: _rowText(values[4], isHeader)), // LAB
          Expanded(flex: 1, child: _rowText(values[5], isHeader)), // CREDIT
          Expanded(
            flex: 2,
            child: isHeader ? _rowText(values[6], isHeader) : _actionIcons(),
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
          icon: const Icon(
            Icons.content_paste_search_rounded,
            color: Colors.green,
            size: 40,
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/viewsubject');
          },
        ),
        IconButton(
          icon: const Icon(
            Icons.edit,
            color: Colors.green,
            size: 40,
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/editsubject');
          },
        ),
      ],
    );
  }
}