import 'package:autosched/screens/setup_manager_screen/subject/edit_subject/edit_subject_controller.dart';
import 'package:autosched/widgets/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditSubjectScreen extends StatefulWidget {
  final String id;
  const EditSubjectScreen({super.key, required this.id});

  @override
  _EditSubjectScreenState createState() => _EditSubjectScreenState();
}

class _EditSubjectScreenState extends State<EditSubjectScreen> {
  final _controller = Get.put(EditSubjectController());
  String? selectedSubjectArea;
  String? selectedGradeLevel;
  String? selectedMajor;
  String? selectedMode;
  String? selectedProgram;
  final _subjectCodeController = TextEditingController();
  final _descriptiveTitleController = TextEditingController();
  final _labHoursController = TextEditingController();
  final _labUnitController = TextEditingController();
  final _lectHoursController = TextEditingController();
  final _lecUnitController = TextEditingController();
  final _creditController = TextEditingController();
  final subjectArea = ['IT', 'CS', 'Engineering'];
  final yearLevel = ['1st Year', '2nd Year', '3rd Year', '4th Year'];
  final program = ['Full-Time', 'Part-Time'];
  final major = ['Computer Science', 'Information Technology', 'Engineering'];
  final mode = ['Online', 'On-site'];

  @override
  void initState() {
    super.initState();
    fetchSubjects();
  }

  Future<void> fetchSubjects() async {
    await _controller.fetchSubject(widget.id);
    final data = _controller.subjects[0];
    setState(() {
      _subjectCodeController.text = data['subject_code'];
      _descriptiveTitleController.text = data['descriptive_title'];
      _labHoursController.text = data['lab_hrs'];
      _labUnitController.text = data['lab'].toString();
      _lectHoursController.text = data['lec_hrs'];
      _lecUnitController.text = data['lec'].toString();
      _creditController.text = data['credit'].toString();
      selectedSubjectArea = data['subject_area'];
      selectedGradeLevel = data['year_level'];
      selectedMajor = data['major'];
      selectedMode = data['mode'];
      selectedProgram = data['program'];
    });
  }

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
                          "Edit Subject",
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
            _buildTextField("Lab Units", fontSize, width, _labUnitController),
            _buildTextField("Lab HRS", fontSize, width, _labHoursController),
            _buildTextField(
              "Input descriptive title",
              fontSize,
              width,
              _descriptiveTitleController,
            ),
            _buildTextField("Lec Units", fontSize, width, _lecUnitController),
            _buildTextField("Lec HRS", fontSize, width, _lectHoursController),
            _buildTextField(
              "Input credit units",
              fontSize,
              width,
              _creditController,
            ),
            _buildDropdownField(
              subjectArea,
              'Subject Area',
              fontSize,
              width,
              selectedSubjectArea,
              (value) {
                setState(() {
                  selectedSubjectArea = value;
                });
              },
            ),
            _buildDropdownField(
              yearLevel,
              'Year Level',
              fontSize,
              width,
              selectedGradeLevel,
              (value) {
                setState(() {
                  selectedGradeLevel = value;
                });
              },
            ),
            _buildDropdownField(
              program,
              'Program',
              fontSize,
              width,
              selectedProgram,
              (value) {
                setState(() {
                  selectedProgram = value;
                });
              },
            ),
            _buildDropdownField(
              major,
              'Major',
              fontSize,
              width,
              selectedMajor,
              (value) {
                setState(() {
                  selectedMajor = value;
                });
              },
            ),
            _buildDropdownField(mode, 'Mode', fontSize, width, selectedMode, (
              value,
            ) {
              setState(() {
                selectedMode = value;
              });
            }),
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
    String? selectedValue,
    ValueChanged<String?> onChanged,
  ) {
    // Check if selectedValue exists in the items list
    bool valueExists = selectedValue != null && items.contains(selectedValue);

    // Use null if the value doesn't exist in the list
    String? safeValue = valueExists ? selectedValue : null;

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
            value: safeValue,
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
                      style: TextStyle(fontSize: fontSize, color: Colors.black),
                    ),
                  );
                }).toList(),
            onChanged: onChanged,
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
                  "Do you want to save changes?",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => _saveChanges(),
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

  Future<void> _saveChanges() async {
    _controller
        .editSubject(
          id: widget.id,
          subjectCode: _subjectCodeController.text,
          descriptiveTitle: _descriptiveTitleController.text,
          labHours: _labHoursController.text,
          labUnit: _labUnitController.text,
          lectHours: _lectHoursController.text,
          lecUnit: _lecUnitController.text,
          credit: _creditController.text,
          subjectArea: selectedSubjectArea,
          gradeLevel: selectedGradeLevel,
          major: selectedMajor,
          mode: selectedMode,
          program: selectedProgram,
        )
        // ignore: use_build_context_synchronously
        .then((_) => Navigator.pushNamed(context, '/setup-manager/subjects'));
  }
}
