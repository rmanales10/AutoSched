import 'package:autosched/widgets/sidebar.dart';
import 'package:flutter/material.dart';

class TeachingLoadScreen extends StatefulWidget {
  const TeachingLoadScreen({super.key});

  @override
  _TeachingLoadScreenState createState() => _TeachingLoadScreenState();
}

class _TeachingLoadScreenState extends State<TeachingLoadScreen> {
  String selectedItem = "Teaching Load";
  final List<List<String>> teachingLoadData = [
    ["ID", "TEACHING LOAD", "PROGRAM", "STATUS", "ACTIONS"],
    ["0021", "FINAL-LOAD-2024", "BSIT", "APPROVED", ""],
    ["0021", "FINAL-LOAD-2024", "BSIT", "APPROVED", ""],
    ["0021", "FINAL-LOAD-2024", "BSIT", "APPROVED", ""],
    ["0021", "FINAL-LOAD-2024", "BSIT", "APPROVED", ""],
    ["0021", "FINAL-LOAD-2024", "BSIT", "APPROVED", ""],
    ["0021", "FINAL-LOAD-2024", "BSIT", "APPROVED", ""],
    ["0021", "FINAL-LOAD-2024", "BSIT", "APPROVED", ""],
    ["0021", "FINAL-LOAD-2024", "BSIT", "APPROVED", ""],
    ["0021", "FINAL-LOAD-2024", "BSIT", "APPROVED", ""],
    ["0021", "FINAL-LOAD-2024", "BSIT", "APPROVED", ""],
    ["0021", "FINAL-LOAD-2024", "BSIT", "APPROVED", ""],
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
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'TEACHING LOAD LIST',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.note_add_rounded,
                                color: Color.fromARGB(255, 1, 0, 66),
                                size: 50,
                              ),
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  '/create_teaching-load',
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50),
                  Column(
                    children: List.generate(teachingLoadData.length, (index) {
                      return _buildRow(teachingLoadData[index], index);
                    }),
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
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/assign-faculty-load');
          },
          child: Stack(
            children: [
              Icon(
                Icons.groups,
                size: 40,
                color: Colors.green,
              ), // Main group icon
              Positioned(
                bottom: 0,
                right: 0,
                child: Icon(
                  Icons.check_circle,
                  size: 18,
                  color: Colors.green,
                ), // Small checkmark overlay
              ),
            ],
          ),
        ),
        SizedBox(width: 5),
        IconButton(
          icon: Icon(
            Icons.content_paste_search_rounded,
            color: Colors.green,
            size: 40,
          ), // View Icon
          onPressed: () {
            Navigator.pushNamed(context, '/view-teaching-load');
          },
        ),
        IconButton(
          icon: Icon(Icons.edit, color: Colors.green, size: 40), // View Icon
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
