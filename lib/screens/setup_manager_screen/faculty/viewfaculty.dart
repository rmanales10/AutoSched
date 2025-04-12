import 'package:autosched/widgets/sidebar.dart';
import 'package:flutter/material.dart';

class ViewFacultyScreen extends StatefulWidget {
  const ViewFacultyScreen({super.key});

  @override
  _ViewFacultyScreenState createState() => _ViewFacultyScreenState();
}

class _ViewFacultyScreenState extends State<ViewFacultyScreen> {
  String? selectedPosition;
  String? selectedStatus;
  String? selectedDepartment;
  String? selectedDesignation;
  List<bool> constraints = [false, false, false];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double inputFontSize = screenWidth < 600 ? 14 : 23;
    double textFieldWidth = screenWidth > 1200 ? 380 : screenWidth * 0.3;

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: Row(
        children: [
          Sidebar(
            selectedItem: "Faculty",
            onItemSelected: (title, route) {
              Navigator.pushNamed(context, route);
            },
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(width: 1, color: Colors.grey.shade400),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "View Faculty",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 50),
                        _buildFacultyForm(inputFontSize, textFieldWidth),
                        const SizedBox(height: 70),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            _buildButton(
                              "Edit",
                              const Color.fromARGB(255, 1, 0, 66),
                              Colors.white,
                              onTap:
                                  () => Navigator.pushNamed(
                                    context,
                                    '/editfaculty',
                                  ),
                            ),
                            const SizedBox(width: 20),
                            _buildButton(
                              "Cancel",
                              const Color.fromARGB(255, 243, 20, 4),
                              Colors.white,
                              onTap: () {
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
          ),
        ],
      ),
    );
  }

  Widget _buildFacultyForm(double fontSize, double width) {
    return Column(
      children: [
        Wrap(
          spacing: 20,
          runSpacing: 30,
          children: [
            _buildTextField("Name", "Input Name", fontSize, width),
            _buildTextField("Email", "Input email", fontSize, width),
            _buildTextField("Mobile Number", "+639...", fontSize, width),
            _buildDropdownField(
              "Position",
              "Choose Position",
              ["Instructor", "Professor", "Associate Professor"],
              fontSize,
              width,
              (value) {
                setState(() {
                  selectedPosition = value;
                });
              },
            ),
            _buildDropdownField(
              "Status",
              "Choose Status",
              ["Full-time", "Part-time", "Visiting"],
              fontSize,
              width,
              (value) {
                setState(() {
                  selectedStatus = value;
                });
              },
            ),
            _buildDropdownField(
              "Department",
              "Choose Department",
              ["BSIT", "BFPT", "BTLED"],
              fontSize,
              width,
              (value) {
                setState(() {
                  selectedDepartment = value;
                });
              },
            ),
            Row(
              children: [
                Expanded(
                  child: _buildDropdownField(
                    "Designation",
                    "Choose Designation",
                    ["Chairperson", "Dean", "Registrar"],
                    fontSize,
                    width,
                    (value) {
                      setState(() {
                        selectedDesignation = value;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  flex: 2,
                  child: _buildConstraintsSection(fontSize, width),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildConstraintsSection(double fontSize, double width) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Constraints",
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildConstraintCheckbox("5PM Onwards Only", 0),
            const SizedBox(width: 30),
            _buildConstraintCheckbox("Saturday Only", 1),
            const SizedBox(width: 30),
            _buildConstraintCheckbox("8AM-5PM Only", 2),
          ],
        ),
      ],
    );
  }

  Widget _buildConstraintCheckbox(String label, int index) {
    return Row(
      children: [
        Transform.scale(
          scale: 1.5,
          child: Checkbox(
            value: constraints[index],
            onChanged: (value) {
              setState(() {
                constraints[index] = value!;
              });
            },
            activeColor: Colors.green,
            side: BorderSide(color: Colors.green, width: 2),
          ),
        ),
        const SizedBox(width: 5),
        Text(
          label,
          style: const TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 117, 117, 117),
          ),
        ),
      ],
    );
  }

  Widget _buildButton(
    String text,
    Color bgColor,
    Color textColor, {
    VoidCallback? onTap,
  }) {
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
              fontSize: 23,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownField(
    String label,
    String hint,
    List<String> items,
    double fontSize,
    double width,
    ValueChanged<String?> onChanged,
  ) {
    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              label,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.grey[600],
              ),
            ),
          ),
          const SizedBox(height: 5),
          Container(
            width: width,
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(width: 1, color: Colors.grey.shade300),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                borderRadius: BorderRadius.circular(30),
                hint: Text(
                  hint,
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade400,
                  ),
                ),
                value: null,
                onChanged: onChanged,
                items:
                    items.map((item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(
                          item,
                          style: TextStyle(
                            fontSize: fontSize,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade400,
                          ),
                        ),
                      );
                    }).toList(),
                icon: Icon(
                  Icons.arrow_drop_down_rounded,
                  color: Colors.grey.shade600,
                  size: 24,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
    String label,
    String hint,
    double fontSize,
    double width,
  ) {
    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              label,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.grey[600],
              ),
            ),
          ),
          const SizedBox(height: 5),
          Container(
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(width: 1, color: Colors.grey.shade300),
            ),
            child: TextField(
              style: TextStyle(fontSize: fontSize),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                border: InputBorder.none,
                hintText: hint,
                hintStyle: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
