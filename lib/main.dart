import 'package:flutter/material.dart';
import 'widgets/homecontroller.dart';
import 'screen/maai.dart';
import 'screen/class.dart';
import 'screen/profile.dart';
import 'screen/setting.dart';
import 'screen/signout.dart';
import 'screen/video.dart';
import 'screen/join.dart';
import 'screen/splash.dart';





void main() {
  runApp(Tutorain());
}

class Tutorain extends StatelessWidget {
  const Tutorain({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Tutorain",
      routes: {
        '/' :(context) => const Homecontroller(),
        '/maai' :(context) => const Maai(),
        '/class' :(context) =>const  ClassScreen(),
        '/setting' :(context) =>const  Setting(),
        '/profile' :(context) => const Profile(),
        '/signout' :(context) => const Signout(),
        '/video' :(context) => const Video(),
        '/join' :(context) => const Join(),
        '/splash': (context) => const Splash(),

              },
      initialRoute: '/splash',

      //home: Homecontroller(), 
      
    );
  }
}
