import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screens/splash_screen.dart';
import 'widgets/startup_splash.dart';
import 'services/ad_service.dart';
import 'services/revenue_cat_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 初期化（Firebase・広告・課金）の間は組織ロゴの起動画面を出す。
  // 初期化後の本物の runApp で置き換わる。
  runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: StartupSplash()));

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    debugPrint('Firebase init failed: $e');
  }

  try {
    await AdService.initialize();
  } catch (e) {
    debugPrint('AdMob init failed: $e');
  }

  try {
    await RevenueCatService().initialize();
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
