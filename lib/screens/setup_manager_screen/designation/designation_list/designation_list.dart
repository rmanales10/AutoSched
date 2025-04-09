import 'package:autosched/screens/setup_manager_screen/designation/designation_list/designation_list_controller.dart';
import 'package:autosched/screens/setup_manager_screen/designation/editdesignation.dart';
import 'package:autosched/widgets/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DesignationListScreen extends StatefulWidget {
  final String selectedItem;
  final Function(String, String) onItemSelected;

  const DesignationListScreen({
    super.key,
    required this.selectedItem,
    required this.onItemSelected,
  });

  @override
  _DesignationListScreenState createState() => _DesignationListScreenState();
}

class _DesignationListScreenState extends State<DesignationListScreen> {
  final DesignationListController controller = Get.put(
    DesignationListController(),
  );
  late String selectedItem;

  @override
  void initState() {
    super.initState();
    selectedItem = widget.selectedItem;
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
            child: Container(
              color: const Color(0xFFF9F9F9),
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                          'DESIGNATION LIST',
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
                                Navigator.pushNamed(context, '/adddesignation');
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
                      } else if (controller.error.isNotEmpty) {
                        return Center(child: Text(controller.error.value));
                      } else {
                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              _buildRow([
                                "ID",
                                "DESIGNATION",
                                "OFFICE/DEPARTMENT",
                                "TIME RELEASE",
                                "ACTIONS",
                              ], 0),
                              ...List.generate(controller.designations.length, (
                                index,
                              ) {
                                final designation =
                                    controller.designations[index];
                                return _buildRow([
                                  designation['id'].toString(),
                                  designation['designation'],
                                  designation['office_or_department'],
                                  designation['time_release'],
                                  "",
                                ], index + 1);
                              }),
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

  // Function to build each row dynamically
  Widget _buildRow(List<String> values, int index) {
    bool isHeader = index == 0;
    bool isEvenRow = index % 2 == 0;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      decoration: BoxDecoration(
        color:
            isHeader
                ? Colors.white
                : (isEvenRow ? Colors.white : Colors.transparent),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Expanded(flex: 1, child: _rowText(values[0], isHeader)), // ID
          Expanded(
            flex: 3,
            child: _rowText(values[1], isHeader),
          ), // Designation
          Expanded(
            flex: 3,
            child: _rowText(values[2], isHeader),
          ), // Office/Department
          Expanded(
            flex: 2,
            child: _rowText(values[3], isHeader),
          ), // Time Release
          Expanded(
            flex: 2,
            child:
                isHeader
                    ? _rowText(values[4], isHeader)
                    : _actionIcons(values[0], values[1], values[2], values[3]),
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

  // Actions Column Icons (Only for data rows)
  Widget _actionIcons(
    String designationId,
    String designation,
    String department,
    String time,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // IconButton(
        //   icon: const Icon(
        //     Icons.content_paste_search_rounded,
        //     color: Colors.green,
        //     size: 40,
        //   ),
        //   onPressed: () {
        //     Navigator.pushNamed(context, '/viewdesignation');
        //   },
        // ),
        IconButton(
          icon: const Icon(Icons.edit, color: Colors.green, size: 40),
          onPressed:
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => EditDesignationScreen(
                        id: designationId,
                        designation: designation,
                        department: department,
                        time: time,
                      ),
                ),
              ),
        ),
        IconButton(
          icon: const Icon(
            Icons.delete,
            color: Color.fromARGB(255, 243, 20, 4),
            size: 50,
          ),
          onPressed:
              () => _showConfirmationDialog(
                context,
                designationId,
                designation,
                department,
                time,
              ),
        ),
      ],
    );
  }

  void _showConfirmationDialog(
    BuildContext context,
    String id,
    String designation,
    String department,
    String time,
  ) async {
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
                        await controller.deleteDesignation(id: id);
                        await controller.fetchDesignations();
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
