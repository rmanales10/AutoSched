import 'package:autosched/screens/setup_manager_screen/rooms/room_controller.dart';
import 'package:autosched/widgets/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  final _controller = Get.put(RoomController());

  @override
  void initState() {
    selectedItem = widget.selectedItem;
    _controller.fetchRooms();
    super.initState();
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
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 30,
                      bottom: 20,
                      left: 20,
                      right: 20,
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
                                size: 40,
                              ),
                              onPressed: () {
                                // Print Action
                              },
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.note_add_rounded,
                                color: Color.fromARGB(255, 1, 0, 66),
                                size: 40,
                              ),
                              onPressed: () {
                                Navigator.pushNamed(context, '/addfaculty');
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            _buildHeaderRow(),
                            ..._controller.rooms.asMap().entries.map((entry) {
                              int index = entry.key;
                              Map<String, dynamic> room = entry.value;
                              return _buildDataRow(room, index);
                            }),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderRow() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(flex: 1, child: _headerText("ID")),
          Expanded(flex: 2, child: _headerText("ROOM NUMBER")),
          Expanded(flex: 3, child: _headerText("ROOM NAME")),
          Expanded(flex: 2, child: _headerText("ROOM TYPE")),
          Expanded(flex: 2, child: _headerText("ACTIONS")),
        ],
      ),
    );
  }

  Widget _headerText(String text) {
    return Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildDataRow(Map<String, dynamic> room, int index) {
    bool isEvenRow = index % 2 == 0;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: isEvenRow ? Colors.white : Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(flex: 1, child: _rowText(room['room_id'].toString())),
          Expanded(flex: 2, child: _rowText(room['room_number'] ?? '')),
          Expanded(flex: 3, child: _rowText(room['room_name'] ?? '')),
          Expanded(flex: 2, child: _rowText(room['room_type'] ?? '')),
          Expanded(flex: 2, child: _actionIcons()),
        ],
      ),
    );
  }

  Widget _rowText(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 14),
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
            size: 24,
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.edit, color: Colors.green, size: 24),
          onPressed: () {},
        ),
      ],
    );
  }
}
