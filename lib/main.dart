import 'package:flutter/material.dart';
import 'package:interndemo/core/di/di.dart';
import 'package:interndemo/feature/profile/presentation/pages/profile_page.dart';
import 'package:interndemo/feature/profile/presentation/provider/profile_page_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setup();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfilePageProvider(),
    );
  }
}
