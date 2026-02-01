

// ignore: constant_identifier_names
const BASE_URL_API = "http://localhost:8080";

const String _envDevelopment = 'development';
const String _envStaging = 'staging';
const String _envProduction = 'production';

/// Current environment
String _currentEnvironment = _envDevelopment;

/// API Base URLs for different environments
final Map<String, String> _baseUrls = {
  _envDevelopment: 'http://localhost:3000/api/v1',
  _envStaging: 'https://staging-api.myboardgame.com/api/v1',
  _envProduction: 'https://api.myboardgame.com/api/v1',
};

/// Socket URLs for different environments
final Map<String, String> _socketUrls = {
  _envDevelopment: 'ws://localhost:3000',
  _envStaging: 'wss://staging-socket.myboardgame.com',
  _envProduction: 'wss://socket.myboardgame.com',
};

/// CDN URLs for media
final Map<String, String> _cdnUrls = {
  _envDevelopment: 'http://localhost:3000/cdn',
  _envStaging: 'https://cdn-staging.myboardgame.com',
  _envProduction: 'https://cdn.myboardgame.com',
};

/// API Timeout configurations
final Map<String, Duration> _timeouts = {
  'connectTimeout': const Duration(seconds: 30),
  'sendTimeout': const Duration(seconds: 30),
  'receiveTimeout': const Duration(seconds: 30),
};

/// API Headers
const Map<String, String> defaultHeaders = {
  'Content-Type': 'application/json',
  'Accept': 'application/json',
  'Accept-Language': 'en',
  'User-Agent': 'MyBoardGame/1.0.0',
};

/// Query Parameters
const Map<String, dynamic> defaultQueryParams = {
  'platform': 'flutter',
  'version': '1.0.0',
};

/// Get current environment
String get currentEnvironment => _currentEnvironment;

/// Get base URL for current environment
String get baseUrl => _baseUrls[_currentEnvironment]!;

/// Get socket URL for current environment
String get socketUrl => _socketUrls[_currentEnvironment]!;

/// Get CDN URL for current environment
String get cdnUrl => _cdnUrls[_currentEnvironment]!;

/// Get timeout durations
Map<String, Duration> get timeouts => _timeouts;

 
 
 
 
 
/// API Endpoints
class Endpoints {
  // Authentication
  static const String authLogin = '/auth/login';
  static const String authRegister = '/auth/register';
  static const String authLogout = '/auth/logout';
  static const String authRefreshToken = '/auth/refresh-token';
  static const String authVerifyOtp = '/auth/verify-otp';
  static const String authForgotPassword = '/auth/forgot-password';
  static const String authResetPassword = '/auth/reset-password';
  static const String authChangePassword = '/auth/change-password';

  // User Management
  static const String users = '/users';
  static const String usersMe = "/users/me";
  static const String userProfile = '/users/profile';
  static const String userStats = '/users/stats';
  static const String userUpdateProfile = '/users/update-profile';
  static const String userUpdateAvatar = '/users/update-avatar';
  static const String userSearch = '/users/search';
  static const String userFriends = '/users/friends';
  static const String userLeaderboard = '/users/leaderboard';

  // Game Management
  static const String games = '/games';
  static const String gamesActionCreate = '/games/create';
  static const String gamesActionJoin = '/games/join';
  static const String gameActionLeave = '/games/leave';
  static const String gameHistory = '/games/history';
  static const String gameStatistics = '/games/statistics';
  static const String gameLeaderboard = '/games/leaderboard';
  static const String gameRooms = '/games/rooms';
  static const String gameInvitations = '/games/invitations';

  // Chat & Messaging
  static const String chatMessages = '/chat/messages';
  static const String chatRooms = '/chat/rooms';
  static const String chatUnread = '/chat/unread-count';
  static const String chatMarkAsRead = '/chat/mark-as-read';

  // Notifications
  static const String notifications = '/notifications';
  static const String notificationCount = '/notifications/count';
  static const String markNotificationAsRead = '/notifications/mark-as-read';

  // Payments & Transactions
  static const String payments = '/payments';
  static const String createOrder = '/payments/create-order';
  static const String verifyPayment = '/payments/verify';
  static const String transactionHistory = '/payments/transactions';
  static const String goldPackages = '/payments/gold-packages';

  // Inventory & Items
  static const String inventory = '/inventory';
  static const String items = '/items';
  static const String shop = '/shop';
  static const String purchaseItem = '/shop/purchase';
  static const String equipItem = '/inventory/equip';

  // Social Features
  static const String friends = '/social/friends';
  static const String friendRequests = '/social/friend-requests';
  static const String sendFriendRequest = '/social/send-request';
  static const String acceptFriendRequest = '/social/accept-request';
  static const String rejectFriendRequest = '/social/reject-request';
  static const String blockUser = '/social/block';
  static const String unblockUser = '/social/unblock';
  static const String guilds = '/social/guilds';
  static const String guildMembers = '/social/guilds/members';

  // System & Configuration
  static const String appConfig = '/system/config';
  static const String appVersion = '/system/version';
  static const String maintenanceStatus = '/system/maintenance';
  static const String reportIssue = '/system/report-issue';
  static const String feedback = '/system/feedback';
}

 
/// API Error Codes
class ErrorCodes {
  static const int success = 200;
  static const int created = 201;
  static const int badRequest = 400;
  static const int unauthorized = 401;
  static const int forbidden = 403;
  static const int notFound = 404;
  static const int conflict = 409;
  static const int validationError = 422;
  static const int serverError = 500;
  static const int serviceUnavailable = 503;
}

/// API Error Messages
class ErrorMessages {
  static const String networkError =
      'Network error. Please check your connection';
  static const String serverError = 'Server error. Please try again later';
  static const String timeoutError = 'Request timeout. Please try again';
  static const String unauthorized = 'Session expired. Please login again';
  static const String forbidden =
      'You do not have permission to perform this action';
  static const String notFound = 'Resource not found';
  static const String conflict = 'Resource already exists';
  static const String validationError = 'Please check your input';
  static const String unknownError = 'Unknown error occurred';
}
