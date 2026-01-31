import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

  static final Uri _youtubeUrl = Uri.parse(
    "https://youtube.com/@tutorain333?si=R3_wOAVjRZX6tuUR",
  );

  static final Uri _emailUrl = Uri.parse(
    "mailto:tutorain333@gmail.com",
  );

  static final Uri _phoneUrl = Uri.parse(
    "tel:9497200270",
  );

  // WhatsApp (use country code, India = 91)
  static final Uri _whatsappUrl = Uri.parse(
    "https://wa.me/919497200270",
  );

  Future<void> _launch(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception("Could not launch $url");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Need Help?",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "For more details or support, contact Tutorain or watch our class videos.",
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 30),

            Card(
              child: ListTile(
                leading: const Icon(Icons.email_outlined),
                title: const Text("Email"),
                subtitle: const Text("tutorain333@gmail.com"),
                onTap: () => _launch(_emailUrl),
              ),
            ),

            Card(
              child: ListTile(
                leading: const Icon(Icons.phone_outlined),
                title: const Text("Phone"),
                subtitle: const Text("9497200270"),
                onTap: () => _launch(_phoneUrl),
              ),
            ),

            Card(
              child: ListTile(
                leading: const Icon(Icons.chat_outlined),
                title: const Text("WhatsApp"),
                subtitle: const Text("Chat with Tutorain"),
                trailing: const Icon(Icons.open_in_new),
                onTap: () => _launch(_whatsappUrl),
              ),
            ),

            Card(
              child: ListTile(
                leading: const Icon(Icons.play_circle_outline),
                title: const Text("Class Videos"),
                subtitle: const Text("Watch on YouTube"),
                trailing: const Icon(Icons.open_in_new),
                onTap: () => _launch(_youtubeUrl),
              ),
            ),

            const Spacer(),

            Center(
              child: Text(
                "© Tutorain",
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
