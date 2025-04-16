import 'package:autosched/screens/setup_manager_screen/rooms/edit_room/edit_room.dart';
import 'package:autosched/screens/setup_manager_screen/rooms/room/room_controller.dart';
import 'package:autosched/screens/setup_manager_screen/rooms/viewroom.dart';
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
  final RoomController roomController = Get.put(RoomController());

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
                  Expanded(
                    child: Obx(() {
                      if (roomController.isLoading.value) {
                        return Center(child: CircularProgressIndicator());
                      } else if (roomController.errorMessage.isNotEmpty) {
                        return Center(
                          child: Text(roomController.errorMessage.value),
                        );
                      } else {
                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              _buildHeaderRow(),
                              ...roomController.rooms.map(
                                (room) => _buildRow(room),
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
      'room_id': 'ID',
      'room_number': 'ROOM NUMBER',
      'room_name': 'ROOM NAME',
      'room_type': 'ROOM TYPE',
      'actions': 'ACTIONS',
    }, isHeader: true);
  }

  Widget _buildRow(Map<String, dynamic> values, {bool isHeader = false}) {
    bool isEvenRow = roomController.rooms.indexOf(values) % 2 == 0;

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
          Expanded(
            flex: 1,
            child: _rowText(values['room_id'].toString(), isHeader),
          ),
          Expanded(
            flex: 2,
            child: _rowText(values['room_number'].toString(), isHeader),
          ),
          Expanded(
            flex: 3,
            child: _rowText(values['room_name'] ?? '', isHeader),
          ),
          Expanded(
            flex: 2,
            child: _rowText(values['room_type'] ?? '', isHeader),
          ),
          Expanded(
            flex: 2,
            child:
                isHeader
                    ? _rowText(values['actions'], isHeader)
                    : _actionIcons(
                      values['room_id'].toString(),
                      values['room_number'].toString(),
                      values['room_name'] ?? '',
                      values['room_type'] ?? '',
                      values['description'] ?? '',
                    ),
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

  Widget _actionIcons(
    String roomId,
    String roomNumber,
    String roomName,
    String roomType,
    String descriptive,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(
            Icons.content_paste_search_rounded,
            color: Colors.green,
            size: 40,
          ),
          onPressed:
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => ViewRoomScreen(
                        roomId: roomId,
                        roomNumber: roomNumber,
                        roomName: roomName,
                        roomType: roomType,
                        descriptive: descriptive,
                      ),
                ),
              ),
        ),
        IconButton(
          icon: const Icon(Icons.edit, color: Colors.green, size: 40),
          onPressed:
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => EditRoomScreen(
                        roomId: roomId,
                        roomNumber: roomNumber,
                        roomName: roomName,
                        roomType: roomType,
                        descriptive: descriptive,
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
          onPressed: () => _showConfirmationDialog(context, roomId),
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
                        await roomController.deleteRoom(id: id);
                        await roomController.fetchRooms();
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
