import 'package:autosched/widgets/sidebar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedItem = 'Home';

  void _onSidebarItemSelected(String title, String route) {
    setState(() {
      selectedItem = title;
    });
    Navigator.pushNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize = screenWidth < 600 ? 14 : 16;
    double logoSize = screenWidth < 600 ? 70 : 100;

    return Scaffold(
      body: Row(
        children: [
          Sidebar(
            selectedItem: selectedItem,
            onItemSelected: _onSidebarItemSelected,
          ),
          Expanded(
            child: Container(
              color: const Color(0xFFF9F9F9),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        children: [
                          TextSpan(
                            text: 'Auto',
                            style: TextStyle(
                              fontSize: logoSize,
                              color: const Color(0xFFFA9702),
                            ),
                          ),
                          TextSpan(
                            text: 'Sched',
                            style: TextStyle(
                              fontSize: logoSize,
                              color: const Color(0xFF010042),
                            ),
                          ),
                          WidgetSpan(
                            child: Transform.translate(
                              offset: const Offset(0, -10),
                              child: Text(
                                '®',
                                style: TextStyle(
                                  fontSize: logoSize / 2,
                                  color: const Color(0xFFEB8D01),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Wave goodbye to scheduling headaches and hello to effortless planning.',
                      style: TextStyle(
                        fontSize: fontSize,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Choose from the side menu to start',
                      style: TextStyle(
                        fontSize: fontSize + 2,
                        color: Colors.grey,
                      ),
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
}
