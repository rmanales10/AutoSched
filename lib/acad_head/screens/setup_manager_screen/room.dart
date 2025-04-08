import 'package:autosched/widgets/sidebar.dart';
import 'package:flutter/material.dart';

class RoomScreen extends StatefulWidget {
  final String selectedItem;
  final Function(String, String) onItemSelected;

  const RoomScreen({
    super.key,
    required this.selectedItem,
    required this.onItemSelected,
  });

  @override
  _RoomScreenState createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  late String selectedItem;
  

  final List<List<String>> roomData = [
    ["ID", "ROOM NUMBER", "ROOM NAME", "ROOM TYPE", "ACTIONS"],
    ["001", "01", "MAKESHIFT ROOM", "LECTURE", ""],
    ["002", "01", "COMP LAB", "LABORATORY", ""],
    ["001", "01", "MAKESHIFT ROOM", "LECTURE", ""],
    ["002", "01", "COMP LAB", "LABORATORY", ""],
    ["001", "01", "MAKESHIFT ROOM", "LECTURE", ""],
    ["002", "01", "COMP LAB", "LABORATORY", ""],
    ["001", "01", "MAKESHIFT ROOM", "LECTURE", ""],
    ["002", "01", "COMP LAB", "LABORATORY", ""],
    ["001", "01", "MAKESHIFT ROOM", "LECTURE", ""],
    ["002", "01", "COMP LAB", "LABORATORY", ""],
    ["001", "01", "MAKESHIFT ROOM", "LECTURE", ""],
    ["002", "01", "COMP LAB", "LABORATORY", ""],
    ["001", "01", "MAKESHIFT ROOM", "LECTURE", ""],
    ["002", "01", "COMP LAB", "LABORATORY", ""],
    ["001", "01", "MAKESHIFT ROOM", "LECTURE", ""],
    ["002", "01", "COMP LAB", "LABORATORY", ""],
    ["001", "01", "MAKESHIFT ROOM", "LECTURE", ""],
    ["002", "01", "COMP LAB", "LABORATORY", ""],
    ["001", "01", "MAKESHIFT ROOM", "LECTURE", ""],
    ["002", "01", "COMP LAB", "LABORATORY", ""],
  ];

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
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                color: const Color(0xFFF9F9F9),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Section (No Extra Top Padding)
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 30,
                        bottom: 10,
                        left: 20,
                        right: 70,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'ROOM LIST',
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
                                  color: Color(0xFF010042),
                                  size: 50,
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(context, '/addroom');
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    // Room List (No Extra Bottom Padding)
                    Column(
                      children: List.generate(roomData.length, (index) {
                        return _buildRow(roomData[index], index);
                      }),
                    ),
                  ],
                ),
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
            flex: 2,
            child: _rowText(values[1], isHeader),
          ), // Room Number
          Expanded(flex: 3, child: _rowText(values[2], isHeader)), // Room Name
          Expanded(flex: 2, child: _rowText(values[3], isHeader)), // Room Type
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
        IconButton(
          icon: const Icon(
            Icons.content_paste_search_rounded,
            color: Colors.green,
            size: 40,
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.edit, color: Colors.green, size: 40),
          onPressed: () {},
        ),
      ],
    );
  }
}
