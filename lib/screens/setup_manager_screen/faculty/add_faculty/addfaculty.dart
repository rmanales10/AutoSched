import 'package:autosched/screens/setup_manager_screen/faculty/add_faculty/addfaculty_controller.dart';
import 'package:autosched/screens/teaching_load_screen/teaching_load_list/teaching_load.dart';
import 'package:autosched/widgets/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddFacultyScreen extends StatefulWidget {
  const AddFacultyScreen({super.key});

  @override
  _AddFacultyScreenState createState() => _AddFacultyScreenState();
}

class _AddFacultyScreenState extends State<AddFacultyScreen> {
  String? selectedConstraint;
  String? selectedPosition;
  String? selectedStatus;
  String? selectedDepartment;
  String? selectedDesignation;
  String? selectedRole;
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _controller = Get.put(AddFacultyController());

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double inputFontSize = screenWidth < 600 ? 14 : 23;
    double textFieldWidth = screenWidth > 1200 ? 350 : screenWidth * 0.3;

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
                          "Add Faculty",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 70),
                        _buildProfileForm(inputFontSize, textFieldWidth),
                        const SizedBox(height: 100), // Space before buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            _buildButton(
                              "Save",
                              const Color.fromARGB(255, 1, 0, 66),
                              Colors.white,
                              onTap: () => _showConfirmationDialog(context),
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

  Widget _buildRadioGroup(double fontSize, double width) {
    return SizedBox(
      width: width,
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Column(
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
            Column(
              children: [
                _buildRadioWithLabel("5PM Onwards Only", fontSize),
                _buildRadioWithLabel("Saturday Only", fontSize),
                _buildRadioWithLabel("8AM-5PM Only", fontSize),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRadioWithLabel(String label, double fontSize) {
    return Row(
      children: [
        Radio<String>(
          value: label,
          groupValue: selectedConstraint,
          onChanged: (String? value) {
            setState(() {
              selectedConstraint = value;
            });
          },
          activeColor: Colors.green,
        ),
        SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(fontSize: fontSize * 0.8, color: Colors.grey[600]),
        ),
      ],
    );
  }

  Widget _buildProfileForm(double fontSize, double width) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 20,
          runSpacing: 30,
          children: [
            _buildTextField(
              "First Name",
              "Input First Name",
              fontSize,
              width,
              _firstNameController,
            ),
            _buildTextField(
              "Last Name",
              "Input Last Name",
              fontSize,
              width,
              _lastNameController,
            ),
            _buildTextField(
              "Email",
              "Input email",
              fontSize,
              width,
              _emailController,
            ),
            _buildTextField(
              "Mobile Number",
              "+639...",
              fontSize,
              width,
              _phoneController,
            ),
            _buildDropdownField(
              "Position",
              fontSize,
              width,
              ['TEACHER', 'ADMIN', 'SCHEDULER'],
              selectedPosition,
              (value) => setState(() => selectedPosition = value),
            ),
            _buildDropdownField(
              "Status",
              fontSize,
              width,
              ['TEACHER', 'ADMIN', 'SCHEDULER'],
              selectedStatus,
              (value) => setState(() => selectedStatus = value),
            ),
            _buildDropdownField(
              "Department",
              fontSize,
              width,
              ['TEACHER', 'ADMIN', 'SCHEDULER'],
              selectedDepartment,
              (value) => setState(() => selectedDepartment = value),
            ),
            _buildDropdownField(
              "Designation",
              fontSize,
              width,
              ['TEACHER', 'ADMIN', 'SCHEDULER'],
              selectedDesignation,
              (value) => setState(() => selectedDesignation = value),
            ),
            _buildRadioGroup(fontSize, width),
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

  Widget _buildDropdownField(
    String label,
    double fontSize,
    double width,
    List<String> items,
    String? selectedValue,
    Function(String?) onChanged,
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
                value: selectedValue,
                icon: Icon(
                  Icons.arrow_drop_down_rounded,
                  color: Colors.grey.shade600,
                  size: 24,
                ),
                isExpanded: true,
                items:
                    items.map((item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(
                          item,
                          style: TextStyle(
                            fontSize: fontSize,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      );
                    }).toList(),
                onChanged: onChanged,
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
    TextEditingController? controller,
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
              controller: controller,
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
                  color: Colors.grey.shade400,
                ),
              ),
            ),
          ),
        ],
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
                  "Do you want to save changes?",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => _addFaculty(),
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

  Future<void> _addFaculty() async {
    await _controller.addFaculty(
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      email: _emailController.text,
      mobileNumber: _phoneController.text,
      position: selectedPosition!,
      status: selectedStatus!,
      department: selectedDepartment!,
      designation: selectedDesignation!,
      constraints: selectedConstraint!,
    );
    if (_controller.isSuccess == true) {
      Get.off(() => TeachingLoadScreen());
    }
  }
}
