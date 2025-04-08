import 'package:autosched/widgets/sidebar.dart';
import 'package:flutter/material.dart';

class ViewRoomScreen extends StatefulWidget {
  const ViewRoomScreen({super.key});

  @override
  _ViewRoomScreenSatate createState() => _ViewRoomScreenSatate();
}

class _ViewRoomScreenSatate extends State<ViewRoomScreen> {
  String? selectedRoomType;

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
            selectedItem: "Rooms",
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
                          "View Room",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 50),
                        _buildRoomForm(inputFontSize, textFieldWidth),
                        const SizedBox(height: 70),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            _buildButton(
                              "Edit",
                              const Color.fromARGB(255, 1, 0, 66),
                              Colors.white,
                              onTap:
                                  () =>
                                      Navigator.pushNamed(context, '/editroom'),
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

  Widget _buildRoomForm(double fontSize, double width) {
    return Column(
      children: [
        Wrap(
          spacing: 50,
          runSpacing: 30,
          children: [
            _buildTextField("Room Number", fontSize, width),
            _buildTextField("Room Name", fontSize, width),
            _buildDropdownField(fontSize, width),
            _buildTextField("Add Description", fontSize, width),
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

  Widget _buildDropdownField(double fontSize, double width) {
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
            hint: Text(
              "Room Type",
              style: TextStyle(fontSize: fontSize, color: Colors.black),
            ),
            value: selectedRoomType,
            icon: Icon(
              Icons.arrow_drop_down_rounded,
              color: Colors.grey.shade600,
              size: 24,
            ),
            items:
                ['Lecture Hall', 'Lab', 'Conference Room']
                    .map(
                      (type) => DropdownMenuItem(
                        value: type,
                        child: Text(
                          type,
                          style: TextStyle(
                            fontSize: fontSize,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    )
                    .toList(),
            onChanged: (value) {
              setState(() {
                selectedRoomType = value;
              });
            },
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
}
