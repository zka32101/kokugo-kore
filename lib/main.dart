import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    debugPrint('Firebase init failed: $e');
  }
  
  runApp(
    const ProviderScope(
      child: KokugoKoreApp(),
    ),
  );
}

class KokugoKoreApp extends StatelessWidget {
  const KokugoKoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '小学コレ！国語',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
