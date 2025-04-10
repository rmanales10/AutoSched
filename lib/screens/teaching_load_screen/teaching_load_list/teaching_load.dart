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
  String selectedItem = "Teaching Load";

  @override
  void initState() {
    super.initState();
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'TEACHING LOAD LIST',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
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
          "FINAL-LOAD-2024", // You might want to replace this with actual data
          load['program'],
          load['semester'],
          "",
        ],
      ),
    ];

    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: List.generate(teachingLoadData.length, (index) {
            return _buildRow(teachingLoadData[index], index);
          }),
        ),
      ),
    );
  }

  Widget _buildRow(List<String> values, int index) {
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
          Expanded(flex: 1, child: _rowText(values[0], isHeader)), // ID
          Expanded(
            flex: 3,
            child: _rowText(values[1], isHeader),
          ), // Teaching Load
          Expanded(flex: 2, child: _rowText(values[2], isHeader)), // Program
          Expanded(flex: 2, child: _rowText(values[3], isHeader)), // Status
          Expanded(
            flex: 2,
            child: isHeader ? _rowText(values[4], isHeader) : _actionIcons(),
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

  Widget _actionIcons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/assign-faculty-load');
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
}
