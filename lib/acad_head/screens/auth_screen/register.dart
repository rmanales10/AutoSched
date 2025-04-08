import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  String selectedRole = 'SCHEDULER';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
              text: TextSpan(
                style: TextStyle(fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                    text: 'Auto',
                    style: TextStyle(
                      fontSize: 40,
                      color: Color.fromARGB(255, 250, 151, 2),
                    ),
                  ),
                  TextSpan(
                    text: 'Sched',
                    style: TextStyle(
                      fontSize: 40,
                      color: Color.fromARGB(255, 1, 0, 66),
                    ),
                  ),
                  WidgetSpan(
                    child: Transform.translate(
                      offset: Offset(0, -10),
                      child: Text(
                        '®',
                        style: TextStyle(
                          fontSize: 25,
                          color: Color.fromARGB(255, 235, 141, 1),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Create Account',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 1, 0, 66),
                      ),
                    ),
                    const SizedBox(height: 20),

                    _buildTextField(
                      label: 'Email or Phone',
                      obscureText: false,
                    ),
                    const SizedBox(height: 15),
                    _buildTextField(
                      label: 'Password',
                      obscureText: _obscurePassword,
                      onToggle: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                    const SizedBox(height: 15),
                    _buildTextField(
                      label: 'Confirm Password',
                      obscureText: _obscureConfirmPassword,
                      onToggle: () {
                        setState(() {
                          _obscureConfirmPassword = !_obscureConfirmPassword;
                        });
                      },
                    ),

                    const SizedBox(height: 20),

                    GestureDetector(
                      onTap: () {
                        // Implement registration logic here
                      },
                      child: Container(
                        width: 350,
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 1, 0, 66),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Center(
                          child: Text(
                            'Sign Up',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Already have an account? ',
                          style: TextStyle(color: Colors.black),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required bool obscureText,
    VoidCallback? onToggle,
  }) {
    return TextField(
      cursorColor: Colors.grey,
      obscureText: obscureText,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        labelText: label,
        labelStyle: const TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        suffixIcon:
            label.contains('Password')
                ? Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: IconButton(
                    icon: Icon(
                      obscureText ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: onToggle,
                  ),
                )
                : null,
      ),
    );
  }

}
