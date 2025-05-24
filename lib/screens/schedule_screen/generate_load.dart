import 'package:autosched/widgets/sidebar.dart';
import 'package:flutter/material.dart';

class GenerateLoadScreen extends StatefulWidget {
  const GenerateLoadScreen({super.key});

  @override
  State<GenerateLoadScreen> createState() => _GenerateLoadScreenState();
}

class _GenerateLoadScreenState extends State<GenerateLoadScreen> {
  String selectedSemester = 'First Semester';
  String selectedAcademicYear = '2023-2024';
  bool includePreferences = true;
  bool optimizeConflicts = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: Row(
        children: [
          Sidebar(
            selectedItem: 'Schedule',
            onItemSelected: (title, route) {
              Navigator.pushNamed(context, route);
            },
          ),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 200,
                  vertical: 100,
                ),
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 1, color: Colors.grey.shade400),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 30,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Generate Schedule',
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 40),
                      _buildSection('Schedule Parameters', [
                        _buildDropdown(
                          'Semester',
                          selectedSemester,
                          ['First Semester', 'Second Semester', 'Summer'],
                          (value) {
                            setState(() {
                              selectedSemester = value!;
                            });
                          },
                        ),
                        const SizedBox(height: 20),
                        _buildDropdown(
                          'Academic Year',
                          selectedAcademicYear,
                          ['2023-2024', '2024-2025', '2025-2026'],
                          (value) {
                            setState(() {
                              selectedAcademicYear = value!;
                            });
                          },
                        ),
                      ]),
                      const SizedBox(height: 30),
                      _buildSection('Generation Options', [
                        _buildSwitch(
                          'Include Faculty Preferences',
                          includePreferences,
                          (value) {
                            setState(() {
                              includePreferences = value;
                            });
                          },
                        ),
                        const SizedBox(height: 15),
                        _buildSwitch(
                          'Optimize for Conflicts',
                          optimizeConflicts,
                          (value) {
                            setState(() {
                              optimizeConflicts = value;
                            });
                          },
                        ),
                      ]),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          _buildButton(
                            "Generate",
                            const Color(0xFF010042),
                            Colors.white,
                            () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => const GeneratedLoadScreen(),
                                ),
                              );
                            },
                          ),
                          const SizedBox(width: 20),
                          _buildButton(
                            "Cancel",
                            Color.fromARGB(255, 243, 20, 4),
                            Colors.white,
                            () {
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
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF010042),
          ),
        ),
        const SizedBox(height: 20),
        ...children,
      ],
    );
  }

  Widget _buildDropdown(
    String label,
    String value,
    List<String> items,
    Function(String?) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              items:
                  items.map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSwitch(String label, bool value, Function(bool) onChanged) {
    return Row(
      children: [
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: const Color(0xFF010042),
        ),
        const SizedBox(width: 10),
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}

class GeneratedLoadScreen extends StatelessWidget {
  const GeneratedLoadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: Row(
        children: [
          Sidebar(
            selectedItem: 'Schedule',
            onItemSelected: (title, route) {
              Navigator.pushNamed(context, route);
            },
          ),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 200,
                  vertical: 100,
                ),
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 1, color: Colors.grey.shade400),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 30,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Generated Schedule',
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          _buildButton(
                            "Accept",
                            const Color(0xFF010042),
                            Colors.white,
                            () {},
                          ),
                          const SizedBox(width: 20),
                          _buildButton(
                            "Regenerate",
                            Colors.white,
                            const Color(0xFF010042),
                            () {},
                            borderColor: const Color(0xFF010042),
                          ),
                          const Spacer(),
                          _buildButton(
                            "Cancel",
                            Color.fromARGB(255, 243, 20, 4),
                            Colors.white,
                            () {
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
        ],
      ),
    );
  }
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
