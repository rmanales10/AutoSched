import 'package:autosched/screens/teaching_load_screen/assign_faculty_load/faculty_load_controller.dart';
import 'package:autosched/widgets/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AssignFacultyLoadScreen extends StatefulWidget {
  final String id;
  const AssignFacultyLoadScreen({super.key, required this.id});

  @override
  _AssignFacultyLoadScreenState createState() =>
      _AssignFacultyLoadScreenState();
}

class _AssignFacultyLoadScreenState extends State<AssignFacultyLoadScreen> {
  final _controller = Get.put(FacultyLoadController());
  String selectedItem = "Teaching Load";

  Map<int, String> selectedFaculty = {};
  Map<int, String> selectedSection = {};

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    _controller.fetchLoad();
    _controller.fetchFaculty();
    _controller.fetchFacultyLoad(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: Row(
        children: [
          Sidebar(
            selectedItem: selectedItem,
            onItemSelected: (title, route) {
              setState(() {
                selectedItem = title;
              });
              Navigator.pushNamed(context, route);
            },
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(
                top: 50,
                left: 60,
                right: 60,
                bottom: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      'ASSIGN FACULTY LOAD',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildHeaderRow(),
                  const SizedBox(height: 5),
                  _buildTableContent(),
                  const SizedBox(height: 20),
                  _buildBottomSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderRow() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Obx(
        () => Row(
          children: [
            Expanded(
              flex: 2,
              child: _rowText(
                _controller.loadData.isNotEmpty
                    ? _controller.loadData[0][0]
                    : '',
                true,
              ),
            ),
            Expanded(
              flex: 3,
              child: _rowText(
                _controller.loadData.isNotEmpty
                    ? _controller.loadData[0][1]
                    : '',
                true,
              ),
            ),
            Expanded(
              flex: 1,
              child: _rowText(
                _controller.loadData.isNotEmpty
                    ? _controller.loadData[0][2]
                    : '',
                true,
              ),
            ),
            Expanded(
              flex: 1,
              child: _rowText(
                _controller.loadData.isNotEmpty
                    ? _controller.loadData[0][3]
                    : '',
                true,
              ),
            ),
            Expanded(
              flex: 1,
              child: _rowText(
                _controller.loadData.isNotEmpty
                    ? _controller.loadData[0][4]
                    : '',
                true,
              ),
            ),
            Expanded(
              flex: 2,
              child: _rowText(
                _controller.loadData.isNotEmpty
                    ? _controller.loadData[0][5]
                    : '',
                true,
              ),
            ),
            const SizedBox(width: 30),
            Expanded(
              flex: 2,
              child: _rowText(
                _controller.loadData.isNotEmpty
                    ? _controller.loadData[0][6]
                    : '',
                true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTableContent() {
    return Expanded(
      child: SingleChildScrollView(
        child: Obx(() {
          if (_controller.loadData.isEmpty || _controller.loadData.length < 2) {
            return Center(child: Text('No data available'));
          }
          return Column(
            children: List.generate(
              _controller.loadData.length - 1,
              (index) => _buildRow(_controller.loadData[index + 1], index + 1),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildRow(List<String> values, int index) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      decoration: BoxDecoration(
        color: index % 2 == 0 ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Expanded(flex: 2, child: _rowText(values[0], false)),
          Expanded(flex: 3, child: _rowText(values[1], false)),
          Expanded(flex: 1, child: _rowText(values[2], false)),
          Expanded(flex: 1, child: _rowText(values[3], false)),
          Expanded(flex: 1, child: _rowText(values[4], false)),
          Expanded(flex: 2, child: _facultyDropdown(index)),
          const SizedBox(width: 30),
          Expanded(flex: 2, child: _sectionDropdown(index)),
        ],
      ),
    );
  }

  Widget _rowText(String text, bool isHeader) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
        fontSize: 18,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _facultyDropdown(int index) {
    return Obx(() {
      List<String> items =
          _controller.facultyList.isNotEmpty
              ? _controller.facultyList
              : ['No faculty available'];

      String? initialFaculty;
      if (_controller.loadData.isNotEmpty &&
          _controller.loadData.length > index) {
        String subjectId = _controller.loadId[index - 1][0];
        var facultyLoadEntry = _controller.facultyLoadData.firstWhere(
          (entry) => entry['subject_id'] == subjectId,
          orElse: () => <String, dynamic>{},
        );
        initialFaculty = facultyLoadEntry['faculty'];
      }

      String? displayValue =
          initialFaculty?.isNotEmpty == true
              ? initialFaculty
              : selectedFaculty[index];

      return _dropdownWidget(
        index: index,
        hint: "Choose Faculty",
        value: displayValue,
        items: items,
        onChanged: (newValue) {
          setState(() {
            selectedFaculty[index] = newValue!;
          });
        },
      );
    });
  }

  Widget _sectionDropdown(int index) {
    return Obx(() {
      List<String> items =
          _controller.sectionList.isNotEmpty
              ? _controller.sectionList
              : ['No sections available'];

      String? initialSection;
      if (_controller.loadData.isNotEmpty &&
          _controller.loadData.length > index) {
        String subjectId = _controller.loadId[index - 1][0];
        var facultyLoadEntry = _controller.facultyLoadData.firstWhere(
          (entry) => entry['subject_id'] == subjectId,
          orElse: () => <String, dynamic>{},
        );
        initialSection = facultyLoadEntry['section'];
      }

      String? displayValue =
          initialSection?.isNotEmpty == true
              ? initialSection
              : selectedSection[index];

      return _dropdownWidget(
        index: index,
        hint: "Choose Section",
        value: displayValue,
        items: items,
        onChanged: (newValue) {
          setState(() {
            selectedSection[index] = newValue!;
          });
        },
      );
    });
  }

  Widget _dropdownWidget({
    required int index,
    required String hint,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    if (value != null && !items.contains(value)) {
      value = null;
    }

    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(width: 1, color: Colors.grey.shade300),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          hint: Text(
            hint,
            style: TextStyle(fontSize: 16, color: Colors.grey.shade400),
          ),
          onChanged: onChanged,
          items:
              items.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                  ),
                );
              }).toList(),
        ),
      ),
    );
  }

  Widget _buildBottomSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [_buildTotalRow(), _buildActionButtons()],
    );
  }

  Widget _buildTotalRow() {
    return Container(
      width: 550,
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Obx(() {
            double totalLec = 0.0;
            double totalLab = 0.0;
            double totalCredit = 0.0;

            if (_controller.loadData.isNotEmpty &&
                _controller.loadData.length > 1) {
              for (int i = 1; i < _controller.loadData.length; i++) {
                totalLec += double.tryParse(_controller.loadData[i][2]) ?? 0.0;
                totalLab += double.tryParse(_controller.loadData[i][3]) ?? 0.0;
                totalCredit +=
                    double.tryParse(_controller.loadData[i][4]) ?? 0.0;
              }
            }

            return Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 70),
                  child: _rowText("Total Units:", true),
                ),
                SizedBox(width: 20),
                _rowText(totalLec.toStringAsFixed(1), true),
                SizedBox(width: 20),
                _rowText(totalLab.toStringAsFixed(1), true),
                SizedBox(width: 20),
                Padding(
                  padding: const EdgeInsets.only(right: 40),
                  child: _rowText(totalCredit.toStringAsFixed(1), true),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        _buildButton("Save", const Color(0xFF010042), Colors.white, () {
          _showConfirmationDialog(context);
        }),
        const SizedBox(width: 20),
        _buildButton(
          "Reset",
          Colors.white,
          const Color(0xFF010042),
          () {},
          borderColor: Colors.grey.shade400,
        ),
      ],
    );
  }

  Widget _buildButton(
    String text,
    Color bgColor,
    Color textColor,
    VoidCallback onPressed, {
    Color? borderColor,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 180,
        height: 45,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(30),
          border:
              borderColor != null
                  ? Border.all(color: borderColor, width: 1)
                  : null,
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 23,
              fontWeight: FontWeight.bold,
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
                  "Do you want to submit teaching load?",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        Navigator.of(context).pop();
                        await _updateFacultyLoad();
                        // You might want to show a success message or refresh the data here
                        _controller.fetchLoad(); // Refresh the data
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

  Future<void> _updateFacultyLoad() async {
    for (int i = 0; i < _controller.loadId.length; i++) {
      String loadId = _controller.loadId[i][0];
      String? faculty = selectedFaculty[i + 1];
      String? section = selectedSection[i + 1];

      if (faculty != null && section != null) {
        await _controller.updateFacultyLoad(loadId, faculty, section);
      }
    }
  }
}
