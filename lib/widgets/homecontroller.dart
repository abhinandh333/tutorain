import 'dart:async';
import 'package:flutter/material.dart';
import '../screen/ai_pulse_icon.dart';
import 'package:tutorain_app/screen/url_launcher.dart';






class Homecontroller extends StatefulWidget {
  const Homecontroller({super.key});

  @override
  State<Homecontroller> createState() => _HomecontrollerState();
}

class _HomecontrollerState extends State<Homecontroller> {
  int indexNUM = 0;
  int _currentPage = 0;

  final PageController _pageController = PageController();

  final List<Map<String, String>> banners = [
    {
      "image": "assets/images/banner1.png",
      "route": "/class",
    },
    {
      "image": "assets/images/banner2.png",
      "route": "/class",
    },
    {
      "image": "assets/images/banner3.png",
      "route": "/join",
    },
    {
      "image": "assets/images/banner4.png",
      "route": "/join",
    },
        {
      "image": "assets/images/banner5.png",
      "route": "/maai",
    },
        {
      "image": "assets/images/banner6.png",
      "route": "/maai",
    },
    
  ];

  @override
  void initState() {
    super.initState();

    // AUTO SLIDE TIMER
    Timer.periodic(const Duration(seconds: 2), (timer) {
      if (!mounted) return;

      _currentPage = (_currentPage + 1) % banners.length;
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text(
        "Tutorain",
        style: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          letterSpacing: 1.2,
        ),
      ),
      centerTitle: true,
      backgroundColor: const Color.fromARGB(255, 72, 126, 72),
    ),
    drawer: Drawer(
      child: ListView(
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text("Abhinandh"),
            accountEmail: Text("abhi@gmail.com"),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text("Profile"),
            onTap: () => Navigator.pushNamed(context, '/profile'),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text("Setting"),
            onTap: () => Navigator.pushNamed(context, '/setting'),
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Sign Out"),
            onTap: () => Navigator.pushNamed(context, '/signout'),
          ),
        ],
      ),
    ),

    // ---------------- BODY ----------------
    body: SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20),

          // ---------- AUTO SLIDER ----------
          SizedBox(
            height: 250,
            width: double.infinity,
            child: PageView.builder(
              controller: _pageController,
              itemCount: banners.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, banners[index]["route"]!);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        banners[index]["image"]!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // ---------- DOT INDICATOR ----------
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(banners.length, (index) {
              return Container(
                margin: const EdgeInsets.all(4),
                width: _currentPage == index ? 10 : 6,
                height: _currentPage == index ? 10 : 6,
                decoration: BoxDecoration(
                  color: _currentPage == index ? Colors.green : Colors.grey,
                  shape: BoxShape.circle,
                ),
              );
            }),
          ),

          const SizedBox(height: 20),

          const Text(
            "Welcome to Tutorain 👋",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 20),

          // ---------- JOIN CLASS BANNER ----------
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GestureDetector(
              onTap: () => Navigator.pushNamed(context, '/join'),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 21, 114, 56),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: Offset(2, 4),
                    ),
                  ],
                ),
                child: const Text(
                  "Join Our live Class Now!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.2,
                    shadows: [
                      Shadow(
                        offset: Offset(2, 2),
                        blurRadius: 4,
                        color: Colors.black38,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 30),

          // maai banner
        const SizedBox(height: 20),

// ---------- MAAI BANNER ----------
GestureDetector(
  onTap: () {
    Navigator.pushNamed(context, '/maai');
  },
  child: Container(
    margin: const EdgeInsets.symmetric(horizontal: 16),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      boxShadow: const [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 6,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.asset(
        'assets/images/banner7.png',
        fit: BoxFit.cover,
        width: double.infinity,
        height: 170,
      ),
    ),
  ),
),

const SizedBox(height: 30),





//maai describtion

Padding(
  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  child: Text(
    "MAAI is Tutorain’s AI-powered answer checker that analyzes student responses through image scanning and smart comparison.",
    textAlign: TextAlign.center,
    style: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w500,
      color: Colors.black87,
      height: 1.5,
    ),
  ),
),




Column(
  children: [
    const AiPulseIcon(),
    const SizedBox(height: 12),

    ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, '/maai');
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 119, 22, 143),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: const Text(
        "Use MAAI",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ),

        // 🔹 Animated Help Footer (FIXED POSITION)
    const AnimatedHelpFooter(),
  ],
),

 const SizedBox(height: 20),

      



// help 2


  ],
      ),
    ),



//maai page







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
      
      currentIndex: indexNUM,
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
}}