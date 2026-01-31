import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './widgets/homecontroller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController mobileController = TextEditingController();

  void login() async {
    if (mobileController.text.isEmpty) return;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('mobile', mobileController.text);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => Homecontroller(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: mobileController,
              decoration: const InputDecoration(labelText: "Enter Mobile"),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: login, child: const Text("Continue")),
          ],
        ),
      ),
    );
  }
}
