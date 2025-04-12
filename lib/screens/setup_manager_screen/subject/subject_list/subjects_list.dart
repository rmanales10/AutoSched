import 'package:autosched/screens/setup_manager_screen/subject/subject_list/subject_list_controller.dart';
import 'package:autosched/widgets/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubjectsListScreen extends GetView<SubjectListController> {
  final String selectedItem;
  final Function(String, String) onItemSelected;

  SubjectsListScreen({
    super.key,
    required this.selectedItem,
    required this.onItemSelected,
  }) {
    Get.put(SubjectListController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Sidebar(selectedItem: selectedItem, onItemSelected: onItemSelected),
          Expanded(
            child: Container(
              color: const Color(0xFFF9F9F9),
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Section
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 30,
                      bottom: 10,
                      left: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'SUBJECTS LIST',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.print,
                                color: Colors.green,
                                size: 50,
                              ),
                              onPressed: () {
                                // Print Action
                              },
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.note_add_rounded,
                                color: Color.fromARGB(255, 1, 0, 66),
                                size: 50,
                              ),
                              onPressed: () {
                                Get.toNamed('/addsubject');
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),

                  Expanded(
                    child: Obx(() {
                      if (controller.isLoading.value) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (controller.errorMessage.isNotEmpty) {
                        return Center(
                          child: Text(controller.errorMessage.value),
                        );
                      } else {
                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              _buildHeaderRow(),
                              ...controller.subjects.map(
                                (subject) => _buildRow(subject),
                              ),
                            ],
                          ),
                        );
                      }
                    }),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ... rest of the code remains the same ...
}

Widget _buildHeaderRow() {
  return _buildRow({
    'id': 'ID',
    'subject_code': 'SUBJECT CODE',
    'descriptive_title': 'DESCRIPTIVE TITLE',
    'lec': 'LEC',
    'lab': 'LAB',
    'credit': 'CREDIT',
    'actions': 'ACTIONS',
  }, isHeader: true);
}

Widget _buildRow(Map<String, dynamic> subject, {bool isHeader = false}) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
    decoration: BoxDecoration(
      color:
          isHeader
              ? Colors.white
              : (subject['id'].hashCode % 2 == 0
                  ? Colors.white
                  : Colors.transparent),
      borderRadius: BorderRadius.circular(30),
    ),
    child: Row(
      children: [
        Expanded(flex: 1, child: _rowText(subject['id'].toString(), isHeader)),
        Expanded(
          flex: 2,
          child: _rowText(subject['subject_code'].toString(), isHeader),
        ),
        Expanded(
          flex: 4,
          child: _rowText(subject['descriptive_title'], isHeader),
        ),
        Expanded(flex: 1, child: _rowText(subject['lec'].toString(), isHeader)),
        Expanded(flex: 1, child: _rowText(subject['lab'].toString(), isHeader)),
        Expanded(
          flex: 1,
          child: _rowText(subject['credit'].toString(), isHeader),
        ),
        Expanded(
          flex: 2,
          child:
              isHeader
                  ? _rowText('ACTIONS', isHeader)
                  : _actionIcons(subject['id'].toString()),
        ),
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

Widget _actionIcons(String subjectId) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      IconButton(
        icon: const Icon(
          Icons.content_paste_search_rounded,
          color: Colors.green,
          size: 40,
        ),
        onPressed: () {
          Get.toNamed('/viewsubject', arguments: subjectId);
        },
      ),
      IconButton(
        icon: const Icon(Icons.edit, color: Colors.green, size: 40),
        onPressed: () {
          Get.toNamed('/editsubject', arguments: subjectId);
        },
      ),
      IconButton(
        icon: const Icon(
          Icons.delete,
          color: Color.fromARGB(255, 243, 20, 4),
          size: 50,
        ),
        onPressed: () {
          // Delete Action
        },
      ),
    ],
  );
}
