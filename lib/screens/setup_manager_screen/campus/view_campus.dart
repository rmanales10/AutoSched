import 'package:autosched/widgets/sidebar.dart';
import 'package:flutter/material.dart';

class ViewCampusScreen extends StatefulWidget {
  const ViewCampusScreen({super.key});

  @override
  _ViewCampusScreenState createState() => _ViewCampusScreenState();
}

class _ViewCampusScreenState extends State<ViewCampusScreen> {
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
            selectedItem: "Campus",
            onItemSelected: (title, route) {
              Navigator.pushNamed(context, route);
            },
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 200),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 60,
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
                        const SizedBox(height: 20),
                        const Text(
                          "View Campus",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 50),
                        _buildCampusInfo(inputFontSize, textFieldWidth),
                        const SizedBox(height: 70),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            _buildButton(
                              "Edit",
                              const Color.fromARGB(255, 1, 0, 66),
                              Colors.white,
                              onTap: () {
                                Navigator.pushNamed(context, '/editcampus');
                              },
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

  Widget _buildCampusInfo(double fontSize, double width) {
    return Column(
      children: [
        Wrap(
          spacing: 50,
          runSpacing: 30,
          children: [
            _buildTextField("Campus Name", fontSize, width),
            _buildTextField("Campus Type", fontSize, width),
            _buildTextField("Address", fontSize, width),
          ],
        ),
      ],
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
              color: Colors.grey.shade600,
            ),
          ),
        ),
      ),
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
}
