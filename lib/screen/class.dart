import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class ClassScreen extends StatefulWidget {
  const ClassScreen({super.key});
  

  @override
  State<ClassScreen> createState() => _ClassScreenState();
}

class _ClassScreenState extends State<ClassScreen> {
  static const String SHEET_ID = "1bSH1WySBYYHDFROKOhxIib4296Wr_WVC_zbtXZ6fL7o";

  bool loading = true;
  String? mobile;
  Map<String, dynamic>? student;
  List recordedClasses = [];
  Map<String, dynamic>? liveClass;
  int indexNUM = 0;

  @override
  void initState() {
    super.initState();
    loadAllData();
  }

  Future<void> loadAllData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    mobile = prefs.getString('mobile');

    if (mobile == null) {
      setState(() => loading = false);
      return;
    }

    await Future.wait([
      fetchStudent(),
      fetchRecorded(),
      fetchLive(),
    ]);

    setState(() => loading = false);
  }

  Future<void> fetchStudent() async {
    final res = await http.get(
      Uri.parse('https://opensheet.elk.sh/$SHEET_ID/students'),
    );
    final List data = json.decode(res.body);

    student = data.firstWhere(
      (row) => row['mobile'] == mobile,
      orElse: () => null,
    );
  }

  Future<void> fetchRecorded() async {
    final res = await http.get(
      Uri.parse('https://opensheet.elk.sh/$SHEET_ID/recorded_classes'),
    );
    final List data = json.decode(res.body);

    recordedClasses =
        data.where((row) => row['mobile'] == mobile).toList();
  }

  Future<void> fetchLive() async {
    final res = await http.get(
      Uri.parse('https://opensheet.elk.sh/$SHEET_ID/live_class'),
    );
    final List data = json.decode(res.body);

    liveClass = data.firstWhere(
      (row) => row['mobile'] == mobile,
      orElse: () => null,
    );
  }

  void openLink(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
if (student == null) {
  return Scaffold(
    appBar: AppBar(
      title: const Text("My Class"),
      centerTitle: true,
      elevation: 0,
    ),
    body: Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.lock_outline,
              size: 70,
              color: Colors.grey,
            ),
            const SizedBox(height: 20),

            const Text(
              "Login Required",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),

            const Text(
              "Please login to access your class.\nNo student data found.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/profile');
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                "Login",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}


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

            // ================= STUDENT INFO =================
            Text(
              student!['name'],
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Subject: ${student!['subject']}",
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 25),

            // ================= RECORDED =================
            const Text(
              "Recorded Classes",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            recordedClasses.isEmpty
                ? const Text("No recorded classes available")
                : Column(
                    children: recordedClasses.map((cls) {
                      return Card(
                        child: ListTile(
                          leading: const Icon(Icons.play_circle_fill),
                          title: Text(cls['title']),
                          subtitle: Text(cls['duration']),
                          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                          onTap: () => openLink(cls['video_link']),
                        ),
                      );
                    }).toList(),
                  ),

            const SizedBox(height: 25),

            // ================= LIVE =================
            const Text(
              "Live Class",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            liveClass == null
                ? const Text("No live class scheduled")
                : Card(
                    color: Colors.blue.shade50,
                    child: ListTile(
                      leading: const Icon(Icons.video_call, color: Colors.blue),
                      title: Text(liveClass!['title']),
                      subtitle: Text(liveClass!['time']),
                      trailing: ElevatedButton(
                        onPressed: () => openLink(liveClass!['live_link']),
                        child: const Text("Join"),
                      ),
                    ),
                  ),
          ],
        ),
      ),

      //bottom nav
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Home",
          backgroundColor: const Color.fromARGB(255, 1, 53, 51)),

          BottomNavigationBarItem(
          icon: Icon(Icons.smart_toy),
          label: "MAAI",
          backgroundColor: const Color.fromARGB(255, 1, 53, 51)),
        
          
          BottomNavigationBarItem(
          icon: Icon(Icons.school_outlined),
          label: "class",
          backgroundColor: const Color.fromARGB(255, 1, 53, 51)),

          BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: "Setting",
          backgroundColor: const Color.fromARGB(255, 1, 53, 51))
      ],
      
      currentIndex:  indexNUM,
      onTap: (int index){
        if (index == 1){
          Navigator.pushNamed(context, '/maai');
        }   
        else if (index ==0){
          Navigator.pushNamed(context, '/');
        }  

        else if (index ==2){
          Navigator.pushNamed(context, '/class');
        } 
        else if (index ==3){
          Navigator.pushNamed(context, '/setting');
        }        
        setState((){
          indexNUM = index;
        });
      },
      ),
    );
  }
}
