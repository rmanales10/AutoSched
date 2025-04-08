import 'package:autosched/widgets/sidebar.dart';
import 'package:flutter/material.dart';

class GenerateLoadScreen extends StatelessWidget {
  const GenerateLoadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: Row(
        children: [
          Sidebar(
            selectedItem: 'Schedule',
            onItemSelected: (title, route) {
              Navigator.pushNamed(context, route);
            },
          ),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 200,
                  vertical: 100,
                ),
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 1, color: Colors.grey.shade400),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 30,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Generate Schedule',
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          _buildButton(
                            "Generate",
                            const Color(0xFF010042),
                            Colors.white,
                            () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => const GeneratedLoadScreen(),
                                ),
                              );
                            },
                          ),
                          const SizedBox(width: 20),
                          _buildButton(
                            "Cancel",
                            Color.fromARGB(255, 243, 20, 4),
                            Colors.white,
                            () {},
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
}

class GeneratedLoadScreen extends StatelessWidget {
  const GeneratedLoadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: Row(
        children: [
          Sidebar(
            selectedItem: 'Schedule',
            onItemSelected: (title, route) {
              Navigator.pushNamed(context, route);
            },
          ),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 200,
                  vertical: 100,
                ),
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 1, color: Colors.grey.shade400),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 30,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Generated Schedule',
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          _buildButton(
                            "Accept",
                            const Color(0xFF010042),
                            Colors.white,
                            () {},
                          ),
                          const SizedBox(width: 20),
                          _buildButton(
                            "Regenerate",
                            Colors.white,
                            const Color(0xFF010042),
                            () {},
                            borderColor: const Color(0xFF010042),
                          ),
                          const Spacer(),
                          _buildButton(
                            "Cancel",
                            Color.fromARGB(255, 243, 20, 4),
                            Colors.white,
                            () {
                              Navigator.pop(context);
                            },
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
}

Widget _buildButton(
  String text,
  Color bgColor,
  Color textColor,
  VoidCallback onPressed, {
  Color? borderColor,
}) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      width: 180,
      height: 45,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(30),
        border:
            borderColor != null
                ? Border.all(color: borderColor, width: 1)
                : null,
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );
}
