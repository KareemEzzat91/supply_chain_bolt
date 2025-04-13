class UserStateManager {
  static bool _isLoggedIn = false  ;
  static String _userType = ''; // 'manager' or 'distributor'

  static bool get isLoggedInUser => _isLoggedIn;
  static String get userType => _userType;

  static void login(String type) {
    _isLoggedIn = true;
    _userType = type;
  }

  static void logout() {
    _isLoggedIn = false;
    _userType = '';
  }
}
