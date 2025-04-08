import 'package:autosched/screens/setup_manager_screen/campus/add_campus/add_campus_controller.dart';
import 'package:autosched/widgets/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddCampusScreen extends StatefulWidget {
  const AddCampusScreen({super.key});

  @override
  _AddCampusScreenState createState() => _AddCampusScreenState();
}

class _AddCampusScreenState extends State<AddCampusScreen> {
  final _controller = Get.put(AddCampusController());
  final _campusNameController = TextEditingController();
  final _addressController = TextEditingController();
  String? selectedCampusType;

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
                          "Add Campus", // Changed from "Add Rooms" to "Add Campus"
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 50),
                        _buildCampusForm(inputFontSize, textFieldWidth),
                        const SizedBox(height: 70),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
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

  Widget _buildCampusForm(double fontSize, double width) {
    return Column(
      children: [
        Wrap(
          spacing: 50,
          runSpacing: 30,
          children: [
            _buildTextField(
              "Campus Name",
              fontSize,
              width,
              _campusNameController,
            ),
            _buildCampusTypeDropdown(fontSize, width),
            _buildTextField("Address", fontSize, width, _addressController),
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

  Widget _buildCampusTypeDropdown(double fontSize, double width) {
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
              "Campus Type", // Changed from "Room Type" to "Campus Type"
              style: TextStyle(fontSize: fontSize, color: Colors.grey.shade600),
            ),
            value: selectedCampusType,
            icon: Icon(
              Icons.arrow_drop_down_rounded,
              color: Colors.grey.shade600,
              size: 24,
            ),
            items:
                ['Main Campus', 'Satellite Campus', 'Extension Campus']
                    .map(
                      (type) => DropdownMenuItem(
                        value: type,
                        child: Text(
                          type,
                          style: TextStyle(
                            fontSize: fontSize,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                    )
                    .toList(),
            onChanged: (value) {
              setState(() {
                selectedCampusType = value;
              });
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String hint,
    double fontSize,
    double width,
    TextEditingController? controller,
  ) {
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
          controller: controller,
          cursorColor: Colors.grey.shade600,
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
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Do you want to add changes?",
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
                        _saveCampusData();
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

  Future<void> _saveCampusData() async {
    if (_campusNameController.text.isEmpty ||
        _addressController.text.isEmpty ||
        selectedCampusType == null) {
      Get.snackbar('Error', 'Please fill all required fields.');
      return;
    }
    await _controller.addCampus(
      campusName: _campusNameController.text,
      campusType: selectedCampusType!,
      address: _addressController.text,
    );
    if (_controller.isSuccess) {
      _campusNameController.clear();
      _addressController.clear();
    } else {
      Get.snackbar('Failed', _controller.errorMessage);
    }
  }
}
