import 'package:flutter/material.dart';

class Class extends StatefulWidget {
  const Class({super.key});

  @override
  State<Class> createState() => ClassScreen();
}

class ClassScreen extends State<Class> {
  int indexNUM = 2; // Class selected

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Class"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 72, 126, 72),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ================= STUDENT DETAILS =================
            const Text(
              "Student Details",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            const Card(
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text("Mobile"),
                subtitle: Text("8281002367"),
              ),
            ),

            const SizedBox(height: 20),

            // ================= RECORDED CLASSES =================
            const Text(
              "Recorded Classes",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            recordedTile(
              title: "Algebra – Chapter 1",
              duration: "45 mins",
            ),
            recordedTile(
              title: "Geometry – Triangles",
              duration: "50 mins",
            ),
            recordedTile(
              title: "Mensuration Basics",
              duration: "40 mins",
            ),

            const SizedBox(height: 20),

            // ================= LIVE CLASS =================
            const Text(
              "Scheduled Live Class",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            Card(
              color: Colors.blue.shade50,
              child: ListTile(
                leading: const Icon(Icons.video_call, color: Colors.blue),
                title: const Text("Maths Live Class"),
                subtitle: const Text("30 Jan • 7:00 PM"),
                trailing: ElevatedButton(
                  onPressed: () {
                    // later open Zoom / Meet link
                  },
                  child: const Text("Join"),
                ),
              ),
            ),
          ],
        ),
      ),

      // ================= BOTTOM NAV =================
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: indexNUM,
        showUnselectedLabels: true,
        onTap: (index) {
          setState(() => indexNUM = index);

          if (index == 0) {
            Navigator.pushNamed(context, '/');
          } else if (index == 1) {
            Navigator.pushNamed(context, '/maai');
          } else if (index == 2) {
            // already on class
          } else if (index == 3) {
            Navigator.pushNamed(context, '/setting');
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.smart_toy),
            label: "MAAI",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school_outlined),
            label: "Class",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Setting",
          ),
        ],
      ),
    );
  }

  // ================= RECORDED CLASS TILE =================
  static Widget recordedTile({
    required String title,
    required String duration,
  }) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.play_circle_fill),
        title: Text(title),
        subtitle: Text(duration),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          // Later: open video player
        },
      ),
    );
  }
}
