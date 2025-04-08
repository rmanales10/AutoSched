import 'package:autosched/widgets/sidebar.dart';
import 'package:flutter/material.dart';

class AssignFacultyLoadScreen extends StatefulWidget {
  const AssignFacultyLoadScreen({super.key});

  @override
  _AssignFacultyLoadScreenState createState() =>
      _AssignFacultyLoadScreenState();
}

class _AssignFacultyLoadScreenState extends State<AssignFacultyLoadScreen> {
  String selectedItem = "Teaching Load"; // Sidebar selected item

  final List<List<String>> facultyLoadData = [
    [
      "SUBJECT CODE",
      "DESCRIPTIVE TITLE",
      "LEC",
      "LAB",
      "CREDIT",
      "FACULTY",
      "SECTION",
    ],
    ["IT111", "Introduction to Computing", "2", "1", "3", "", ""],
    ["IT112", "Computer Programming 1", "2", "1", "3", "", ""],
    ["PurCom", "Purposive Communication", "2", "1", "3", "", ""],
    ["IT113", "Computer Programming 2", "2", "1", "3", "", ""],
    ["IT114", "Data Structures & Algorithms", "2", "1", "3", "", ""],
    ["IT115", "Operating Systems", "2", "1", "3", "", ""],
    ["IT116", "Computer Networks", "2", "1", "3", "", ""],
    ["IT113", "Computer Programming 2", "2", "1", "3", "", ""],
    ["IT114", "Data Structures & Algorithms", "2", "1", "3", "", ""],
    ["IT115", "Operating Systems", "2", "1", "3", "", ""],
    ["IT116", "Computer Networks", "2", "1", "3", "", ""],
  ];

  final List<String> facultyList = ["Prof. Smith", "Dr. Johnson", "Ms. Davis"];
  final List<String> sectionList = ["Section A", "Section B", "Section C"];

  Map<int, String> selectedFaculty = {};
  Map<int, String> selectedSection = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
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
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 60,
                  vertical: 50,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        'ASSIGN FACULTY LOAD',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Column(
                      children: List.generate(
                        facultyLoadData.length,
                        (index) => _buildRow(facultyLoadData[index], index),
                      ),
                    ),
                    const SizedBox(height: 30),
                    _buildBottomSection(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(List<String> values, int index) {
    bool isHeader = index == 0;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      decoration: BoxDecoration(
        color: index % 2 == 0 ? Colors.white : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: _rowText(values[0], isHeader),
          ), // Subject Code
          Expanded(flex: 3, child: _rowText(values[1], isHeader)), // Title
          Expanded(flex: 1, child: _rowText(values[2], isHeader)), // LEC
          Expanded(flex: 1, child: _rowText(values[3], isHeader)), // LAB
          Expanded(flex: 1, child: _rowText(values[4], isHeader)), // CREDIT
          Expanded(
            flex: 2,
            child:
                isHeader
                    ? _rowText(values[5], isHeader)
                    : _facultyDropdown(index),
          ),
          const SizedBox(width: 30),
          Expanded(
            flex: 2,
            child:
                isHeader
                    ? _rowText(values[6], isHeader)
                    : _sectionDropdown(index),
          ),
        ],
      ),
    );
  }

  Widget _rowText(String text, bool isHeader) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
        fontSize: 18,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _facultyDropdown(int index) {
    return _dropdownWidget(
      index: index,
      hint: "Choose Faculty",
      value: selectedFaculty[index],
      items: facultyList,
      onChanged:
          (newValue) => setState(() => selectedFaculty[index] = newValue!),
    );
  }

  Widget _sectionDropdown(int index) {
    return _dropdownWidget(
      index: index,
      hint: "Choose Section",
      value: selectedSection[index],
      items: sectionList,
      onChanged:
          (newValue) => setState(() => selectedSection[index] = newValue!),
    );
  }

  Widget _dropdownWidget({
    required int index,
    required String hint,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(width: 1, color: Colors.grey.shade300),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: value,
            hint: Text(
              hint,
              style: TextStyle(fontSize: 16, color: Colors.grey.shade400),
            ),
            onChanged: onChanged,
            items:
                items.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  );
                }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _buildTotalRow(),
        const SizedBox(width: 30),
        _buildActionButtons(),
      ],
    );
  }

  Widget _buildTotalRow() {
    return Container(
      width: 550,
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 70),
            child: _rowText("Total Units:", true),
          ),
          _rowText("12.0", true),
          _rowText("7.0", true),
          Padding(
            padding: const EdgeInsets.only(right: 40),
            child: _rowText("21.0", true),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        _buildButton("Save", const Color(0xFF010042), Colors.white, () {
          _showConfirmationDialog(context);
        }),
        const SizedBox(width: 20),
        _buildButton(
          "Reset",
          Colors.white,
          const Color(0xFF010042),
          () {
          },
          borderColor: Colors.grey.shade400,
        ),
      ],
    );
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

  void _showConfirmationDialog(BuildContext context) {
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
              mainAxisSize:
                  MainAxisSize.min, // Ensures it only takes needed space
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Do you want to submit teaching load?",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        width: 120,
                        height: 30,
                        decoration: BoxDecoration(
                          color: const Color(0xFF010042),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: const Text(
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
                        child: Center(
                          child: const Text(
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
