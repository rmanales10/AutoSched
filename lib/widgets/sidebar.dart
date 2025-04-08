import 'package:autosched/screens/profile_screen/profile/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Sidebar extends StatefulWidget {
  final String selectedItem;
  final Function(String, String) onItemSelected;

  const Sidebar({
    super.key,
    required this.selectedItem,
    required this.onItemSelected,
  });

  @override
  _SidebarState createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  bool isSetupManagerExpanded = false;
  bool isSchedulerExpanded = false;
  final _controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double sidebarWidth = screenWidth < 600 ? 200 : 250;
    double fontSize = screenWidth < 600 ? 14 : 16;
    double logoSize = screenWidth < 600 ? 70 : 100;

    return Container(
      width: sidebarWidth,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.selectedItem == 'My Profile'
                ? _buildLogo(logoSize)
                : _buildProfileRow(fontSize, screenWidth),

            const SizedBox(height: 50),

            SidebarItem(
              title: 'Home',
              isSelected: widget.selectedItem == 'Home',
              onTap: () => widget.onItemSelected('Home', '/home'),
              fontSize: fontSize,
            ),
            SidebarItem(
              title: 'My Profile',
              isSelected: widget.selectedItem == 'My Profile',
              onTap: () => widget.onItemSelected('My Profile', '/profile'),
              fontSize: fontSize,
            ),
            SidebarItem(
              title: 'Curriculum',
              isSelected: widget.selectedItem == 'Curriculum',
              onTap: () => widget.onItemSelected('Curriculum', '/curriculum'),
              fontSize: fontSize,
            ),
            SidebarItem(
              title: 'Teaching Load',
              isSelected: widget.selectedItem == 'Teaching Load',
              onTap:
                  () =>
                      widget.onItemSelected('Teaching Load', '/teaching-load'),
              fontSize: fontSize,
            ),

            // Setup Manager (Expandable)
            _buildExpandableSection(
              title: 'Setup Manager',
              isExpanded: isSetupManagerExpanded,
              onExpandToggle:
                  () => setState(
                    () => isSetupManagerExpanded = !isSetupManagerExpanded,
                  ),
              items: [
                SidebarItem(
                  title: 'Faculty',
                  isSelected: widget.selectedItem == 'Faculty',
                  onTap: () {
                    setState(() {}); // Ensures UI updates without collapsing
                    widget.onItemSelected('Faculty', '/setup-manager/faculty');
                  },
                  fontSize: 14,
                ),
                SidebarItem(
                  title: 'Rooms',
                  isSelected: widget.selectedItem == 'Rooms',
                  onTap: () {
                    setState(() {});
                    widget.onItemSelected('Rooms', '/setup-manager/rooms');
                  },
                  fontSize: 14,
                ),
              ],
            ),

            // Scheduler (Expandable)
            _buildExpandableSection(
              title: 'Scheduler',
              isExpanded: isSchedulerExpanded,
              onExpandToggle:
                  () => setState(
                    () => isSchedulerExpanded = !isSchedulerExpanded,
                  ),
              items: [
                SidebarItem(
                  title: 'Generated Schedules',
                  isSelected: widget.selectedItem == 'Generated Schedules',
                  onTap: () {
                    setState(() {});
                    widget.onItemSelected(
                      'Generated Schedules',
                      '/generated_schedules',
                    );
                  },
                  fontSize: 14,
                ),
              ],
            ),

            // // Setup Manager (Dropdown)
            // ExpansionTile(
            //   title: Text(
            //     'Setup Manager',
            //     style: TextStyle(
            //       fontSize: 16,
            //       fontWeight: FontWeight.bold,
            //       color: Colors.black,
            //     ),
            //   ),
            //   initiallyExpanded: isSetupManagerExpanded,
            //   onExpansionChanged: (expanded) {
            //     setState(() => isSetupManagerExpanded = expanded);
            //   },
            //   children: [
            //     SidebarItem(
            //       title: 'Faculty',
            //       isSelected: widget.selectedItem == 'Faculty',
            //       onTap: () => widget.onItemSelected('Faculty', '/setup-manager/faculty'),
            //       fontSize: 14,
            //     ),
            //     SidebarItem(
            //       title: 'Rooms',
            //       isSelected: widget.selectedItem == 'Rooms',
            //       onTap: () => widget.onItemSelected('Rooms', '/setup-manager/rooms'),
            //       fontSize: 14,
            //     ),
            //   ],
            // ),

            // // Scheduler (Dropdown)
            // ExpansionTile(
            //   title: Text(
            //     'Scheduler',
            //     style: TextStyle(
            //       fontSize: 16,
            //       fontWeight: FontWeight.bold,
            //       color: Colors.black,
            //     ),
            //   ),
            //   initiallyExpanded: isSchedulerExpanded,
            //   onExpansionChanged: (expanded) {
            //     setState(() => isSchedulerExpanded = expanded);
            //   },
            //   children: [
            //     SidebarItem(
            //       title: 'Generated Schedules',
            //       isSelected: widget.selectedItem == 'Generated Schedules',
            //       onTap: () => widget.onItemSelected('Generated Schedules', '/generated_schedules'),
            //       fontSize: 14,
            //     ),
            //   ],
            // ),
            SidebarItem(
              title: 'Reports',
              isSelected: widget.selectedItem == 'Reports',
              onTap: () => widget.onItemSelected('Reports', '/reports'),
              fontSize: fontSize,
            ),

            const Spacer(),

            GestureDetector(
              onTap: () => _controller.logout(),
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  'Logout',
                  style: TextStyle(
                    fontSize: fontSize + 5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpandableSection({
    required String title,
    required bool isExpanded,
    required VoidCallback onExpandToggle,
    required List<Widget> items,
  }) {
    return MouseRegion(
      onEnter: (_) => setState(() => isExpanded = true),
      onExit: (_) => setState(() => isExpanded = false),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SidebarItem(
            title: title,
            isSelected: widget.selectedItem == title,
            onTap: onExpandToggle,
            fontSize: 16,
          ),
          if (isExpanded)
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(children: items),
            ),
        ],
      ),
    );
  }

  Widget _buildProfileRow(double fontSize, double screenWidth) {
    return Row(
      children: [
        CircleAvatar(
          radius: screenWidth < 600 ? 30 : 40,
          backgroundImage: const AssetImage('assets/profile.png'),
        ),
        const SizedBox(width: 20),
        Obx(
          () => Text(
            _controller.currentUser['access_role'] ?? 'N/A',
            style: TextStyle(
              fontSize: fontSize + 2,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLogo(double logoSize) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(fontWeight: FontWeight.bold),
        children: [
          TextSpan(
            text: 'Auto',
            style: TextStyle(
              fontSize: logoSize / 3,
              color: const Color(0xFFFA9702),
            ),
          ),
          TextSpan(
            text: 'Sched',
            style: TextStyle(
              fontSize: logoSize / 3,
              color: const Color(0xFF010042),
            ),
          ),
          WidgetSpan(
            child: Transform.translate(
              offset: const Offset(0, -5),
              child: Text(
                '®',
                style: TextStyle(
                  fontSize: logoSize / 4,
                  color: const Color(0xFFEB8D01),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SidebarItem extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;
  final double fontSize;

  const SidebarItem({
    super.key,
    required this.title,
    this.isSelected = false,
    required this.onTap,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration:
            isSelected
                ? BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(30),
                )
                : null,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        child: Text(
          title,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
