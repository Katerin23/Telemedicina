import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:unadtelemedicina/pages/citas_page.dart';
import 'package:unadtelemedicina/pages/conferencia_page.dart';
import 'package:unadtelemedicina/pages/home_page.dart';
import 'package:unadtelemedicina/utils/provider.dart';

import 'pages/login_page.dart';
import 'values/app_constants.dart';
import 'values/app_routes.dart';
import 'values/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
    ),
  );
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  ).then(
    (_) => runApp(
      const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Theme.of(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_)=>TextProvider(),),
      ],
      builder: (context, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'UNAD Telemedicina',
          theme: AppTheme.themeData,
          initialRoute: AppRoutes.loginScreen,
          navigatorKey: AppConstants.navigationKey,
          routes: {
            AppRoutes.loginScreen: (context) => const LoginPage(),
            AppRoutes.homeScreen: (context) => const HomePage(),
            AppRoutes.citasScreen: (context) => const CitasPage(),
            AppRoutes.conferenciaScreen: (context) => const ConferenciaPage(),
          },
        );
      },
    );
  }
}
