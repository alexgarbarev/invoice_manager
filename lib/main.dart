import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

import 'repositories/repositories.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final repo = AppRepository();
  initializeDateFormatting();
  await SeedDataRepository(repo).seed();
  runApp(MyApp(repo: repo));
}

final darkModeNotifier = ValueNotifier<Brightness>(Brightness.light);

class MyApp extends StatelessWidget {
  final AppRepository repo;

  const MyApp({super.key, required this.repo});

  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    if (darkModeNotifier.value != brightness) {
      darkModeNotifier.value = brightness;
    }

    return Provider.value(
      value: repo,
      child: MaterialApp(
        title: 'Invoice Manager',
        theme: ThemeData(
          visualDensity: .compact,
          brightness: darkModeNotifier.value,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.green.shade300,
            brightness: darkModeNotifier.value,
          ),
          useMaterial3: true,
          splashFactory: NoSplash.splashFactory,
          listTileTheme: ListTileThemeData(contentPadding: .zero, dense: true),
          switchTheme: SwitchThemeData(padding: .zero),
          popupMenuTheme: PopupMenuThemeData(
            shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
          tabBarTheme: TabBarThemeData(dividerHeight: 0, labelPadding: .zero),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(color: Colors.grey, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: darkModeNotifier.value == .light ? Colors.grey : Colors.grey[800]!,
                width: 1,
              ),
            ),
            contentPadding: const EdgeInsets.all(8),
            filled: true,
            fillColor: Colors.transparent,
          ),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
