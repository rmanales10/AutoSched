import 'package:autosched/screens/setup_manager_screen/subject/edit_subject/edit_subject.dart';
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
  final _controller = Get.put(SubjectListController());

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
                              _buildHeaderRow(context),
                              ...controller.subjects.map(
                                (subject) => _buildRow(context, subject),
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

  Widget _buildHeaderRow(BuildContext context) {
    return _buildRow(context, {
      'id': 'ID',
      'subject_code': 'SUBJECT CODE',
      'descriptive_title': 'DESCRIPTIVE TITLE',
      'lec': 'LEC',
      'lab': 'LAB',
      'credit': 'CREDIT',
      'actions': 'ACTIONS',
    }, isHeader: true);
  }

  Widget _buildRow(
    BuildContext context,
    Map<String, dynamic> subject, {
    bool isHeader = false,
  }) {
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
          Expanded(
            flex: 1,
            child: _rowText(subject['id'].toString(), isHeader),
          ),
          Expanded(
            flex: 2,
            child: _rowText(subject['subject_code'].toString(), isHeader),
          ),
          Expanded(
            flex: 4,
            child: _rowText(subject['descriptive_title'], isHeader),
          ),
          Expanded(
            flex: 1,
            child: _rowText(subject['lec'].toString(), isHeader),
          ),
          Expanded(
            flex: 1,
            child: _rowText(subject['lab'].toString(), isHeader),
          ),
          Expanded(
            flex: 1,
            child: _rowText(subject['credit'].toString(), isHeader),
          ),
          Expanded(
            flex: 2,
            child:
                isHeader
                    ? _rowText('ACTIONS', isHeader)
                    : _actionIcons(context, subject['id'].toString()),
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

  Widget _actionIcons(BuildContext context, String subjectId) {
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
          onPressed:
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditSubjectScreen(id: subjectId),
                ),
              ),
        ),
        IconButton(
          icon: const Icon(
            Icons.delete,
            color: Color.fromARGB(255, 243, 20, 4),
            size: 50,
          ),
          onPressed: () => _showConfirmationDialog(context, subjectId),
        ),
      ],
    );
  }

  void _showConfirmationDialog(BuildContext context, String id) async {
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
                        await _controller.deleteSubject(id: id);
                        await _controller.fetchSubjects();
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
