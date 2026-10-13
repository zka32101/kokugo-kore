import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screens/splash_screen.dart';
import 'widgets/startup_splash.dart';
import 'services/revenue_cat_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 初期化（Firebase・広告・課金）の間は組織ロゴの起動画面を出す。
  // 初期化後の本物の runApp で置き換わる。
  runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: StartupSplash()));

  // 起動をネットワーク待ちで止めない: 各初期化にタイムアウトを付ける
  // （審査端末の低速/オフライン対策。タイムアウトしてもアプリは起動する）
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    ).timeout(const Duration(seconds: 5));
  } catch (e) {
    debugPrint('Firebase init failed: $e');
  }

  try {
    await RevenueCatService().initialize().timeout(const Duration(seconds: 5));
  } catch (e) {
    debugPrint('RevenueCat init failed: $e');
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
