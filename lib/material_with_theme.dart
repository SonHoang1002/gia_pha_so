import 'package:flutter/material.dart';
import 'package:gia_pha_so/app/config/theme_config.dart';
import 'package:gia_pha_so/route/routes.dart';

class MaterialWithTheme extends StatefulWidget {
  const MaterialWithTheme({super.key});

  @override
  State<MaterialWithTheme> createState() => _MaterialWithThemeState();
}

class _MaterialWithThemeState extends State<MaterialWithTheme> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // homeWidget = const TestSharpenWidget();
    // return BlocBuilder<ThemeBloc, ThemeState>(
    //   builder: (context, theme) {
    return MaterialApp(
      title: 'Image Converter',
      theme: MyThemes.lightThemeData,
      darkTheme: MyThemes.darkThemeData,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      initialRoute: RouteNames.login, // Hoặc RouteNames.login
      onGenerateRoute: AppRoutes.generateRoute,
      // Có thể thêm navigator key để quản lý navigation từ bất kỳ đâu
      navigatorKey: NavigationService.navigatorKey,
    );
    //   },
    // );
  }

  
}


// Service để truy cập navigation từ bất kỳ đâu
class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static BuildContext? get context => navigatorKey.currentContext;

  static Future<T?> pushNamed<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) {
    return navigatorKey.currentState!.pushNamed<T>(
      routeName,
      arguments: arguments,
    );
  }

  static void pop<T extends Object?>([T? result]) {
    navigatorKey.currentState!.pop(result);
  }

  static void goToLogin() {
    navigatorKey.currentState!.pushNamedAndRemoveUntil(
      RouteNames.login,
      (route) => false,
    );
  }

  static void goToHome() {
    navigatorKey.currentState!.pushNamedAndRemoveUntil(
      RouteNames.home,
      (route) => false,
    );
  }
}

