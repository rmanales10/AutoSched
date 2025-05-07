import 'package:autosched/screens/auth_screens/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscurePassword = true;
  String selectedRole = 'SCHEDULER';
  final _controller = Get.put(LoginController());
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
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
                style: const TextStyle(fontWeight: FontWeight.bold),
                children: [
                  const TextSpan(
                    text: 'Auto',
                    style: TextStyle(
                      fontSize: 40,
                      color: Color.fromARGB(255, 250, 151, 2),
                    ),
                  ),
                  const TextSpan(
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
              height: 470,
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
                      'Hi! Welcome',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 1, 0, 66),
                      ),
                    ),
                    const SizedBox(height: 20),

                    _buildTextField(
                      label: 'Email or Phone',
                      obscureText: false,
                      controller: _emailController,
                      onSubmit: _handleLogin,
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
                      controller: _passwordController,
                      onSubmit: _handleLogin,
                    ),

                    const SizedBox(height: 15),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/forgot');
                      },
                      child: const Text(
                        'Forgot password?',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    const SizedBox(height: 15),

                    InkWell(
                      onTap: () => _handleLogin(),
                      child: Container(
                        width: 350,
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 1, 0, 66),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Center(
                          child: Text(
                            'Login',
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
                          "Don't have an account? ",
                          style: TextStyle(color: Colors.black),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/register');
                          },
                          child: const Text(
                            "Sign up",
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
    TextEditingController? controller,
    VoidCallback? onSubmit,
  }) {
    return TextField(
      cursorColor: Colors.grey,
      controller: controller,
      obscureText: obscureText,
      textInputAction:
          label.contains('Password')
              ? TextInputAction.done
              : TextInputAction.next,
      onSubmitted: (value) {
        if (label.contains('Password') && onSubmit != null) {
          onSubmit();
        }
      },
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

  Future<void> _handleLogin() async {
    await _controller.login(_emailController.text, _passwordController.text);
    if (_controller.isSuccess == true) {
      Get.snackbar('Success', _controller.errorMessage);
      Get.offAllNamed('/home');
    } else {
      Get.snackbar('Error', _controller.errorMessage);
    }
  }
}
