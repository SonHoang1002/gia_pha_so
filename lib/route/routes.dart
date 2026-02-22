import 'package:flutter/material.dart';
import 'package:gia_pha_so/src/presentation/screen/family_tree_page.dart';
import 'package:gia_pha_so/src/presentation/screen/home_page.dart';
import 'package:gia_pha_so/src/presentation/screen/auth_page.dart';
import 'package:gia_pha_so/src/presentation/screen/root_page.dart';

class RouteNames {
  // Auth Routes
  static const String root = '/';
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String forgotPassword = '/forgot-password';
  static const String resetPassword = '/reset-password';

  // Main App Routes
  static const String home = '/home';
  static const String dashboard = '/dashboard';

  // Family Routes
  static const String familyTree = '/family-tree';
  static const String familyMembers = '/family-members';
  static const String familyDetail = '/family-detail';
  static const String createFamily = '/create-family';
  static const String editFamily = '/edit-family';

  // Person Routes
  static const String personList = '/persons';
  static const String personDetail = '/person-detail';
  static const String createPerson = '/create-person';
  static const String editPerson = '/edit-person';
  static const String personTimeline = '/person-timeline';
  static const String personDocuments = '/person-documents';

  // Relationship Routes
  static const String addRelationship = '/add-relationship';
  static const String editRelationship = '/edit-relationship';

  // Event Routes
  static const String events = '/events';
  static const String eventDetail = '/event-detail';
  static const String createEvent = '/create-event';

  // Document Routes
  static const String documents = '/documents';
  static const String documentDetail = '/document-detail';
  static const String uploadDocument = '/upload-document';

  // Profile Routes
  static const String profile = '/profile';
  static const String editProfile = '/edit-profile';
  static const String settings = '/settings';
  static const String about = '/about';

  // Utility Routes
  static const String search = '/search';
  static const String notifications = '/notifications';
  static const String importExport = '/import-export';
  static const String help = '/help';

  // Route helper methods
  static String personDetailWithId(String id) => '$personDetail/$id';
  static String editPersonWithId(String id) => '$editPerson/$id';
  static String familyDetailWithId(String id) => '$familyDetail/$id';
  static String editFamilyWithId(String id) => '$editFamily/$id';
}

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // Main Routes
      case RouteNames.root:
        return _buildRoute(settings, const RootScreen());
      case RouteNames.home:
        return _buildRoute(settings, const HomeScreen());

      // Family Routes
      case RouteNames.familyTree:
        return _buildRoute(settings, const FamilyTreeScreen());
      // case RouteNames.familyMembers:
      //   return _buildRoute(settings, const FamilyMembersScreen());
      // case RouteNames.familyDetail:
      //   final args = settings.arguments as Map<String, dynamic>?;
      //   return _buildRoute(
      //     settings,
      //     FamilyDetailScreen(familyId: args?['familyId'] ?? ''),
      //   );
      // case RouteNames.createFamily:
      //   return _buildRoute(settings, const PersonFormScreen(isEdit: false));

      // // Person Routes
      // case RouteNames.personList:
      //   return _buildRoute(settings, const PersonListScreen());
      // case RouteNames.personDetail:
      //   final args = settings.arguments as Map<String, dynamic>?;
      //   return _buildRoute(
      //     settings,
      //     PersonDetailScreen(personId: args?['personId'] ?? ''),
      //   );
      // case RouteNames.createPerson:
      //   return _buildRoute(
      //     settings,
      //     PersonFormScreen(
      //       isEdit: false,
      //       familyId: (settings.arguments as Map<String, dynamic>?)?['familyId'],
      //     ),
      //   );
      // case RouteNames.editPerson:
      //   final args = settings.arguments as Map<String, dynamic>?;
      //   return _buildRoute(
      //     settings,
      //     PersonFormScreen(
      //       isEdit: true,
      //       personId: args?['personId'] ?? '',
      //     ),
      //   );

      // // Profile Routes
      // case RouteNames.profile:
      //   return _buildRoute(settings, const ProfileScreen());
      // case RouteNames.settings:
      //   return _buildRoute(settings, const SettingsScreen());

      // // Default route (Splash/Login)
      default:
        return _buildRoute(
          settings,
          const AuthScreen(), // Hoặc SplashScreen nếu có
        );
    }
  }

  static MaterialPageRoute _buildRoute(RouteSettings settings, Widget screen) {
    return MaterialPageRoute(builder: (_) => screen, settings: settings);
  }
}
