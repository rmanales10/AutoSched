import 'package:autosched/widgets/sidebar.dart';
import 'package:flutter/material.dart';

class AddSubjectCurScreen extends StatefulWidget {
  const AddSubjectCurScreen({super.key});

  @override
  _AddSubjectCurScreenState createState() => _AddSubjectCurScreenState();
}

class _AddSubjectCurScreenState extends State<AddSubjectCurScreen> {
  String selectedItem = "Curriculum"; // Default selected item
  final TextEditingController _searchController = TextEditingController();
  String selectedSubjectCode = ""; // Added missing state variable
  String query = "";

  List<Map<String, String>> subjects = [
    {
      "id": "001",
      "code": "IT321",
      "title": "CAPSTONE PROJECT AND RESEARCH 1",
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
  ];

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
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 200,
                vertical: 50,
              ),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 30,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(width: 1, color: Colors.grey.shade400),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Add Subject",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 50),
                    _buildSearchField(),
                    const SizedBox(height: 50),
                    _buildSubjectTable(),
                    const Spacer(),
                    _buildButtons(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return Container(
      width: 380,
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(width: 1, color: Colors.grey.shade300),
      ),
      child: TextField(
        cursorColor: Colors.black,
        controller: _searchController,
        decoration: const InputDecoration(
          hintText: "Search Subject",
          suffixIcon: Icon(Icons.search, size: 30),
          border: OutlineInputBorder(borderSide: BorderSide.none),
        ),
        onChanged: (value) {
          setState(() {
            query = value;
          });
        },
      ),
    );
  }

  Widget _buildSubjectTable() {
    List<Map<String, String>> filteredSubjects =
        subjects
            .where(
              (subject) =>
                  subject["code"]!.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();

    return filteredSubjects.isEmpty
        ? const SizedBox()
        : Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
          child: Column(
            children: [
              // Table Header (Removed from scroll)
              Container(
                height: 60,
                decoration: BoxDecoration(
                  color: const Color(0xFF010042),
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    _headerText("ID"),
                    _headerText("SUBJECT CODE"),
                    _headerText("DESCRIPTIVE TITLE", flex: 3),
                    _headerText("LEC"),
                    _headerText("LAB"),
                    _headerText("CREDIT"),
                  ],
                ),
              ),
              // Scrollable Table Rows
              SizedBox(
                height: 250, // Adjust height as needed
                child: SingleChildScrollView(
                  child: Column(
                    children:
                        filteredSubjects
                            .asMap()
                            .entries
                            .map(
                              (entry) =>
                                  _buildSubjectRow(entry.value, entry.key),
                            )
                            .toList(),
                  ),
                ),
              ),
            ],
          ),
        );
  }

  Widget _headerText(String text, {int flex = 1}) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildSubjectRow(Map<String, String> subject, int index) {
    bool isSelected = subject["code"] == selectedSubjectCode;
    Color rowColor =
        isSelected
            ? Colors.white
            : (index.isEven ? Colors.white : Colors.grey.shade300);

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedSubjectCode = subject["code"]!;
        });
      },
      child: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        decoration: BoxDecoration(
          color: rowColor,
          borderRadius: BorderRadius.circular(30),
          border:
              isSelected
                  ? Border.all(color: const Color(0xFF010042), width: 2)
                  : null,
        ),
        child: Row(
          children: [
            _rowText(subject["id"]!),
            _rowText(subject["code"]!),
            _rowText(subject["title"]!, flex: 3),
            _rowText(subject["lec"]!),
            _rowText(subject["lab"]!),
            _rowText(subject["credit"]!),
          ],
        ),
      ),
    );
  }

  Widget _rowText(String text, {int flex = 1}) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        style: const TextStyle(fontSize: 16),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _buildButton("Add", const Color(0xFF010042), Colors.white, () {
          _showConfirmationDialog(context);
        }),
        const SizedBox(width: 20),
        _buildButton("Cancel", const Color(0xFFF31404), Colors.white, () {
          Navigator.pop(context);
        }),
      ],
    );
  }

  Widget _buildButton(
    String text,
    Color bgColor,
    Color textColor,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 180,
        height: 45,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: textColor,
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
                  "Do you want add changes?",
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
