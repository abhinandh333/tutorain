import 'package:flutter/material.dart';
 

class Maai extends StatefulWidget {
  const Maai({super.key});

  @override
  State<Maai> createState() => _MaaiState();
}

class _MaaiState extends State<Maai> {
  int indexNUM = 1; // MAAI selected

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MAAI"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 72, 126, 72),
      ),



  body: SingleChildScrollView(
  child: Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [

        // 🔷 Heading
        const Text(
          "Welcome to Tutorain",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          "Scan your answer to check its correctness with MAAI — MA's AI.",
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),

        const SizedBox(height: 24),

        // 🖼 Scan Image Card
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F6F8),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.document_scanner,
                        size: 60, color: Colors.green),
                    SizedBox(height: 10),
                    Text(
                      "Scan or Upload Your Answer",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // 📷 Scan Button
              ElevatedButton.icon(
                onPressed: () {
                  // TODO: Image picker logic
                },
                icon: const Icon(Icons.camera_alt),
                label: const Text("Scan Image"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding:
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 32),

        // 🚀 Join Tutorain Button
        Container(
          height: 60,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color.fromARGB(255, 72, 126, 72),
                Color.fromARGB(255, 45, 90, 45),
              ],
            ),
            borderRadius: BorderRadius.circular(18),
          ),
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/join');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
            child: const Text(
              "Join Tutorain for Live Classes"
,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),

      ],
    ),
  ),
),



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
  }
}

