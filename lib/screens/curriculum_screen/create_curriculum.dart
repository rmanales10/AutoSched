import 'package:autosched/widgets/sidebar.dart';
import 'package:flutter/material.dart';

class CreateCurriculumScreen extends StatefulWidget {
  const CreateCurriculumScreen({super.key});

  @override
  _CreateCurriculumScreenState createState() => _CreateCurriculumScreenState();
}

class _CreateCurriculumScreenState extends State<CreateCurriculumScreen> {
  String? selectedProgram;
  String? selectedMajor;
  String? selectedSemester;
  String selectedItem = "Curriculum"; // Default selected item

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: Row(
        children: [
          // Sidebar
          Sidebar(
            selectedItem: selectedItem,
            onItemSelected: (title, route) {
              setState(() {
                selectedItem = title;
              });
              Navigator.pushNamed(context, route);
            },
          ),

          // Main Content
          Expanded(
            child: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 200, vertical: 50),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 30),
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
                          "Create Curriculum",
                          style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 30),
                        _buildDropdowns(),
                        const SizedBox(height: 50),

                        // Text Fields
                        _buildTextField("Curriculum Name"),
                        const SizedBox(height: 30),
                        _buildTextField("Description"),
                        const SizedBox(height: 30),
                        _buildTextField("Notes"),

                        const SizedBox(height: 50),
                        _buildButtons(),
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

  Widget _buildDropdowns() {
    return Wrap(
      spacing: 50,
      runSpacing: 30,
      children: [
        _buildDropdown("Campus", ["Oroquieta", "Panaon"], (value) {
          setState(() => selectedSemester = value);
        }, selectedSemester),
        _buildDropdown("Program", ["BFPT", "BSIT"], (value) {
          setState(() => selectedProgram = value);
        }, selectedProgram),
        _buildDropdown("Major", ["Software Engineering", "Capstone"], (value) {
          setState(() => selectedMajor = value);
        }, selectedMajor),
      ],
    );
  }

  Widget _buildDropdown(
    String hint,
    List<String> options,
    ValueChanged<String?> onChanged,
    String? selectedValue,
  ) {
    return Container(
      width: 380,
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
          hint: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(hint, style: TextStyle(fontSize: 16, color: Colors.grey.shade600)),
          ),
          value: selectedValue,
          onChanged: onChanged,
          items: options.map((option) {
            return DropdownMenuItem(
              value: option,
              child: Text(option, style: TextStyle(fontSize: 16, color: Colors.grey.shade600)),
            );
          }).toList(),
          icon: Icon(Icons.arrow_drop_down_rounded, color: Colors.grey.shade600, size: 24),
        ),
      ),
    );
  }

  Widget _buildTextField(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 5),
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(width: 1, color: Colors.grey.shade300),
          ),
          child: TextField(
            cursorColor: Colors.black,
            style: const TextStyle(fontSize: 16,),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              border: InputBorder.none,
              hintText: label,
              hintStyle: TextStyle(fontSize: 16, color: Colors.grey.shade600),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildButtons() {
    return Row(
      children: [
        _buildButton("Save", const Color(0xFF010042), Colors.white, () {
          _showConfirmationDialog(context);
        }),
        const SizedBox(width: 20),
        _buildButton("Cancel", const Color(0xFFF31404), Colors.white, () {
          Navigator.pop(context);
        }),
      ],
    );
  }

  Widget _buildButton(String text, Color bgColor, Color textColor, VoidCallback onTap) {
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
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: textColor),
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
                  "Do you want to save curriculum?",
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
