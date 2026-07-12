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
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'AI'),
          BottomNavigationBarItem(icon: Icon(Icons.note), label: '筆記'),
          BottomNavigationBarItem(icon: Icon(Icons.trending_up), label: '股市'),
          BottomNavigationBarItem(icon: Icon(Icons.flag), label: '挑戰'),
        ],
      ),
      body: Center(
        child: Text(_selectedIndex == 0 ? '今日總覽' : '頁面 $_selectedIndex'),
      ),
    );
  }
}
