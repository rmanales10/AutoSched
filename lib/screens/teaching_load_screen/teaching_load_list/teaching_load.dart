import 'package:autosched/screens/teaching_load_screen/assign_faculty_load/assign_faculty_load.dart';
import 'package:autosched/screens/teaching_load_screen/teaching_load_list/view_load_controller.dart';
import 'package:autosched/widgets/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TeachingLoadScreen extends StatefulWidget {
  const TeachingLoadScreen({super.key});

  @override
  _TeachingLoadScreenState createState() => _TeachingLoadScreenState();
}

class _TeachingLoadScreenState extends State<TeachingLoadScreen> {
  final _controller = Get.put(ViewLoadController());
  final Set<String> _selectedItems = {};
  String selectedItem = "Teaching Load";
  bool _deleteMode = false;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    _controller.fetchTeachingLoads();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: Obx(() {
              if (_controller.errorMessage.isNotEmpty) {
                return Center(child: Text(_controller.errorMessage));
              }
              return Container(
                color: const Color(0xFFF9F9F9),
                padding: const EdgeInsets.all(40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    _buildHeader(context),
                    const SizedBox(height: 50),
                    _buildTeachingLoadList(),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Text(
            'TEACHING LOAD LIST',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          Spacer(),
          IconButton(
            icon: const Icon(
              Icons.note_add_rounded,
              color: Color.fromARGB(255, 1, 0, 66),
              size: 50,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/create_teaching-load');
            },
          ),
          IconButton(
            icon: Icon(
              _deleteMode ? Icons.close : Icons.delete,
              color: Color.fromARGB(255, 243, 20, 4),
              size: 50,
            ),
            onPressed: () {
              setState(() {
                _deleteMode = !_deleteMode;
                if (!_deleteMode) {
                  _selectedItems.clear();
                }
              });
            },
          ),
          if (_deleteMode)
            IconButton(
              onPressed: () async {
                _showConfirmationDialog(context);
              },
              icon: Icon(Icons.check, color: Colors.white),
              style: IconButton.styleFrom(backgroundColor: Colors.green),
            ),
        ],
      ),
    );
  }

  Widget _buildTeachingLoadList() {
    List<List<String>> teachingLoadData = [
      ["ID", "TEACHING LOAD", "PROGRAM", "STATUS", "ACTIONS"],
      ..._controller.teachingLoads.map(
        (load) => [
          load['teaching_load_id'].toString(),
          "FINAL-LOAD-2024",
          load['program'],
          load['semester'],
          load['1st_year'].toString(),
          load['2nd_year'].toString(),
          load['3rd_year'].toString(),
          load['4th_year'].toString(),
        ],
      ),
    ];

    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: List.generate(teachingLoadData.length, (index) {
            return _buildRow(
              teachingLoadData[index],
              index,
              showCheckbox: _deleteMode,
            );
          }),
        ),
      ),
    );
  }

  Widget _buildRow(
    List<String> values,
    int index, {
    bool showCheckbox = false,
  }) {
    bool isHeader = index == 0;
    bool isEvenRow = index % 2 == 0;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      decoration: BoxDecoration(
        color: isEvenRow ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          if (showCheckbox && !isHeader)
            Checkbox(
              value: _selectedItems.contains(values[0]),
              onChanged: (bool? value) {
                setState(() {
                  if (value == true) {
                    _selectedItems.add(values[0]);
                  } else {
                    _selectedItems.remove(values[0]);
                  }
                });
              },
            ),
          Expanded(flex: 1, child: _rowText(values[0], isHeader)), // ID
          Expanded(
            flex: 3,
            child: _rowText(values[1], isHeader),
          ), // Teaching Load
          Expanded(flex: 2, child: _rowText(values[2], isHeader)), // Program
          Expanded(flex: 2, child: _rowText(values[3], isHeader)), // Status
          Expanded(
            flex: 2,
            child:
                isHeader
                    ? _rowText(values[4], isHeader)
                    : _actionIcons(values[0]),
          ), // Actions
        ],
      ),
    );
  }

  Widget _rowText(String text, bool isHeader) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
        fontSize: 20,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _actionIcons(String id) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AssignFacultyLoadScreen(id: id),
              ),
            );
          },
          child: Stack(
            children: [
              Icon(Icons.groups, size: 40, color: Colors.green),
              Positioned(
                bottom: 0,
                right: 0,
                child: Icon(Icons.check_circle, size: 18, color: Colors.green),
              ),
            ],
          ),
        ),
        SizedBox(width: 5),
        IconButton(
          icon: Icon(
            Icons.content_paste_search_rounded,
            color: Colors.green,
            size: 40,
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/view-teaching-load');
          },
        ),
        IconButton(
          icon: Icon(Icons.edit, color: Colors.green, size: 40),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.print, color: Colors.green, size: 40),
          onPressed: () {},
        ),
      ],
    );
  }

  void _showConfirmationDialog(BuildContext context) async {
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
                  "Do you want to add changes ?",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        if (_selectedItems.isNotEmpty) {
                          await _controller.deleteMultipleTeachingLoads(
                            _selectedItems.toList(),
                          );
                          setState(() {
                            _selectedItems.clear();
                            _deleteMode = false;
                          });
                          _controller.refreshTeachingLoads();
                        }
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).pop();
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
}
