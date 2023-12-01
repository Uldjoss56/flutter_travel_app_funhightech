import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_travel_app/ui/model/app_model.dart';
import 'package:flutter_travel_app/ui/home/home_page.dart';
import 'package:flutter_travel_app/ui/notification/notification_list.dart';
import 'package:flutter_travel_app/ui/profile/profile_page.dart';
import 'package:flutter_travel_app/ui/search/search_page.dart';
import 'package:flutter_travel_app/ui/splash_screen.dart';
import 'package:flutter_travel_app/ui/start_page.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isFirstTime = prefs.getBool('first_time') ?? true;

  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  ).then(
    (_) {
      runApp(
        MainApp(
          isFirstTime: isFirstTime,
        ),
      );
    },
  );

  if (isFirstTime) {
    await prefs.setBool('first_time', false);
  }
}

class MainApp extends StatelessWidget {
  const MainApp({
    super.key,
    required this.isFirstTime,
  });
  final bool isFirstTime;

  final MaterialColor customSwatchColor = const MaterialColor(
    0xFFF7941F,
    <int, Color>{
      50: Color(0xFFFFF4E6),
      100: Color(0xFFFFE8CC),
      200: Color(0xFFFFDBB2),
      300: Color(0xFFFFCE99),
      400: Color(0xFFFFC17F),
      500: Color(0xFFF7941F),
      600: Color(0xFFD97E1B),
      700: Color(0xFFB76817),
      800: Color(0xFF985212),
      900: Color(0xFF7A3C0E),
    },
  );

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: AppModel()
        ..isLoadingProgramme
        ..isUserConnected,
      child: MaterialApp(
        title: 'Fun Travel',
        theme: ThemeData(
          primarySwatch: customSwatchColor,
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(
              color: Colors.white,
            ),
          ),
        ),

        initialRoute: '/',
        routes: {
          '/': (context) => SplashScreen(
                isFirstTime: isFirstTime,
              ),
          '/home': (context) => const HomePage(),
          '/start': (context) => const StartPage(),
          '/search': (context) => const SearchPage(),
          '/notifications': (context) => const NotificationListPage(),
          '/profile': (context) => const ProfilePage(),
          //'/connexion': (context) => const ConnexionPage(),
          //'/inscription': (context) => const SignUpPage(),
          //'/recovered_account': (context) => const RecoveredAccountPage(),
        },
        debugShowCheckedModeBanner: false,
        //home: const MyAutoRefreshPage(),
      ),
    );
  }
}
