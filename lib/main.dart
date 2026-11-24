import 'package:flutter/material.dart';

void main() {
  runApp(const ShaadiAIApp());
}

class ShaadiAIApp extends StatelessWidget {
  const ShaadiAIApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shaadi AI',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF8B1538),
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F0),
      appBar: AppBar(
        backgroundColor: const Color(0xFF72152F),
        foregroundColor: Colors.white,
        title: const Text('Shaadi AI'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            const Icon(
              Icons.favorite,
              size: 75,
              color: Color(0xFFB8860B),
            ),
            const SizedBox(height: 15),
            const Text(
              'Create Your Dream Wedding Invitation',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF72152F),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Premium Wedding Cards & Cinematic Videos',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.video_library),
              label: const Text('Create Wedding Video'),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.card_giftcard),
              label: const Text('Create Digital Invitation Card'),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.photo_library),
              label: const Text('My Projects'),
            ),
            const SizedBox(height: 35),
            const Text(
              'Choose Your Style',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF72152F),
              ),
            ),
            const SizedBox(height: 15),
            const ThemeTile(
              title: 'Royal Red & Gold',
              subtitle: 'Traditional royal wedding look',
              icon: Icons.diamond,
            ),
            const ThemeTile(
              title: 'Floral Pastel',
              subtitle: 'Elegant floral invitation',
              icon: Icons.local_florist,
            ),
            const ThemeTile(
              title: 'Modern Luxury',
              subtitle: 'Premium cinematic style',
              icon: Icons.auto_awesome,
            ),
          ],
        ),
      ),
    );
  }
}

class ThemeTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const ThemeTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF8B1538)),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }
}
