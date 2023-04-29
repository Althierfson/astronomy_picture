import 'package:astronomy_picture/container_injection.dart';
import 'package:astronomy_picture/features/apod/presentation/pages/apod_page.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupContainer();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Astronomy Picture',
      debugShowCheckedModeBanner: false,
      home: ApodPage(),
    );
  }
}
