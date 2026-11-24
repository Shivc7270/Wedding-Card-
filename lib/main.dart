
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const ShaadiAIApp());
}

const maroon = Color(0xFF72152F);
const gold = Color(0xFFB8860B);
const cream = Color(0xFFFFF8F0);

class ShaadiAIApp extends StatelessWidget {
  const ShaadiAIApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shaadi AI',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: maroon),
        scaffoldBackgroundColor: cream,
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
      appBar: AppBar(
        title: const Text('Shaadi AI Studio'),
        centerTitle: true,
        backgroundColor: maroon,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 25),
            const Icon(Icons.favorite, size: 75, color: gold),
            const Text(
              'Create Your Dream Wedding Invitation',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: maroon,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Premium Wedding Cards & Videos',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            FilledButton.icon(
              style: FilledButton.styleFrom(backgroundColor: maroon),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const EditorScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.video_library),
              label: const Text('Create Wedding Invitation'),
            ),
            const SizedBox(height: 15),
            const Text(
              'Premium Wedding Studio',
              textAlign: TextAlign.center,
              style: TextStyle(color: gold, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            const Text(
              'Made with love • Shaadi AI',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class EditorScreen extends StatefulWidget {
  const EditorScreen({super.key});

  @override
  State<EditorScreen> createState() => _EditorScreenState();
}

class _EditorScreenState extends State<EditorScreen> {
  final groom = TextEditingController();
  final bride = TextEditingController();
  final groomFather = TextEditingController();
  final brideFather = TextEditingController();
  final venue = TextEditingController();
  final message = TextEditingController();

  final picker = ImagePicker();
  File? groomPhoto;
  File? bridePhoto;

  String theme = 'Royal Red & Gold';
  final List<Map<String, String>> events = [
    {'name': 'Tilak', 'date': '', 'place': ''},
    {'name': 'Haldi', 'date': '', 'place': ''},
    {'name': 'Wedding', 'date': '', 'place': ''},
    {'name': 'Reception', 'date': '', 'place': ''},
  ];

  Future<void> choosePhoto(bool isGroom) async {
    final image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );
    if (image == null) return;
    setState(() {
      if (isGroom) {
        groomPhoto = File(image.path);
      } else {
        bridePhoto = File(image.path);
      }
    });
  }

  void addEvent() {
    setState(() {
      events.add({'name': '', 'date': '', 'place': ''});
    });
  }

  Widget field(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 13),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }

  Widget photoPicker(String label, File? photo, bool isGroom) {
    return Expanded(
      child: InkWell(
        onTap: () => choosePhoto(isGroom),
        child: Container(
          height: 145,
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: gold),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (photo != null)
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Image.file(
                      photo,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              else
                const Icon(Icons.add_a_photo, size: 38, color: maroon),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(label),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    groom.dispose();
    bride.dispose();
    groomFather.dispose();
    brideFather.dispose();
    venue.dispose();
    message.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wedding Details'),
        backgroundColor: maroon,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Couple Photos',
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              photoPicker('Groom Photo', groomPhoto, true),
              photoPicker('Bride Photo', bridePhoto, false),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'Couple Details',
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          field('Groom Name', groom),
          field('Bride Name', bride),
          field('Groom Father Name', groomFather),
          field('Bride Father Name', brideFather),
          field('Wedding Venue / Full Address', venue),
          field('Invitation Message', message),
          const SizedBox(height: 10),
          const Text(
            'Wedding Events',
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
          ),
          ...List.generate(events.length, (index) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: events[index]['name'],
                      decoration: const InputDecoration(labelText: 'Event Name'),
                      onChanged: (v) => events[index]['name'] = v,
                    ),
                    TextFormField(
                      initialValue: events[index]['date'],
                      decoration: const InputDecoration(
                        labelText: 'Date and Time',
                        hintText: 'DD/MM/YYYY - 7:00 PM',
                      ),
                      onChanged: (v) => events[index]['date'] = v,
                    ),
                    TextFormField(
                      initialValue: events[index]['place'],
                      decoration: const InputDecoration(labelText: 'Event Place'),
                      onChanged: (v) => events[index]['place'] = v,
                    ),
                    if (index >= 4)
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            setState(() => events.removeAt(index));
                          },
                          child: const Text('Remove Event'),
                        ),
                      ),
                  ],
                ),
              ),
            );
          }),
          OutlinedButton.icon(
            onPressed: addEvent,
            icon: const Icon(Icons.add),
            label: const Text('Add Another Event'),
          ),
          const SizedBox(height: 20),
          const Text(
            'Choose Theme',
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
          ),
          DropdownButtonFormField<String>(
            value: theme,
            items: [
              'Royal Red & Gold',
              'Floral Pastel',
              'Modern Luxury',
              'Traditional Hindu',
              'Royal Blue',
            ].map((item) {
              return DropdownMenuItem(value: item, child: Text(item));
            }).toList(),
            onChanged: (value) {
              if (value != null) setState(() => theme = value);
            },
            decoration: const InputDecoration(border: OutlineInputBorder()),
          ),
          const SizedBox(height: 25),
          FilledButton.icon(
            style: FilledButton.styleFrom(backgroundColor: maroon),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PreviewScreen(
                    groom: groom.text,
                    bride: bride.text,
                    groomPhoto: groomPhoto,
                    bridePhoto: bridePhoto,
                    venue: venue.text,
                    message: message.text,
                    theme: theme,
                    events: events,
                  ),
                ),
              );
            },
            icon: const Icon(Icons.visibility),
            label: const Text('Preview Invitation'),
          ),
          const SizedBox(height: 25),
        ],
      ),
    );
  }
}

class PreviewScreen extends StatelessWidget {
  final String groom;
  final String bride;
  final String venue;
  final String message;
  final String theme;
  final File? groomPhoto;
  final File? bridePhoto;
  final List<Map<String, String>> events;

  const PreviewScreen({
    super.key,
    required this.groom,
    required this.bride,
    required this.venue,
    required this.message,
    required this.theme,
    required this.groomPhoto,
    required this.bridePhoto,
    required this.events,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Invitation Preview'),
        backgroundColor: maroon,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: gold, width: 2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                const Icon(Icons.favorite, size: 45, color: gold),
                Text(
                  theme,
                  style: const TextStyle(color: maroon, fontSize: 18),
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    if (groomPhoto != null)
                      Expanded(
                        child: Image.file(groomPhoto!, height: 110, fit: BoxFit.cover),
                      ),
                    if (bridePhoto != null)
                      Expanded(
                        child: Image.file(bridePhoto!, height: 110, fit: BoxFit.cover),
                      ),
                  ],
                ),
                const SizedBox(height: 18),
                const Text('Together with their families'),
                const SizedBox(height: 12),
                Text(
                  groom.isEmpty ? 'Groom' : groom,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: maroon,
                  ),
                ),
                const Text('&', style: TextStyle(fontSize: 24, color: gold)),
                Text(
                  bride.isEmpty ? 'Bride' : bride,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: maroon,
                  ),
                ),
                const SizedBox(height: 18),
                if (message.isNotEmpty) Text(message),
                const SizedBox(height: 15),
                ...events.map(
                  (event) => ListTile(
                    title: Text(event['name'] ?? ''),
                    subtitle: Text(
                      '${event['date'] ?? ''}\n${event['place'] ?? ''}',
                    ),
                  ),
                ),
                const Divider(),
                Text(
                  venue,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          const Text(
            'This is a preview. Video export will be added in the next stage.',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
