import 'package:flutter/material.dart';
 

class Video extends StatefulWidget {
  const Video({super.key});

  @override
  State<Video> createState() => _VideoState();
}

class _VideoState extends State<Video> {
  int indexNUM = 1; // MAAI selected

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Video"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 72, 126, 72),
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
        else if (index == 0){
          Navigator.pushNamed(context, '/');
        }  

        else if (index == 2){
          Navigator.pushNamed(context, '/class');
        } 
        else {
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