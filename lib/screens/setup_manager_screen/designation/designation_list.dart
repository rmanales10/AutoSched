import 'package:autosched/widgets/sidebar.dart';
import 'package:flutter/material.dart';

class DesignationListScreen extends StatefulWidget {
  final String selectedItem;
  final Function(String, String) onItemSelected;

  const DesignationListScreen({
    super.key,
    required this.selectedItem,
    required this.onItemSelected,
  });

  @override
  _DesignationListScreenState createState() => _DesignationListScreenState();
}

class _DesignationListScreenState extends State<DesignationListScreen> {
  late String selectedItem;

  final List<List<String>> designationData = [
    ["ID", "DESIGNATION", "OFFICE/DEPARTMENT", "TIME RELEASE", "ACTIONS"],
    ["001", "CHAIRPERSON", "IT DEPARTMENT", "9 UNITS", ""],
    ["002", "REGISTRAR", "ADMIN OFFICE", "9 UNITS", ""],
    ["003", "DEAN", "COLLEGE OF ENGINEERING", "12 UNITS", ""],
    ["004", "PROGRAM COORDINATOR", "CS DEPARTMENT", "6 UNITS", ""],
    ["005", "LIBRARIAN", "LIBRARY", "9 UNITS", ""],
    ["006", "GUIDANCE COUNSELOR", "GUIDANCE OFFICE", "9 UNITS", ""],
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
                          'DESIGNATION LIST',
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
                                Navigator.pushNamed(context, '/adddesignation');
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
                        children: List.generate(designationData.length, (index) {
                          return _buildRow(designationData[index], index);
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
          Expanded(flex: 3, child: _rowText(values[1], isHeader)), // Designation
          Expanded(flex: 3, child: _rowText(values[2], isHeader)), // Office/Department
          Expanded(flex: 2, child: _rowText(values[3], isHeader)), // Time Release
          Expanded(
            flex: 2,
            child: isHeader ? _rowText(values[4], isHeader) : _actionIcons(),
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
        // IconButton(
        //   icon: const Icon(
        //     Icons.content_paste_search_rounded,
        //     color: Colors.green,
        //     size: 40,
        //   ),
        //   onPressed: () {
        //     Navigator.pushNamed(context, '/viewdesignation');
        //   },
        // ),
        IconButton(
          icon: const Icon(
            Icons.edit,
            color: Colors.green,
            size: 40,
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/editdesignation');
          },
        ),
      ],
    );
  }
}