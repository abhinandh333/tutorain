import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AnimatedHelpFooter extends StatefulWidget {
  const AnimatedHelpFooter({super.key});

  @override
  State<AnimatedHelpFooter> createState() => _AnimatedHelpFooterState();
}

class _AnimatedHelpFooterState extends State<AnimatedHelpFooter>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _openWhatsApp() async {
    final uri = Uri.parse("https://wa.me/919497200270");
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  Future<void> _openEmail() async {
    final uri = Uri.parse("mailto:tutorain333@gmail.com");
    await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12, top: 10),
        child: Column(
          children: [
            // 🔹 Any help text
            Text(
              "Any help?",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade700,
              ),
            ),

            const SizedBox(height: 6),

            // 🔹 Contact row
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 10,
              children: [
                GestureDetector(
                  onTap: _openWhatsApp,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.chat, size: 16, color: Colors.green),
                      SizedBox(width: 4),
                      Text(
                        "+91 9497200270",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.green,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const Text("|", style: TextStyle(fontSize: 12)),
                GestureDetector(
                  onTap: _openEmail,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.email_outlined,
                          size: 16, color: Colors.blueGrey),
                      SizedBox(width: 4),
                      Text(
                        "tutorain333@gmail.com",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
