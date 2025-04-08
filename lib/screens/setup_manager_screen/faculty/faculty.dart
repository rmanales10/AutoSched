import 'package:autosched/screens/setup_manager_screen/faculty/faculty_controller.dart';
import 'package:autosched/widgets/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FacultyScreen extends StatefulWidget {
  final String selectedItem;
  final Function(String, String) onItemSelected;

  const FacultyScreen({
    super.key,
    required this.selectedItem,
    required this.onItemSelected,
  });

  @override
  _FacultyScreenState createState() => _FacultyScreenState();
}

class _FacultyScreenState extends State<FacultyScreen> {
  final _controller = Get.put(FacultyController());
  late String selectedItem;

  @override
  void initState() {
    _controller.fetchFacultyData();
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
                      right: 70,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'FACULTY LIST',
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
                                Navigator.pushNamed(context, '/addfaculty');
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),

                  Expanded(
                    child: Obx(() {
                      if (_controller.facultyData.isEmpty) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            _buildRow([
                              "ID",
                              "NAME",
                              "POSITION",
                              "DEPARTMENT",
                              "ACTIONS",
                            ], true),
                            ..._controller.facultyData.map(
                              (faculty) => _buildRow([
                                faculty['faculty_id'].toString(),
                                '${faculty['first_name'] ?? ''} ${faculty['last_name'] ?? ''}',
                                faculty['position'] ?? '',
                                faculty['department'] ?? '',
                                '',
                              ], false),
                            ),
                          ],
                        ),
                      );
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
  Widget _buildRow(List<String> values, bool isHeader) {
    bool isEvenRow =
        !isHeader && _controller.facultyData.indexOf(values[0]) % 2 == 0;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      decoration: BoxDecoration(
        color:
            isHeader
                ? Colors.white
                : (isEvenRow ? Colors.white : Colors.transparent),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Expanded(flex: 1, child: _rowText(values[0], isHeader)), // ID
          Expanded(flex: 3, child: _rowText(values[1], isHeader)), // Name
          Expanded(flex: 2, child: _rowText(values[2], isHeader)), // Position
          Expanded(flex: 2, child: _rowText(values[3], isHeader)), // Department
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
        IconButton(
          icon: const Icon(
            Icons.content_paste_search_rounded,
            color: Colors.green,
            size: 40,
          ),
          onPressed: () {
            // View Faculty Action
          },
        ),
        IconButton(
          icon: const Icon(Icons.edit, color: Colors.green, size: 40),
          onPressed: () {
            // Edit Faculty Action
          },
        ),
      ],
    );
  }
}
