import 'package:autosched/screens/curriculum_screen/curriculum_list/curriculum_list_controller.dart';
import 'package:autosched/widgets/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CurriculumScreen extends StatefulWidget {
  const CurriculumScreen({super.key});

  @override
  State<CurriculumScreen> createState() => _CurriculumScreenState();
}

class _CurriculumScreenState extends State<CurriculumScreen> {
  final controller = Get.put(CurriculumListController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Sidebar(
            selectedItem: "Curriculum",
            onItemSelected: (title, route) {
              Navigator.pushNamed(context, route);
            },
          ),
          Expanded(
            child: Container(
              color: const Color(0xFFF9F9F9),
              padding: const EdgeInsets.all(40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'CURRICULUM LIST',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.note_add_rounded,
                                color: Color.fromARGB(255, 1, 0, 66),
                                size: 50,
                              ),
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  '/create-curriculum',
                                );
                              },
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: Color.fromARGB(255, 243, 20, 4),
                                size: 50,
                              ),
                              onPressed: () {
                                // Navigator.pushNamed(context, '/');
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50),
                  Expanded(
                    child: Obx(() {
                      if (controller.isLoading.value) {
                        return Center(child: CircularProgressIndicator());
                      } else if (controller.errorMessage.isNotEmpty) {
                        return Center(
                          child: Text(controller.errorMessage.value),
                        );
                      } else {
                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              _buildHeaderRow(),
                              ...controller.curriculums.map(
                                (curriculum) => _buildRow(curriculum),
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

  Widget _buildHeaderRow() {
    return _buildRow({
      'id': 'ID',
      'name': 'CURRICULUM NAME',
      'program': 'PROGRAM',
      'actions': 'ACTIONS',
    }, isHeader: true);
  }

  Widget _buildRow(Map<String, dynamic> values, {bool isHeader = false}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      decoration: BoxDecoration(
        color: isHeader ? Colors.grey[200] : Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Expanded(flex: 1, child: _rowText(values['id'].toString(), isHeader)),
          Expanded(flex: 3, child: _rowText(values['name'], isHeader)),
          Expanded(flex: 2, child: _rowText(values['program'], isHeader)),
          Expanded(
            flex: 2,
            child:
                isHeader
                    ? _rowText(values['actions'], isHeader)
                    : _actionIcons(),
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

  Widget _actionIcons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(
            Icons.content_paste_search_rounded,
            color: Colors.green,
            size: 40,
          ),
          onPressed: () => Get.toNamed('/curriculum-load'),
        ),
        IconButton(
          icon: Icon(Icons.edit, color: Colors.green, size: 40),
          onPressed: () => Get.toNamed('/edit-curriculum'),
        ),
        IconButton(
          icon: Icon(Icons.print, color: Colors.green, size: 40),
          onPressed: () {},
        ),
      ],
    );
  }
}
