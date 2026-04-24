import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/db/objectbox.dart';
import 'core/router/router.dart';
import 'core/theme/app_theme.dart';

late ObjectBox objectbox;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  objectbox = await ObjectBox.create();

  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'MyKayak',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark(),
      routerConfig: goRouter,
    );
  }
}
