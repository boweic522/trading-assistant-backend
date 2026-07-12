import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'api/api_client.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '私人助理',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ApiClient.authToken != null ? const HomeScreen() : const LoginScreen(),
    );
  }
}
