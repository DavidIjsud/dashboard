abstract class SecureStorage {
  Future<void> setSessionId(String sessionId);
  Future<String?> getSessionId();
}
