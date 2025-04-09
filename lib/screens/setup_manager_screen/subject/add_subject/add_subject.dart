import 'package:autosched/screens/setup_manager_screen/subject/add_subject/add_subject_controller.dart';
import 'package:autosched/screens/setup_manager_screen/subject/subject_list/subjects_list.dart';
import 'package:autosched/widgets/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AddSubjectScreen extends StatefulWidget {
  const AddSubjectScreen({super.key});

  @override
  _AddSubjectScreenState createState() => _AddSubjectScreenState();
}

class _AddSubjectScreenState extends State<AddSubjectScreen> {
  final _controller = Get.put(AddSubjectController());
  final _subjectCodeController = TextEditingController();
  final _descriptiveTitleController = TextEditingController();
  final _labHoursController = TextEditingController();
  final _labUnitController = TextEditingController();
  final _lectHoursController = TextEditingController();
  final _lecUnitController = TextEditingController();
  final _creditController = TextEditingController();
  final subjectArea = ['IT', 'CS', 'Engineering'];
  final yearLevel = ['1st Year', '2nd Year'];
  final program = ['Full-Time', 'Part-Time'];
  final major = ['Computer Science', 'Information Technology', 'Engineering'];
  final mode = ['Online', 'On-site'];
  String? _selectedSubjectArea;
  String? _selectedYearLevel;
  String? _selectedProgram;
  String? _selectedMajor;
  String? _selectedMode;

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
                          "Add Subject",
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
            _buildTextField(
              "Input subject code",
              fontSize,
              width,
              _subjectCodeController,
            ),
            _buildTextField(
              "Lab Units:",
              fontSize,
              width,
              _labUnitController,
              numericOnly: true,
            ),
            _buildTextField("Lab HRS:", fontSize, width, _labHoursController),
            _buildTextField(
              "Input descriptive title",
              fontSize,
              width,
              _descriptiveTitleController,
            ),
            _buildTextField(
              "Lec Units:",
              fontSize,
              width,
              _lecUnitController,
              numericOnly: true,
            ),
            _buildTextField("Lec HRS:", fontSize, width, _lectHoursController),
            _buildTextField(
              "Input credit units",
              fontSize,
              width,
              _creditController,
              numericOnly: true,
            ),
            _buildDropdownField(
              subjectArea,
              'Subject Area',
              fontSize,
              width,
              _selectedSubjectArea,
            ),
            _buildDropdownField(
              yearLevel,
              'Year Level',
              fontSize,
              width,
              _selectedYearLevel,
            ),
            _buildDropdownField(
              program,
              'Program',
              fontSize,
              width,
              _selectedProgram,
            ),
            _buildDropdownField(
              major,
              'Major',
              fontSize,
              width,
              _selectedMajor,
            ),
            _buildDropdownField(mode, 'Mode', fontSize, width, _selectedMode),
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

  Widget _buildTextField(
    String hint,
    double fontSize,
    double width,
    TextEditingController? controller, {
    bool numericOnly = false, // Add this parameter
  }) {
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
          inputFormatters:
              numericOnly ? [FilteringTextInputFormatter.digitsOnly] : null,
          controller: controller,
          cursorColor: Colors.grey[600],
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

  Widget _buildDropdownField(
    List<String> items,
    String hint,
    double fontSize,
    double width,
    String? selectedValue,
  ) {
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
            padding: EdgeInsets.only(left: 5),
            borderRadius: BorderRadius.circular(30),
            value: selectedValue,
            icon: Icon(
              Icons.arrow_drop_down_rounded,
              color: Colors.grey.shade600,
              size: 24,
            ),
            hint: Text(
              hint,
              style: TextStyle(fontSize: fontSize, color: Colors.grey.shade600),
            ),
            items:
                items.map((item) {
                  return DropdownMenuItem(
                    value: item,
                    child: Text(
                      item,
                      style: TextStyle(
                        fontSize: fontSize,
                        color: Colors.grey.shade800,
                      ),
                    ),
                  );
                }).toList(),
            onChanged: (value) {
              setState(() {
                switch (hint) {
                  case 'Subject Area':
                    _selectedSubjectArea = value;
                    break;
                  case 'Year Level':
                    _selectedYearLevel = value;
                    break;
                  case 'Program':
                    _selectedProgram = value;
                    break;
                  case 'Major':
                    _selectedMajor = value;
                    break;
                  case 'Mode':
                    _selectedMode = value;
                    break;
                }
              });
            },
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
                      onTap: () => addSubject(),
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
                      onTap: () => Navigator.of(context).pop(),
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

  Future<void> addSubject() async {
    if (_subjectCodeController.text.isEmpty ||
        _descriptiveTitleController.text.isEmpty ||
        _lecUnitController.text.isEmpty ||
        _lectHoursController.text.isEmpty ||
        _labUnitController.text.isEmpty ||
        _labHoursController.text.isEmpty ||
        _creditController.text.isEmpty ||
        _selectedSubjectArea == null ||
        _selectedProgram == null ||
        _selectedMajor == null ||
        _selectedMode == null) {
      Get.snackbar('Error', 'Please fill in all fields');
      return;
    }

    try {
      await _controller.addSubject(
        subjectCode: _subjectCodeController.text,
        descriptiveTitle: _descriptiveTitleController.text,
        lec: int.parse(_lecUnitController.text),
        lecHrs: _lectHoursController.text,
        lab: int.parse(_labUnitController.text),
        labHrs: _labHoursController.text,
        credit: int.parse(_creditController.text),
        subjectArea: _selectedSubjectArea!,
        yearLevel: _selectedYearLevel!,
        program: _selectedProgram!,
        major: _selectedMajor!,
        mode: _selectedMode!,
      );

      Get.snackbar('Success', 'Subject added successfully');

      _subjectCodeController.clear();
      _descriptiveTitleController.clear();
      _lecUnitController.clear();
      _lectHoursController.clear();
      _labUnitController.clear();
      _labHoursController.clear();
      _creditController.clear();
      setState(() {
        _selectedSubjectArea = null;
        _selectedProgram = null;
        _selectedMajor = null;
        _selectedMode = null;
      });
      Get.off(
        () => SubjectsListScreen(
          selectedItem: 'Subjects',
          onItemSelected: (String title, String route) {
            Navigator.pushNamed(context, route);
          },
        ),
      );
    } catch (e) {
      Get.snackbar('Error', 'Failed to add subject: $e');
    }
  }
}
