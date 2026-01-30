import 'package:flutter/material.dart';
import '../api_service.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool loggedIn = false;
  String? savedMobile;
  String message = "";
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  void checkLogin() async {
    final token = await ApiService.getToken();
    final mobile = await ApiService.getMobile();
    setState(() {
      loggedIn = token != null;
      savedMobile = mobile;
    });
  }

  void login() async {
  final mobile = mobileController.text.trim();
  final password = passwordController.text.trim();

  if (mobile.isEmpty || password.isEmpty) {
    setState(() => message = "Please enter mobile and password");
    return;
  }

  setState(() => message = "Logging in...");
  final result = await ApiService.login(mobile, password);

  if (result['success']) {
    // ✅ Navigate to ClassScreen after login
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, '/class');

    // Optional: save login info locally if needed
    setState(() {
      loggedIn = true;
      savedMobile = mobile;
      message = "Login successful!";
    });
  } else {
    setState(() {
      message = result['error'] ?? "Login failed";
    });
  }
}


  void logout() async {
    await ApiService.logout();
    setState(() {
      loggedIn = false;
      savedMobile = null;
      message = "";
      mobileController.clear();
      passwordController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 72, 126, 72),
      ),
      body: loggedIn ? profileView() : loginView(),
    );
  }

  Widget loginView() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: mobileController,
            decoration: const InputDecoration(labelText: "Mobile Number"),
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 15),
          TextField(
            controller: passwordController,
            decoration: const InputDecoration(labelText: "Password"),
            obscureText: true,
          ),
          const SizedBox(height: 25),
          ElevatedButton(
            onPressed: login,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(50),
            ),
            child: const Text("Login"),
          ),
          const SizedBox(height: 20),
          Text(
            message,
            style: const TextStyle(color: Colors.red, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget profileView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.person, size: 100),
          const SizedBox(height: 20),
          Text(
            "Mobile: $savedMobile",
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: logout,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(150, 50),
            ),
            child: const Text("Logout"),
          ),
        ],
      ),
    );
  }
}
