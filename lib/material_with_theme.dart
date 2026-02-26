import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gia_pha_so/app/config/theme_config.dart';
import 'package:gia_pha_so/route/routes.dart';
import 'package:gia_pha_so/src/presentation/provider/bloc/bubble_bloc.dart';
import 'package:gia_pha_so/src/presentation/provider/bloc/theme_bloc.dart';
import 'package:gia_pha_so/src/presentation/widget/buddle_float_button/bubble_floating_button.dart';

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
    final bubbleService = context.watch<BubbleBloc>().state;
    return MaterialApp(
      title: 'Image Converter',
      theme: MyThemes.lightThemeData,
      darkTheme: MyThemes.darkThemeData,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      initialRoute: RouteNames.login, // Hoặc RouteNames.login
      onGenerateRoute: AppRoutes.generateRoute,
      navigatorKey: NavigationService.navigatorKey,
      builder: (context, child) {
        return Stack(
          children: [
            child!,
            DraggableFloatingButton(
              visible: bubbleService.isVisible,
              snapToEdge: bubbleService.snapToEdge,
              onTap: bubbleService.onTap,
              child: BubbleButton(
                onTap: bubbleService.onTap,
                icon: bubbleService.icon,
                color: bubbleService.color,
              ),
            ),
          ],
        );
      },
    );
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
