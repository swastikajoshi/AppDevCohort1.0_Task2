import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_theme.dart';
import 'search_screen.dart';

import 'home_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => HomeProvider()),
      ],
      child: MaterialApp(
        title: 'University Info',
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        home: const SearchScreen(),
      ),
    );
  }
}
