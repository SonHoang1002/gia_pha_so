class SocketEvents {
  static const String connect = 'connect';
  static const String disconnect = 'disconnect';
  static const String error = 'error';

  // User Events
  static const String userOnline = 'user:online';
  static const String userOffline = 'user:offline';
  static const String userStatusChange = 'user:status-change';

  // Game Events
  static const String gameCreated = 'game:created';
  static const String gameStarted = 'game:started';
  static const String gameEnded = 'game:ended';
  static const String gameMove = 'game:move';
  static const String gameInvitation = 'game:invitation';
  static const String gameChat = 'game:chat';

  // Chat Events
  static const String chatMessage = 'chat:message';
  static const String chatTyping = 'chat:typing';
  static const String chatReadReceipt = 'chat:read';

  // Notification Events
  static const String notification = 'notification';
  static const String friendRequest = 'friend:request';

  // Room Events
  static const String roomJoin = 'room:join';
  static const String roomLeave = 'room:leave';
  static const String roomMessage = 'room:message';
}
