import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotel_app/core/constants/app_constants.dart';
import 'package:hotel_app/core/services/data_service.dart';
import 'package:hotel_app/core/services/language_service.dart';
import 'package:hotel_app/features/auth/views/splash_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DataService().loadData();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final LanguageService _languageService = LanguageService();

  @override
  void initState() {
    super.initState();
    _languageService.addListener(_onLanguageChanged);
  }

  @override
  void dispose() {
    _languageService.removeListener(_onLanguageChanged);
    super.dispose();
  }

  void _onLanguageChanged() {
    setState(() {});
  }

  ThemeData _buildTheme(bool isKhmer) {
    final baseTheme = ThemeData(
      primarySwatch: Colors.purple,
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.purple,
        brightness: Brightness.light,
      ),
    );

    try {
      if (isKhmer) {
        // Use Kantumruy Pro for Khmer
        return baseTheme.copyWith(
          textTheme: GoogleFonts.kantumruyProTextTheme(baseTheme.textTheme),
        );
      } else {
        // Use Inter for English
        return baseTheme.copyWith(
          textTheme: GoogleFonts.interTextTheme(baseTheme.textTheme),
        );
      }
    } catch (e) {
      // If font loading fails, fall back to default theme
      print('Error loading Google Fonts: $e');
      return baseTheme;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isKhmer = _languageService.isKhmer;

    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      locale: _languageService.currentLocale,
      supportedLocales: const [
        Locale('en'),
        Locale('km'),
      ],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: _buildTheme(isKhmer),
      home: const SplashView(),
    );
  }
}
