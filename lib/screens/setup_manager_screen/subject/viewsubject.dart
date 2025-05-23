import 'package:autosched/widgets/sidebar.dart';
import 'package:flutter/material.dart';

class ViewSubjectScreen extends StatefulWidget {
  const ViewSubjectScreen({super.key});

  @override
  _ViewSubjectScreenState createState() => _ViewSubjectScreenState();
}

class _ViewSubjectScreenState extends State<ViewSubjectScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double inputFontSize = screenWidth < 600 ? 14 : 18;
    double textFieldWidth = screenWidth > 1200 ? 380 : screenWidth * 0.3;

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: Row(
        children: [
          Sidebar(
            selectedItem: "Subjects",
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
                        const SizedBox(height: 20),
                        const Text(
                          "View Subject",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 50),
                        _buildSubjectForm(inputFontSize, textFieldWidth),
                        const SizedBox(height: 70),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            _buildButton(
                              "Edit",
                              const Color.fromARGB(255, 1, 0, 66),
                              Colors.white,
                              onTap:
                                  () => Navigator.pushNamed(
                                    context,
                                    '/editsubject',
                                  ),
                            ),
                            const SizedBox(width: 20),
                            _buildButton(
                              "Cancel",
                              const Color.fromARGB(255, 243, 20, 4),
                              Colors.white,
                              onTap: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
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

  Widget _buildSubjectForm(double fontSize, double width) {
    return Column(
      children: [
        Wrap(
          spacing: 30,
          runSpacing: 30,
          children: [
            _buildTextField("Input subject code", fontSize, width),
            _buildTextField("Lab Units", fontSize, width),
            _buildTextField("Lab HRS", fontSize, width),
            _buildTextField("Input descriptive title", fontSize, width),
            _buildTextField("Lec Units", fontSize, width),
            _buildTextField("Lec HRS", fontSize, width),
            _buildTextField("Input credit units", fontSize, width),
            _buildDropdownField(
              ['IT', 'CS', 'Engineering'],
              'Subject Area',
              fontSize,
              width,
            ),
            _buildDropdownField(
              ['1st Year', '2nd Year'],
              'Year Level',
              fontSize,
              width,
            ),
            _buildDropdownField(['BSIT', 'BSCS'], 'Program', fontSize, width),
            _buildDropdownField(
              ['Software', 'Network'],
              'Major',
              fontSize,
              width,
            ),
            _buildDropdownField(['Online', 'Hybrid'], 'Mode', fontSize, width),
          ],
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

  Widget _buildTextField(String hint, double fontSize, double width) {
    return SizedBox(
      width: width,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(width: 1, color: Colors.grey.shade300),
        ),
        child: TextField(
          cursorColor: Colors.grey[600],
          style: TextStyle(fontSize: fontSize),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 20,
            ),
            border: InputBorder.none,
            hintText: hint,
            hintStyle: TextStyle(fontSize: fontSize, color: Colors.black),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownField(
    List<String> items,
    String hint,
    double fontSize,
    double width,
  ) {
    String? selectedValue;

    return StatefulBuilder(
      builder: (context, setState) {
        return SizedBox(
          width: width,
          child: Container(
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
                value: selectedValue,
                icon: Icon(
                  Icons.arrow_drop_down_rounded,
                  color: Colors.grey.shade600,
                  size: 24,
                ),
                hint: Text(
                  hint,
                  style: TextStyle(fontSize: fontSize, color: Colors.black),
                ),
                items:
                    items.map((item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(
                          item,
                          style: TextStyle(
                            fontSize: fontSize,
                            color: Colors.black,
                          ),
                        ),
                      );
                    }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedValue = value;
                  });
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
