import 'package:autosched/screens/setup_manager_screen/faculty/edit_faculty/edit_faculty.dart';
import 'package:autosched/screens/setup_manager_screen/faculty/edit_faculty/edit_faculty_controller.dart';
import 'package:autosched/widgets/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewfacultyScreen extends StatefulWidget {
  final int id;

  const ViewfacultyScreen({super.key, required this.id});

  @override
  _ViewfacultyScreenState createState() => _ViewfacultyScreenState();
}

class _ViewfacultyScreenState extends State<ViewfacultyScreen> {
  String? selectedPosition;
  String? selectedStatus;
  String? selectedDepartment;
  String? selectedDesignation;
  String? selectedConstraint;
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _controller = Get.put(EditFacultyController());
  List<bool> constraints = [false, false, false];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    await _controller.fetchFacultyData(id: widget.id);
    final data = _controller.facultyData[0];
    setState(() {
      selectedPosition = data['position'];
      selectedStatus = data['status'];
      selectedDepartment = data['department'];
      selectedDesignation = data['designation'];
      selectedConstraint = data['constraints'];
      _firstNameController.text = data['first_name'];
      _lastNameController.text = data['last_name'];
      _emailController.text = data['email'];
      _phoneController.text = data['mobile_number'];
    });
  }

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
                                  () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) =>
                                              EditFacultyScreen(id: widget.id),
                                    ),
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
              selectedPosition ?? 'Choose Position',
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
              selectedStatus ?? "Choose Status",
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
              selectedDepartment ?? "Choose Department",
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
                    selectedDesignation ?? "Choose Designation",
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
                Expanded(flex: 2, child: _buildRadioGroup(fontSize, width)),
              ],
            ),
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
              color:
                  Colors
                      .grey[200], // Light grey background to indicate it's disabled
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
                    color: Colors.grey.shade600,
                  ),
                ),
                value: null,
                onChanged: null, // This disables the dropdown
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
                icon: Icon(
                  Icons.arrow_drop_down_rounded,
                  color: Colors.grey.shade400,
                  size: 24,
                ),
                disabledHint: Text(
                  hint,
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade600,
                  ),
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
              enabled: false,
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
                  color: Colors.black,
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
              mainAxisSize: MainAxisSize.min,
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
                      onTap: () {
                        Navigator.of(context).pop();
                        // Add logic to save faculty data here
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
                color:
                    Colors
                        .grey[600], // Changed to grey to indicate disabled state
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
          onChanged: null, // Set to null to disable the radio button
          activeColor:
              Colors.grey[400], // Change color to indicate disabled state
        ),
        SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: fontSize * 0.8,
            color: Colors.grey[400], // Change color to indicate disabled state
          ),
        ),
      ],
    );
  }
}
