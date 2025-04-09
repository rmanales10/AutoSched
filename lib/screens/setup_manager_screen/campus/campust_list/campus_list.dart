import 'package:autosched/screens/setup_manager_screen/campus/campust_list/campust_list_controller.dart';
import 'package:autosched/widgets/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CampusListScreen extends StatefulWidget {
  final String selectedItem;
  final Function(String, String) onItemSelected;

  const CampusListScreen({
    super.key,
    required this.selectedItem,
    required this.onItemSelected,
  });

  @override
  _CampusListScreenState createState() => _CampusListScreenState();
}

class _CampusListScreenState extends State<CampusListScreen> {
  final CampustListController controller = Get.put(CampustListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: Row(
        children: [
          Sidebar(
            selectedItem: widget.selectedItem,
            onItemSelected: widget.onItemSelected,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10, left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'CAMPUS LIST',
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
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.note_add_rounded,
                                color: Color.fromARGB(255, 1, 0, 66),
                                size: 50,
                              ),
                              onPressed: () {
                                Navigator.pushNamed(context, '/addcampus');
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
                        return Center(child: CircularProgressIndicator());
                      } else {
                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              _buildRow([
                                "ID",
                                "CAMPUS NAME",
                                "CAMPUS TYPE",
                                "ACTIONS",
                              ], 0),
                              ...controller.campuses.asMap().entries.map((
                                entry,
                              ) {
                                int idx = entry.key;
                                var campus = entry.value;
                                return _buildRow([
                                  campus['id'].toString(),
                                  campus['campus_name'],
                                  campus['campus_type'],
                                  "",
                                ], idx + 1);
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

  // ... (keep the existing _buildRow, _rowText, and _actionIcons methods)

  // Function to build each row dynamically
  Widget _buildRow(List<String> values, int index) {
    bool isHeader = index == 0;
    bool isEvenRow = index % 2 == 0;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      decoration: BoxDecoration(
        color: isEvenRow ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Expanded(flex: 1, child: _rowText(values[0], isHeader)),
          Expanded(flex: 3, child: _rowText(values[1], isHeader)),
          Expanded(flex: 2, child: _rowText(values[2], isHeader)),
          Expanded(
            flex: 2,
            child:
                isHeader
                    ? _rowText(values[3], isHeader)
                    : _actionIcons(values[0]),
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

  Widget _actionIcons(String campusId) {
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
            Navigator.pushNamed(context, '/viewcampus', arguments: campusId);
          },
        ),
        IconButton(
          icon: const Icon(Icons.edit, color: Colors.green, size: 40),
          onPressed: () {
            Navigator.pushNamed(context, '/editcampus', arguments: campusId);
          },
        ),
        IconButton(
          icon: const Icon(
            Icons.delete,
            color: Color.fromARGB(255, 243, 20, 4),
            size: 50,
          ),
          onPressed: () => _showConfirmationDialog(context, campusId),
        ),
      ],
    );
  }

  void _showConfirmationDialog(BuildContext context, String campusId) async {
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
                        await controller.deleteCampuses(campusId: campusId);
                        await controller.fetchCampuses();
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
