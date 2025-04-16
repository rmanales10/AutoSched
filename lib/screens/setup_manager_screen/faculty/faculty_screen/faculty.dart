import 'package:autosched/screens/setup_manager_screen/faculty/edit_faculty/edit_faculty.dart';
import 'package:autosched/screens/setup_manager_screen/faculty/faculty_screen/faculty_controller.dart';
import 'package:autosched/screens/setup_manager_screen/faculty/viewfaculty.dart';
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
            child:
                isHeader
                    ? _rowText(values[4], isHeader)
                    : _actionIcons(
                      values[0],
                      values[1],
                      values[2],
                      values[3],
                      values[4],
                    ),
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
  Widget _actionIcons(
    String id,
    String firstName,
    String lastName,
    String email,
    String phone,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(
            Icons.content_paste_search_rounded,
            color: Colors.green,
            size: 40,
          ),
          onPressed:
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ViewfacultyScreen(id: int.parse(id)),
                ),
              ),
        ),
        IconButton(
          icon: const Icon(Icons.edit, color: Colors.green, size: 40),
          onPressed:
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditFacultyScreen(id: int.parse(id)),
                ),
              ),
        ),
        IconButton(
          icon: const Icon(
            Icons.delete,
            color: Color.fromARGB(255, 243, 20, 4),
            size: 50,
          ),
          onPressed: () => _showConfirmationDialog(context, id),
        ),
      ],
    );
  }

  void _showConfirmationDialog(BuildContext context, String id) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            width: 500,
            height: 200,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Do you want to add changes ?",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        await _controller.deleteFaculty(id: id);
                        await _controller.fetchFacultyData();
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        width: 120,
                        height: 30,
                        decoration: BoxDecoration(
                          color: const Color(0xFF010042),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Center(
                          child: Text(
                            "Submit",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        width: 120,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: Colors.grey.shade400,
                            width: 1,
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            "No",
                            style: TextStyle(
                              color: Color(0xFF010042),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
