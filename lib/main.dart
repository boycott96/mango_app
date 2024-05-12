import 'package:flutter/material.dart';
import 'pages/main_screen.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(debug: true, ignoreSsl: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mango',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 132, 119, 154)),
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}
