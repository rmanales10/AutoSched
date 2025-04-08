import 'package:autosched/screens/profile_screen/profile/profile_controller.dart';
import 'package:autosched/widgets/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String selectedItem = 'My Profile';
  final _controller = Get.put(ProfileController());

  @override
  void initState() {
    _controller.getCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize = screenWidth < 600 ? 14 : 16;
    double inputFontSize = screenWidth < 600 ? 14 : 23;
    double textFieldWidth = screenWidth > 1200 ? 350 : screenWidth * 0.3;

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
              padding: const EdgeInsets.all(40),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Account Information and Settings',
                      style: TextStyle(
                        fontSize: fontSize + 6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 50),
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 60,
                          backgroundImage: AssetImage('assets/profile.png'),
                        ),
                        const SizedBox(width: 30),
                        Transform.translate(
                          offset: const Offset(0, 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Obx(() {
                                final user = _controller.currentUser;
                                return Text(
                                  user['access_role'] ?? 'N/A',
                                  style: TextStyle(
                                    fontSize: fontSize + 7,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              }),
                              IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.green,
                                  size: 35,
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(context, '/edit');
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 50),
                    Obx(() {
                      final user = _controller.currentUser;
                      return Expanded(
                        child: Wrap(
                          spacing: 30,
                          runSpacing: 50,
                          alignment: WrapAlignment.start,
                          children: [
                            _buildTextField(
                              label: 'Username',
                              value: user['username'] ?? 'N/A',
                              fontSize: inputFontSize,
                              width: textFieldWidth,
                            ),
                            _buildTextField(
                              label: 'First Name',
                              value: user['firstname'] ?? 'N/A',
                              fontSize: inputFontSize,
                              width: textFieldWidth,
                            ),
                            _buildTextField(
                              label: 'Last Name',
                              value: user['lastname'] ?? 'N/A',
                              fontSize: inputFontSize,
                              width: textFieldWidth,
                            ),
                            _buildTextField(
                              label: 'Access Role',
                              value: user['access_role'] ?? 'N/A',
                              fontSize: inputFontSize,
                              width: textFieldWidth,
                            ),
                            _buildTextField(
                              label: 'Email',
                              value: user['email'] ?? 'N/A',
                              fontSize: inputFontSize,
                              width: textFieldWidth,
                            ),
                            _buildTextField(
                              label: 'Mobile Number',
                              value: user['mobile_number'] ?? 'N/A',
                              fontSize: inputFontSize,
                              width: textFieldWidth,
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String value,
    required double fontSize,
    required double width,
  }) {
    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              label,
              style: TextStyle(
                fontSize: fontSize + 1,
                fontWeight: FontWeight.bold,
                color: Colors.grey[600],
              ),
            ),
          ),
          const SizedBox(height: 5),
          Container(
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(width: 2, color: Colors.grey.shade300),
            ),
            child: TextField(
              readOnly: true,
              style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                border: InputBorder.none,
                hintText: value,
                hintStyle: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
