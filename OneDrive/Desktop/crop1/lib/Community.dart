import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crop Waste Management Community',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const CommunityPage(),
    );
  }
}

// Main Community Page with Options
class CommunityPage extends StatelessWidget {
  const CommunityPage({super.key});

  void _navigateToChat(BuildContext context, String topic) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatPage(topic: topic),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crop Waste Management Community'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _buildOptionCard(
              context,
              icon: Icons.article,
              title: 'Educational Resources',
              description: 'Learn about composting and biogas.',
              color: Colors.blue.shade900,
              onTap: () => _navigateToChat(context, 'Educational Resources'),
            ),
            _buildOptionCard(
              context,
              icon: Icons.forum,
              title: 'Community Forum',
              description: 'Engage with other members.',
              color: Colors.green.shade900,
              onTap: () => _navigateToChat(context, 'Community Forum'),
            ),
            _buildOptionCard(
              context,
              icon: Icons.help_outline,
              title: 'Challenges & Solutions',
              description: 'Discuss and solve issues.',
              color: Colors.red.shade900,
              onTap: () => _navigateToChat(context, 'Challenges & Solutions'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionCard(BuildContext context,
      {required IconData icon,
      required String title,
      required String description,
      required Color color,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.white),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: const TextStyle(fontSize: 12, color: Colors.white70),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// Chat Page with Simple Messaging and TTS
class ChatPage extends StatefulWidget {
  final String topic;

  const ChatPage({required this.topic, super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<String> _messages = [];
  final TextEditingController _messageController = TextEditingController();
  final FlutterTts _flutterTts = FlutterTts();

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      setState(() {
        _messages.add(_messageController.text.trim());
      });
      _messageController.clear();
    }
  }

  void _speakMessage(String message) async {
    await _flutterTts.setLanguage("en-US");
    await _flutterTts.setPitch(1.0);
    await _flutterTts.speak(message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat: ${widget.topic}'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    child: Text('U${index + 1}'),
                  ),
                  title: Text('User ${index + 1}'),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(_messages[index]),
                      ),
                      IconButton(
                        icon: const Icon(Icons.volume_up, color: Colors.green),
                        onPressed: () => _speakMessage(_messages[index]),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: const BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                blurRadius: 5,
                color: Colors.black26,
              ),
            ]),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: 'Type your message here...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.green),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}