import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('私人助理')),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (idx) => setState(() => _selectedIndex = idx),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.today), label: '今日'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'AI助理'),
          BottomNavigationBarItem(icon: Icon(Icons.note), label: '筆記'),
          BottomNavigationBarItem(icon: Icon(Icons.trending_up), label: '股市'),
          BottomNavigationBarItem(icon: Icon(Icons.flag), label: '挑戰'),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          const TodayScreen(),
          const ChatScreen(),
          const NotesScreen(),
          const StockScreen(),
          const ChallengeScreen(),
        ],
      ),
    );
  }
}

class TodayScreen extends StatelessWidget {
  const TodayScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => const Center(child: Text('今日總覽'));
}

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => const Center(child: Text('AI 助理'));
}

class NotesScreen extends StatelessWidget {
  const NotesScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => const Center(child: Text('筆記'));
}

class StockScreen extends StatelessWidget {
  const StockScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => const Center(child: Text('股市資訊'));
}

class ChallengeScreen extends StatelessWidget {
  const ChallengeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => const Center(child: Text('挑戰'));
}
