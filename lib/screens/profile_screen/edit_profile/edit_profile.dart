import 'package:autosched/screens/profile_screen/edit_profile/edit_profile_controller.dart';
import 'package:autosched/screens/profile_screen/profile/profile.dart';
import 'package:autosched/widgets/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String selectedRole = 'SCHEDULER';
  File? _selectedImage;
  Uint8List? _selectedImageBytes;

  final _editProfilecontroller = Get.put(EditProfileController());
  final _usernameController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _mobileNumberController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _picker = ImagePicker();

  Future<void> _pickImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
      );
      if (pickedFile != null) {
        final bytes = await pickedFile.readAsBytes();
        setState(() {
          _selectedImageBytes = bytes;
          _selectedImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      print('Error picking image: $e');
    }
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
            selectedItem: 'My Profile',
            onItemSelected: (title, route) {
              Navigator.pushNamed(context, route);
            },
          ),

          Expanded(
            child: SingleChildScrollView(
              child: Container(
                color: const Color(0xFFF9F9F9),
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 40,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Edit Account Information and Settings',
                        style: TextStyle(
                          fontSize: fontSize + 6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 50),

                      Row(
                        children: [
                          Stack(
                            children: [
                              CircleAvatar(
                                radius: 60,
                                backgroundColor: Colors.grey[300],
                                backgroundImage:
                                    _selectedImageBytes != null
                                        ? MemoryImage(_selectedImageBytes!)
                                        : _editProfilecontroller
                                                    .currentUser['profile_image'] !=
                                                null &&
                                            _editProfilecontroller
                                                .currentUser['profile_image']
                                                .toString()
                                                .contains('base64,')
                                        ? MemoryImage(
                                          base64Decode(
                                            _editProfilecontroller
                                                .currentUser['profile_image']
                                                .toString()
                                                .split('base64,')[1],
                                          ),
                                        )
                                        : null,
                                child:
                                    _selectedImageBytes == null &&
                                            (_editProfilecontroller
                                                        .currentUser['profile_image'] ==
                                                    null ||
                                                !_editProfilecontroller
                                                    .currentUser['profile_image']
                                                    .toString()
                                                    .contains('base64,'))
                                        ? Icon(
                                          Icons.person,
                                          size: 60,
                                          color: Colors.grey[600],
                                        )
                                        : null,
                              ),
                              Positioned(
                                right: 0,
                                bottom: 0,
                                child: GestureDetector(
                                  onTap: _pickImage,
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF010042),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.attach_file,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 20),
                          Obx(
                            () => Text(
                              _editProfilecontroller
                                      .currentUser['access_role'] ??
                                  'N/A',
                              style: TextStyle(
                                fontSize: fontSize + 8,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 50),

                      _buildProfileForm1(inputFontSize, textFieldWidth),

                      const SizedBox(height: 30),

                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          'Password',
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      _buildProfileForm2(inputFontSize, textFieldWidth),

                      const SizedBox(height: 40),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          _buildButton(
                            "Save",
                            const Color.fromARGB(255, 1, 0, 66),
                            Colors.white,
                            onTap: () => _showConfirmationDialog(context),
                          ),
                          const SizedBox(width: 20),
                          _buildButton(
                            "Cancel",
                            const Color.fromARGB(255, 243, 20, 4),
                            Colors.white,
                            onTap: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileForm1(double fontSize, double width) {
    return Obx(() {
      final user = _editProfilecontroller.currentUser;

      _usernameController.text = user['username'] ?? '';
      _firstNameController.text = user['firstname'] ?? '';
      _lastNameController.text = user['lastname'] ?? '';
      _mobileNumberController.text = user['mobile_number'] ?? '';

      return Wrap(
        spacing: 20,
        runSpacing: 30,
        children: [
          _buildTextField(
            label: 'Username',
            value: user['username'] ?? 'N/A',
            fontSize: fontSize,
            width: width,
            enabled: true,
            controller: _usernameController,
          ),
          _buildTextField(
            label: 'First Name',
            value: user['firstname'] ?? 'N/A',
            fontSize: fontSize,
            width: width,
            enabled: true,
            controller: _firstNameController,
          ),
          _buildTextField(
            label: 'Last Name',
            value: user['lastname'] ?? 'N/A',
            fontSize: fontSize,
            width: width,
            enabled: true,
            controller: _lastNameController,
          ),
          _buildTextField(
            label: 'Access Role',
            value: user['access_role'] ?? 'N/A',
            fontSize: fontSize,
            width: width,
          ),
          _buildTextField(
            label: 'Email',
            value: user['email'] ?? 'N/A',
            fontSize: fontSize,
            width: width,
          ),
          _buildTextField(
            label: 'Mobile Number',
            value: user['mobile_number'] ?? 'N/A',
            fontSize: fontSize,
            width: width,
            enabled: true,
            controller: _mobileNumberController,
          ),
        ],
      );
    });
  }

  Widget _buildProfileForm2(double fontSize, double width) {
    return Obx(() {
      final user = _editProfilecontroller.currentUser;

      _passwordController.text = user['password'] ?? '';
      _confirmPasswordController.text = user['password'] ?? '';
      return Wrap(
        spacing: 20,
        runSpacing: 30,
        children: [
          _buildTextField(
            label: 'Current Password',
            value: user['password'] ?? 'N/A',
            fontSize: fontSize,
            width: width,
            controller: _passwordController,
            obscureText: true,
          ),
          _buildTextField(
            label: 'New Password',
            value: user['password'] ?? 'N/A',
            fontSize: fontSize,
            width: width,
            controller: _confirmPasswordController,
            obscureText: true,
          ),
        ],
      );
    });
  }

  Widget _buildButton(
    String text,
    Color bgColor,
    Color textColor, {
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 180,
        height: 45,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context) {
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
              mainAxisSize:
                  MainAxisSize.min, // Ensures it only takes needed space
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Do you want to save changes?",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        updateOrCreateProfile();
                        Get.off(ProfileScreen());
                      },
                      child: Container(
                        width: 120,
                        height: 30,
                        decoration: BoxDecoration(
                          color: const Color(0xFF010042),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: const Text(
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
                        child: Center(
                          child: const Text(
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

  Widget _buildTextField({
    required String label,
    required String value,
    required double fontSize,
    required double width,
    bool enabled = false,
    TextEditingController? controller,
    bool obscureText = false,
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
                fontSize: fontSize,
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
              border: Border.all(width: 1, color: Colors.grey.shade300),
            ),
            child: TextField(
              controller: controller,
              enabled: enabled,
              obscureText: obscureText,
              cursorColor: Colors.black,
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
                  color: Colors.grey.shade600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> updateOrCreateProfile() async {
    await _editProfilecontroller.updateOrCreateProfile(
      username: _usernameController.text,
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      mobileNumber: _mobileNumberController.text,
      password: _confirmPasswordController.text,
      profileImage:
          _selectedImageBytes != null
              ? base64Encode(_selectedImageBytes!)
              : null,
    );
    if (_editProfilecontroller.isSuccess) {
      // Update the controllers with the new values
      setState(() {
        _usernameController.text =
            _editProfilecontroller.currentUser['username'] ?? '';
        _firstNameController.text =
            _editProfilecontroller.currentUser['firstname'] ?? '';
        _lastNameController.text =
            _editProfilecontroller.currentUser['lastname'] ?? '';
        _mobileNumberController.text =
            _editProfilecontroller.currentUser['mobile_number'] ?? '';
        _passwordController.text =
            _editProfilecontroller.currentUser['password'] ?? '';
        _confirmPasswordController.text =
            _editProfilecontroller.currentUser['password'] ?? '';
      });
      Get.snackbar('Success', 'Edited profile successfully.');
      Get.back(canPop: true);
    } else {
      Get.snackbar('Error', _editProfilecontroller.errorMessage);
    }
  }
}
